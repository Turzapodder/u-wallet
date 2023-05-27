import 'package:contacts_service/contacts_service.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
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
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();
  List<Contact> invited = [];


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
        onPressed: () {
        },
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
        onPressed: () {
        },
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
      filteredContacts = List.from(contacts); // Initialize filteredContacts with contacts
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
          backgroundColor: sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
          backgroundImage: image,
          child: null,
        );
      } catch (e) {
        print('Error loading image for contact: $e');
      }
    }

    return CircleAvatar(
      radius: 22,
      backgroundColor: sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
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
          backgroundColor: sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
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
                  prefixIcon: Icon(Icons.search, color: Colors.black12,),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.black12),
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
                    final phoneNumber =
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
                            onTap: (){
                            setState(() {
                              if(invited.contains(filteredContacts[index])){
                                invited.remove(filteredContacts[index]);
                                showTopSnackBar2(context);
                              }
                              else{
                                invited.add(filteredContacts[index]);
                                showTopSnackBar(context);
                              };
                            });
                            print(invited.map((contact) => contact.givenName).toList());
                              },
                            child: Text(
                              invited.contains(filteredContacts[index])?"Invited":'+ Add/Invite',
                              style: TextStyle(
                                fontFamily: 'Titillium Web',
                                fontSize: 14,
                                color: invited.contains(filteredContacts[index])?Color(0xFFFFAE58):Color(0xFF2ECC71),
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
}
