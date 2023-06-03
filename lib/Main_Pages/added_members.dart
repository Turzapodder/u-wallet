import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/Shared_preferences.dart';

class AcceptedInvitationsList extends StatelessWidget {
  final String phoneNumber;
  final String? sharedValue = SharedPreferenceHelper().getValue();

  AcceptedInvitationsList({required this.phoneNumber});

  Future<List<QueryDocumentSnapshot>> getAcceptedInvitations() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('invitations')
          .where('invite_status', isEqualTo: 'Accepted')
          .where('invitee_num', isEqualTo: phoneNumber)
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
          .collection('invitations')
          .doc(invitationId)
          .delete();
      print('Invitation deleted successfully');
    } catch (e) {
      print('Error deleting invitation: $e');
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: sharedValue == "Adult" ? Color(0xFFFFAE58) : Color(0xFF2ECC71),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Accepted Invitations'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Connected Users:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Container(
              height: 400,
              child: FutureBuilder<List<QueryDocumentSnapshot>>(
                future: getAcceptedInvitations(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<QueryDocumentSnapshot> invitations = snapshot.data!;

                    if (invitations.isEmpty) {
                      return Text('No accepted invitations found');
                    }

                    return ListView.builder(
                      itemCount: invitations.length,
                      itemBuilder: (context, index) {
                        QueryDocumentSnapshot invitation = invitations[index];
                        String inviterName = invitation['inviter'];
                        String inviterNum = invitation['inviter_num'];
                        String inviteStatus = invitation['invite_status'];
                        String invitationId = invitation.id;

                        // Verify that the fields exist before accessing their values
                        inviterName = inviterName ?? '';
                        inviterNum = inviterNum ?? '';
                        inviteStatus = inviteStatus ?? '';

                        return ListTile(
                          leading: const CircleAvatar(
                            radius: 25,
                            backgroundImage:
                            AssetImage("assets/images/Avatar.png"),
                          ),
                          title: Text('$inviterName'),
                          subtitle: Text('$inviterNum'),
                          trailing: InkWell(
                            onTap: (){
                              deleteInvitation(invitationId);
                              
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: sharedValue == "Adult" ? Color(0xFFFFAE58) : Color(0xFF2ECC71),
                              ),
                              child: Text("Remove", style: TextStyle(color: Colors.white),),
                            ),
                          )
                        );
                      },
                    );
                  } else {
                    return Text('No accepted invitations found');
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
