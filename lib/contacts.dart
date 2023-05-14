import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getContactPermission();
  }

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          centerTitle: true,
          title: Text(
            "Choose Contact",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22,
              color: Colors.black,
              fontFamily: 'Titillium Web',
            ),
          ),
          backgroundColor: Color(0xFFFFAE58),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 24),
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
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              final displayName = contact.givenName ?? '';
              final phoneNumber = contact.phones?.isNotEmpty == true
                  ? contact.phones!.first.value ?? ''
                  : '';

              return ListTile(
                leading: CircleAvatar(
                  radius: 22,
                  child: Text(
                    displayName.isNotEmpty
                        ? displayName[0].toUpperCase()
                        : '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  backgroundColor: Color(0xFFFFAE58),
                ),
                title: Text(
                  displayName,
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
                    Text(
                      '+ Add/ Invite',
                      style: TextStyle(
                        fontFamily: 'Titillium Web',
                        fontSize: 14,
                        color: Color(0xFFFFAE58),
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
    );
  }
}
