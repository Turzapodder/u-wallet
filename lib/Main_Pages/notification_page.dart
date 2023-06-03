import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';

import '../utils/Shared_preferences.dart';

class NotitcationTap extends StatefulWidget {
  NotitcationTap({Key? key}) : super(key: key);

  @override
  _NotitcationTapState createState() => _NotitcationTapState();
}

class _NotitcationTapState extends State<NotitcationTap> {
  final String? sharedValue = SharedPreferenceHelper().getValue();
  final String? phoneNumber = SharedPreferenceHelper().getUserPhone();
  List<DocumentSnapshot> invitations = [];
  String? inviterProfileUrl;

  @override
  void initState() {
    super.initState();
    fetchInvitations();
  }

  Future<void> updateInviteStatus(String inviterNum, String inviteeNum) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('invitations')
          .where('inviter_num', isEqualTo: inviterNum)
          .where('invitee_num', isEqualTo: inviteeNum)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot document = querySnapshot.docs.first;
        await FirebaseFirestore.instance
            .collection('invitations')
            .doc(document.id)
            .update({'invite_status': 'Accepted'});
        // Refresh the invitations list after updating the invite status
        fetchInvitations();
      } else {
        print('No matching document found');
      }
    } catch (e) {
      print('Error updating invite status: $e');
    }
  }

  Future<void> deleteInvitation(String inviterNum, String inviteeNum) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('invitations')
          .where('inviter_num', isEqualTo: inviterNum)
          .where('invitee_num', isEqualTo: inviteeNum)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot document = querySnapshot.docs.first;
        await FirebaseFirestore.instance
            .collection('invitations')
            .doc(document.id)
            .delete();
        // Refresh the invitations list after deleting the invitation
        fetchInvitations();
      } else {
        print('No matching document found');
      }
    } catch (e) {
      print('Error deleting invitation: $e');
    }
  }


  Future<List<DocumentSnapshot>> getInvitationsByPhoneNumber(
      String phoneNumber) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('invitations')
          .where('invitee_num', isEqualTo: phoneNumber)
          .get();
      return querySnapshot.docs;
    } catch (e) {
      print('Error retrieving invitations by phone number: $e');
      return [];
    }
  }




  Future<void> fetchInvitations() async {
    try {
      List<DocumentSnapshot> fetchedInvitations =
          await getInvitationsByPhoneNumber(phoneNumber!);
      setState(() {
        invitations = fetchedInvitations;
      });
    } catch (e) {
      print('Error fetching invitations: $e');
    }
  }

  List<DocumentSnapshot> getPendingInvitations() {
    return invitations
        .where((document) => document['invite_status'] != 'Accepted')
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    List<DocumentSnapshot> pendingInvitations = getPendingInvitations();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            sharedValue == "Adult" ? Color(0xFFFFAE58) : Color(0xFF2ECC71),
        title: Text(
          'Notifications',
          style: TextStyle(
              fontFamily: "Titillium Web", fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 15,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "User Request",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                //style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 10,
              ),
              pendingInvitations.length == 0
                  ? Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                        "You have No User Request at this moment",
                        style: TextStyle(
                            fontSize: 26,
                          fontWeight: FontWeight.bold,
                            ),
                      ),
                  )
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: pendingInvitations.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot invitation = pendingInvitations[index];
                        Map<String, dynamic> data =
                            invitation.data() as Map<String, dynamic>;
                        String inviterName = data['inviter'];
                        String inviterNumber = data['inviter_num'];
                        String inviteStatus = data['invite_status'];

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
                                    inviterName,
                                    style: TextStyle(
                                      color: Color(0xFF2E3E5C),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    inviterNumber,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF9FA5C0),
                                    ),
                                  ),
                                  Text(
                                    "Invited You to become Family",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF9FA5C0),
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
                                    if (inviteStatus == 'Not_accepted') {
                                      updateInviteStatus(
                                          inviterNumber, phoneNumber!);
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
                                    deleteInvitation(inviterNumber, phoneNumber!);
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
