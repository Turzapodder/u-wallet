import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:uwallet/Main_Pages/payment_success.dart';

import '../Dahsboard_Container.dart';
import '../utils/Shared_preferences.dart';
import 'Dashboard.dart';

class RequestList2 extends StatelessWidget {
  final String phoneNumber;
  final String? sharedValue = SharedPreferenceHelper().getValue();
  bool refresh = false;

  RequestList2({required this.phoneNumber});

  Future<List<QueryDocumentSnapshot>> getRequests() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('requests')
          .where('request_num', isEqualTo: phoneNumber)
          .where('status', isEqualTo: 'not_approved')
          .get();

      return querySnapshot.docs;
    } catch (e) {
      print('Error retrieving accepted invitations: $e');
      return [];
    }
  }

  Future<void> deleteInvitation(String invitationId) async {
    try {
      await FirebaseFirestore.instance
          .collection('requests')
          .doc(invitationId)
          .delete();
      print('Request deleted successfully');
    } catch (e) {
      print('Error deleting invitation: $e');
    }
  }

  Future<void> deleteRequest(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('requests')
          .doc(docId)
          .delete();
      print('Request deleted successfully');
    } catch (e) {
      print('Error deleting request: $e');
    }
  }

  Future<void> uploadTransaction({
    required String receiverNum,
    required String receiverName,
    required String senderNum,
    required String senderName,
    required DateTime createdAt,
    required String amount, // Updated to string type
  }) async {
    if(senderNum!=receiverNum){
      try {
        double parsedAmount = double.parse(amount);

        CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

        // Check if the receiver exists in the user collection
        QuerySnapshot receiverQuerySnapshot =
        await usersCollection.where('phoneNumber', isEqualTo: receiverNum).get();

        if (receiverQuerySnapshot.docs.isEmpty) {
          showToast3(sharedValue!);
          return;
        }

        // Create a reference to the 'Transactions' collection
        CollectionReference transactionsCollection =
        FirebaseFirestore.instance.collection('Transactions');

        // Generate a unique document ID for the transaction
        DocumentReference newTransactionDocRef = transactionsCollection.doc();

        // Create a new transaction document
        Map<String, dynamic> transactionData = {
          'Receiver_num': receiverNum,
          'Receiver_name': receiverName,
          'Sender_num': senderNum,
          'Sender_name': senderName,
          'created_at': createdAt,
          'amount': parsedAmount, // Use the parsed amount
        };

        // Save the transaction document to Firestore
        await newTransactionDocRef.set(transactionData);

        // Update the balances of the sender and receiver
        QuerySnapshot senderQuerySnapshot =
        await usersCollection.where('phoneNumber', isEqualTo: senderNum).get();

        if (senderQuerySnapshot.docs.isNotEmpty) {
          DocumentSnapshot senderDocumentSnapshot = senderQuerySnapshot.docs.first;
          await senderDocumentSnapshot.reference.update({
            'balance': FieldValue.increment(-parsedAmount),
          });
        }

        DocumentSnapshot receiverDocumentSnapshot = receiverQuerySnapshot.docs.first;
        await receiverDocumentSnapshot.reference.update({
          'balance': FieldValue.increment(parsedAmount),
        });

        print('Transaction Updated');
      } catch (e) {
        // Handle any errors
        print('Error uploading transaction: $e');
      }
    }else{
      showToast2(sharedValue!);
    }
  }

  void showToast3(String user) {
    Fluttertoast.showToast(
      msg: 'Sorry, This user is not registered!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: user == "Adult" ? Color(0xFF2ECC71) : Color(0xFFFFAE58),
      textColor: Colors.white,
    );
  }
  void showToast2(String user) {
    Fluttertoast.showToast(
      msg: 'Warning! you cannot send money to your own account',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: user == "Adult" ? Color(0xFF2ECC71) : Color(0xFFFFAE58),
      textColor: Colors.white,
    );
  }

  Future<void> approveRequest(String reqSenderNum, String requesterNum, String reqSendername, String RequesterName, String amount, String id) async {
    try {
      // Get the current user's document snapshot
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      // Get the request sender's document snapshot
      QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: reqSenderNum)
          .get();

      // Get the current user's balance
      final userDocument = querySnapshot.docs.first;
      final userData = userDocument.data();
      double currentUserBalance =
          (userData as Map<String, dynamic>)['balance'] ?? 0;

      // Get the request sender's balance
      final userDocument2 = querySnapshot2.docs.first;
      final userData2 = userDocument2.data();
      double reqSenderBalance =
          (userData2 as Map<String, dynamic>)['balance'] ?? 0;

      // Parse the requested amount from a string to a double
      double requestedAmount = double.parse(amount);

      // Check if the requested amount is less than or equal to the current user's balance
      if (requestedAmount <= currentUserBalance) {
        // Update the current user's amount (reduce by the requested amount)
        await userDocument.reference
            .update({'balance': currentUserBalance - requestedAmount});

        // Update the request sender's amount (increase by the requested amount)
        await userDocument2.reference
            .update({'balance': reqSenderBalance + requestedAmount});



        print('Request approved and user amounts updated successfully');
        await FirebaseFirestore.instance
            .collection('requests')
            .doc(id)
            .update({'status': 'approved'});

        DateTime now = DateTime.now();

        uploadTransaction(receiverNum: reqSenderNum, receiverName: reqSendername, senderNum: requesterNum, senderName: RequesterName, createdAt: now, amount: amount);


        deleteRequest(id);


      } else {
        print('Insufficient balance for approving the request');
      }
    } catch (e) {
      print('Error approving request: $e');
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orangeAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => DashboardContainer()));
          },
        ),
        title: Text('My Request List'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Text(
              "Requested Users:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 400,
              child: FutureBuilder<List<QueryDocumentSnapshot>>(
                future: getRequests(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<QueryDocumentSnapshot> req = snapshot.data!;

                    if (req.isEmpty) {
                      return Text('No Requests found');
                    }

                    return ListView.builder(
                      itemCount: req.length,
                      itemBuilder: (context, index) {
                        QueryDocumentSnapshot reqs = req[index];
                        String req_sender_name = reqs['req_sender_name'];
                        String req_sender_num = reqs['req_sender_num'];
                        String requesterNum = reqs['request_num'];
                        String requesterName = reqs['request_name'];
                        String amount = reqs['amount'];
                        String request_status = reqs['status'];
                        String requestId = reqs.id;

                        // Verify that the fields exist before accessing their values
                        req_sender_name = req_sender_name ?? '';
                        req_sender_num = req_sender_num ?? '';
                        request_status = request_status ?? '';

                        return Row(
                          children: [
                            const CircleAvatar(
                              radius: 25,
                              backgroundImage:
                              AssetImage("assets/images/Avatar.png"),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    req_sender_name,
                                    style: TextStyle(
                                      color: Color(0xFF2E3E5C),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    req_sender_num,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF9FA5C0),
                                    ),
                                  ),
                                  Text(
                                    "Requested- \৳ $amount BDT",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.orangeAccent,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    AntDesign.checkcircleo,
                                    size: 25,
                                  ),
                                  color: Color(0xFF2ECC71),
                                  onPressed: () {
                                    if(approveRequest(req_sender_num, requesterNum, req_sender_name, requesterName, amount, requestId)==true){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => WaveContainerPage(
                                            amount: amount,
                                            Name : req_sender_name,
                                            number: req_sender_num,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    AntDesign.closecircle,
                                    size: 25,
                                  ),
                                  color: Colors.redAccent,
                                  onPressed: () {
                                    deleteInvitation(requestId);
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Text('No Requests found');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
