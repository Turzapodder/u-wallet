import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:uwallet/Dahsboard_Container.dart';
import 'package:uwallet/Main_Pages/Dashboard.dart';

import '../utils/Shared_preferences.dart';

class RequestList extends StatelessWidget {
  final String phoneNumber;
  final String? sharedValue = SharedPreferenceHelper().getValue();

  RequestList({required this.phoneNumber});

  Future<List<QueryDocumentSnapshot>> getRequests() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('requests')
          .where('req_sender_num', isEqualTo: phoneNumber)
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
      await FirebaseFirestore.instance.collection('requests').doc(docId).delete();
      print('Request deleted successfully');
    } catch (e) {
      print('Error deleting request: $e');
    }
  }


  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF2ECC71),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DashboardContainer()));
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
            Text("Requested Users:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
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
                        String requesterName = reqs['request_name'];
                        String request_num = reqs['request_num'];
                        String amount = reqs['amount'];
                        String request_status = reqs['status'];
                        String requestId = reqs.id;

                        requesterName = requesterName ?? '';
                        request_num = request_num ?? '';
                        request_status = request_status ?? '';

                        return ListTile(
                            leading: const CircleAvatar(
                              radius: 25,
                              backgroundImage:
                              AssetImage("assets/images/Avatar.png"),
                            ),
                            title: Text('$requesterName'),
                            subtitle: Text('$request_num - \৳ $amount'),
                            trailing: request_status=="not_approved"?IconButton(
                              icon: Icon(
                                AntDesign.closecircle,
                                size: 25,
                              ),
                              color: Colors.redAccent,
                              onPressed: () {
                                deleteRequest(requestId);
                              },
                            ):Icon(AntDesign.checkcircle, size: 25, color: Colors.greenAccent,)
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
