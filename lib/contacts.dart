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
  List<Contact> filteredContacts = [];
  bool isLoading = true;
  TextEditingController searchController = TextEditingController();

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
          backgroundColor: Color(0xFFFFAE58),
          backgroundImage: image,
          child: null,
        );
      } catch (e) {
        print('Error loading image for contact: $e');
      }
    }

    return CircleAvatar(
      radius: 22,
      backgroundColor: Color(0xFFFFAE58),
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
          backgroundColor: Color(0xFFFFAE58),
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
                    final phoneNumber =
                    contact.phones?.isNotEmpty == true
                        ? contact.phones!.first.value ?? ''
                        : '';

                    return ListTile(
                      leading: _buildAvatar(contact),
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
          ],
        ),
      ),
    );
  }
}
