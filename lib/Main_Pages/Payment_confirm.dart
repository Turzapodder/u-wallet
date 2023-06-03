import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:otp_text_field/style.dart';
import 'package:uwallet/Main_Pages/payment_success.dart';
import 'package:uwallet/Main_Pages/transaction_unsucessfull.dart';
import 'package:uwallet/utils/Shared_preferences.dart';
import 'package:otp_text_field/otp_text_field.dart';

import 'invite_contacts.dart';

class Payment_confirm_page extends StatefulWidget {
  final String displayName;
  final String familyName;
  final String phoneNumber;
  final String type;

  const Payment_confirm_page({
    Key? key,
    required this.displayName,
    required this.familyName,
    required this.phoneNumber,
    required this.type,
  }) : super(key: key);

  @override
  State<Payment_confirm_page> createState() => _Payment_confirm_pageState();
}

class _Payment_confirm_pageState extends State<Payment_confirm_page> {
  final String? sharedValue = SharedPreferenceHelper().getValue();
  final String? Phone = SharedPreferenceHelper().getUserPhone();
  final String? balance = SharedPreferenceHelper().getBalance();
  final String? name = SharedPreferenceHelper().getUserName();
  final myController = TextEditingController();
  OtpFieldController otpController = OtpFieldController();

  void initState() {
    super.initState();
  }

  Widget _buildAvatar(String displayName) {
    final NameInitials = displayName ?? '';

    return CircleAvatar(
      radius: 40,
      backgroundColor:
          sharedValue == "Adult" ? Color(0xFF2ECC71) : Color(0xFFFFAE58),
      child: Text(
        NameInitials.isNotEmpty ? displayName[0].toUpperCase() : '',
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
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

        print(receiverNum);
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

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WaveContainerPage(
              amount: amount,
              Name : receiverName,
              number: receiverNum,
            ),
          ),
        );
      } catch (e) {
        // Handle any errors
        print('Error uploading transaction: $e');
      }
    }else{
      showToast2(sharedValue!);
    }
  }

  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text(
            "Confirm Transfer",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white,
              fontFamily: 'Titillium Web',
            ),
          ),
          backgroundColor:
              sharedValue == "Adult" ? Color(0xFFFFAE58) : Color(0xFF2ECC71),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
                color: sharedValue == "Adult"
                    ? Color(0xFFFFAE58)
                    : Color(0xFF2ECC71),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildAvatar(widget.displayName),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.displayName + " " + widget.familyName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${widget.phoneNumber}',
                    style: TextStyle(
                        letterSpacing: 1.5, fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Transfer on ' +
                        DateFormat('EEEE, MMM d, yyyy').format(now).toString(),
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Set Amount",
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "How much would you like to transfer?",
                    style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.3), ),
                  ),
                  SizedBox( height: 12,),
                  TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      letterSpacing: 1.7,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
                      /*prefixText: '৳',
                      prefixStyle: TextStyle( color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),*/
                      hintText: "৳  Enter Amount",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0,
                          fontSize: 18,
                          color: Colors.black26
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(.5)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71)),
                      ),
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                    },
                    controller: myController,
                  ),
                  SizedBox( height: 40,),
                  Text("Confirm Password",style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
                  SizedBox( height: 20,),
                  Center(
                    child: Container(
                      width: 300,
                      child: OTPTextField(
                          controller: otpController,
                          length: 5,
                          width: MediaQuery.of(context).size.width,
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldWidth: 45,
                          fieldStyle: FieldStyle.underline,
                          outlineBorderRadius: 15,
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          onChanged: (pin) {
                            print("Changed: " + pin);
                          },
                          onCompleted: (pin) {
                            print("Completed: " + pin);
                          }),
                    ),
                  ),
                  SizedBox(height: 80,),
                  InkWell(
                    onTap: () {
                      String amount = myController.text;
                      double? bal = double.tryParse(balance!);
                      double? bal2 = double.tryParse(amount);
                      String rec_num = trimString(widget.phoneNumber);
                      if ((sharedValue == "Adult" && widget.type == "Adult") ||
                          (sharedValue == "Teenager" && widget.type == "Merchant") ||
                          (sharedValue == "Adult" && widget.type == "Merchant") ||
                          (sharedValue == "Teenager" && widget.type == "Adult")||
                          (sharedValue == "Adult" && widget.type == "Teenager")) {
                        if ((bal! > 0) && ((bal - bal2!) > 0)) {
                          uploadTransaction(
                            receiverNum: rec_num,
                            receiverName: widget.displayName+" "+widget.familyName,
                            senderNum: Phone!,
                            senderName: name!,
                            createdAt: DateTime.now(),
                            amount: amount,
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransactionUnsuccess(),
                            ),
                          );
                        }
                      } else {
                        showToast(sharedValue!);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
                          borderRadius: BorderRadius.circular(
                              20.0)),
                      child: Center(
                        child: Text("Transfer Money",
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String trimString(String input) {
    if (input.startsWith("+88") && input.length >= 3) {
      return input.substring(3);
    }
    return input;
  }

  void showToast(String user) {
    Fluttertoast.showToast(
      msg: 'Sorry, You are Not authorized to make this Transaction!',
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
  void showToast3(String user) {
    Fluttertoast.showToast(
      msg: 'Sorry, This user is not registered!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: user == "Adult" ? Color(0xFF2ECC71) : Color(0xFFFFAE58),
      textColor: Colors.white,
    );
  }
}
