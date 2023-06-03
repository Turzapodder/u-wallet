import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uwallet/Main_Pages/Request_money_confirm.dart';
import '../Dahsboard_Container.dart';
import '../utils/Shared_preferences.dart';


class RequestMoeny extends StatelessWidget {
  RequestMoeny({Key? key}) : super(key: key);

  final String? phone = SharedPreferenceHelper().getUserPhone();

  Future<List<QueryDocumentSnapshot>> getAcceptedInvitations() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('invitations')
          .where('invite_status', isEqualTo: 'Accepted')
          .where('inviter_num', isEqualTo: phone)
          .get();

      return querySnapshot.docs;
    } catch (e) {
      print('Error retrieving accepted invitations: $e');
      return [];
    }
  }
  Future<List<QueryDocumentSnapshot>> getNotAcceptedInvitations() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('invitations')
          .where('invite_status', isEqualTo: 'Not_accepted')
          .where('inviter_num', isEqualTo: phone)
          .get();

      return querySnapshot.docs;
    } catch (e) {
      print('Error retrieving accepted invitations: $e');
      return [];
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF2ECC71),
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 30,
              ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardContainer(),
                    ),
                  ),
                }
            ),
          ),
          title: Text(
            "Request Money",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 15),
              decoration: BoxDecoration(
                color: Color(0xFF2ECC71),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
              ),
              child: Text("Request Money from the Connected Users", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),)),
          SizedBox(height: 10,),
          Container(
            width: double.infinity,
            color: Colors.white,
            height: 200,
            padding: EdgeInsets.only(top: 15),
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
                    return Center(child: Text('No accepted invitations found'));
                  }

                  return ListView.builder(
                    itemCount: invitations.length,
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot invitation = invitations[index];
                      String inviterName = invitation['invitee'];
                      String inviterNum = invitation['invitee_num'];
                      String invitationId = invitation.id;

                      inviterName = inviterName ?? '';
                      inviterNum = inviterNum ?? '';


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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Request_confirm_page(displayName: inviterName,phoneNumber: inviterNum,),
                                ),
                              );

                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xFF2ECC71),
                              ),
                              child: Text("Request", style: TextStyle(color: Colors.white),),
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
    );
  }
}
