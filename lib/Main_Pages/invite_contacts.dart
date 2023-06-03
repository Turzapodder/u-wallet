import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uwallet/utils/Shared_preferences.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final String? sharedValue = SharedPreferenceHelper().getValue();
  final String? Phone = SharedPreferenceHelper().getUserPhone();
  final String? userName = SharedPreferenceHelper().getUserName();
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getContactPermission();
  }

  final List<Flushbar> flushBars = [];
  Future show(BuildContext context, Flushbar newFlushBar) async {
    await Future.wait(flushBars.map((flushBar) => flushBar.dismiss()).toList());
    flushBars.clear();

    newFlushBar.show(context);
    flushBars.add(newFlushBar);
  }

  Future<String?> getFieldByValue(String searchValue) async {
    try {
      CollectionReference<Map<String, dynamic>> collectionRef =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await collectionRef
          .where('phoneNumber', isEqualTo: searchValue)
          .where('userType', isEqualTo: 'Adult')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            querySnapshot.docs.first;

        return documentSnapshot.get('phoneNumber') as String?;
      } else {
        return null;
      }
    } catch (e) {
      // Handle any errors
      print('Error retrieving field value: $e');
      return null;
    }
  }

  void storeInvitationData(String inviter, String inviterNum, String invitee, String inviteeNum, DateTime createdAt) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('invitations')
          .where('inviter_num', isEqualTo: inviterNum)
          .where('invitee_num', isEqualTo: inviteeNum)
          .get();

      if (querySnapshot.docs.isEmpty) {
        await FirebaseFirestore.instance.collection('invitations').doc().set({
          'inviter': inviter,
          'inviter_num': inviterNum,
          'invitee': invitee,
          'invitee_num': inviteeNum,
          'created_at': createdAt,
          'invite_status': 'Not_accepted',
        });
        print('Invitation data stored successfully!');
        showTopSnackBar(context);
      } else {
        print('Unsuccessful: Invitation already exists!');
        showToast(sharedValue!);
      }
    } catch (e) {
      print('Error storing invitation data: $e');
    }
  }


  void showTopSnackBar(BuildContext context) => show(
        context,
        Flushbar(
          icon: Icon(Icons.check_circle_rounded, size: 32, color: Colors.green),
          shouldIconPulse: false,
          message: 'Invitation Send Successfully',
          mainButton: TextButton(
            child: Text(
              '×',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            onPressed: () {},
          ),
          onTap: (_) {
            print('Clicked bar');
          },
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          margin: EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
          borderRadius: BorderRadius.circular(30),
        ),
      );
  void showTopSnackBar2(BuildContext context) => show(
        context,
        Flushbar(
          shouldIconPulse: false,
          message: 'Invitation Removed',
          mainButton: TextButton(
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                '×',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            onPressed: () {},
          ),
          onTap: (_) {
            print('Clicked bar');
          },
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          margin: EdgeInsets.fromLTRB(8, kToolbarHeight + 8, 8, 0),
          borderRadius: BorderRadius.circular(30),
        ),
      );

  void getContactPermission() async {
    if (await Permission.contacts.isGranted) {
      fetchContacts();
    } else {
      await Permission.contacts.request();
    }
  }

  void fetchContacts() async {
    contacts = await ContactsService.getContacts();
    setState(() {
      isLoading = false;
      filteredContacts =
          List.from(contacts); // Initialize filteredContacts with contacts
    });
  }

  void _filterContacts(String query) {
    if (query.isNotEmpty) {
      final lowerCaseQuery = query.toLowerCase();
      final filtered = contacts.where((contact) {
        final displayName = contact.givenName?.toLowerCase() ?? '';
        return displayName.contains(lowerCaseQuery);
      }).toList();
      setState(() {
        filteredContacts = filtered;
      });
    } else {
      setState(() {
        filteredContacts = List.from(contacts);
      });
    }
  }

  Widget _buildAvatar(Contact contact) {
    final displayName = contact.givenName ?? '';
    final avatarData = contact.avatar;
    if (avatarData != null && avatarData.isNotEmpty) {
      try {
        final image = MemoryImage(avatarData);
        return CircleAvatar(
          radius: 22,
          backgroundColor:
              sharedValue == "Adult" ? Color(0xFFFFAE58) : Color(0xFF2ECC71),
          backgroundImage: image,
          child: null,
        );
      } catch (e) {
        print('Error loading image for contact: $e');
      }
    }

    return CircleAvatar(
      radius: 22,
      backgroundColor:
          sharedValue == "Adult" ? Color(0xFFFFAE58) : Color(0xFF2ECC71),
      child: Text(
        displayName.isNotEmpty ? displayName[0].toUpperCase() : '',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          elevation: 0,
          leading: const BackButton(
            color: Colors.white,
          ),
          centerTitle: true,
          title: Text(
            "Choose Contact",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22,
              color: Colors.white,
              fontFamily: 'Titillium Web',
            ),
          ),
          backgroundColor:
              sharedValue == "Adult" ? Color(0xFFFFAE58) : Color(0xFF2ECC71),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: searchController,
                onChanged: _filterContacts,
                decoration: InputDecoration(
                  hintText: 'Search by names and numbers',
                  hintStyle: TextStyle(color: Colors.black26),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black12,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: filteredContacts.length,
                        itemBuilder: (context, index) {
                          final contact = filteredContacts[index];
                          final displayName = contact.givenName ?? '';
                          final familyName = contact.familyName ?? '';
                          String phoneNumber =
                              contact.phones?.isNotEmpty == true
                                  ? contact.phones!.first.value ?? ''
                                  : '';

                          return ListTile(
                            leading: _buildAvatar(contact),
                            title: Text(
                              "$displayName " "$familyName",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: "Titillium Web",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              phoneNumber,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                fontFamily: "Titillium Web",
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    if (phoneNumber.startsWith('+88')) {
                                      phoneNumber = phoneNumber.substring(3);
                                    } else {
                                      phoneNumber = phoneNumber;
                                    }
                                    String? fieldValue =
                                        await getFieldByValue(phoneNumber);
                                    print(fieldValue);
                                    if (fieldValue == null) {
                                      showToast3(sharedValue!);
                                    } else {
                                      storeInvitationData(
                                          userName!,
                                          Phone!,
                                          displayName + " " + familyName,
                                          phoneNumber,
                                          DateTime.now());
                                    }
                                    setState(() {});
                                  },
                                  child: Text(
                                    '+Add/Invite',
                                    style: TextStyle(
                                      fontFamily: 'Titillium Web',
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            horizontalTitleGap: 20,
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showToast3(String user) {
    Fluttertoast.showToast(
      msg: 'Sorry, This user is not registered!\n Or, This is not an Adult user',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: user == "Adult" ? Color(0xFF2ECC71) : Color(0xFFFFAE58),
      textColor: Colors.white,
    );
  }
  void showToast(String user) {
    Fluttertoast.showToast(
      msg: 'This user already has been invited',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: user == "Adult" ? Color(0xFF2ECC71) : Color(0xFFFFAE58),
      textColor: Colors.white,
    );
  }
}
