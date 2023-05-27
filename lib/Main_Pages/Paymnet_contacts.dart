import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uwallet/contacts.dart';

import 'Payment_confirm.dart';
import '../utils/Shared_preferences.dart';

class Payment_contact extends StatefulWidget {
  const Payment_contact({Key? key}) : super(key: key);

  @override
  State<Payment_contact> createState() => Payment_contactState();
}

class Payment_contactState extends State<Payment_contact> {
final String? sharedValue = SharedPreferenceHelper().getValue();
final myController = TextEditingController();

List<Contact> contacts = [];
List<Contact> filteredContacts = [];
bool isLoading = true;
TextEditingController searchController = TextEditingController();

@override
void initState() {
  super.initState();
  getContactPermission();
}
@override
void dispose() {
  myController.dispose();
  super.dispose();
}

bool _is11DigitsEntered = false;

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
void _showContactInfo(Contact contact) {
  final displayName = contact.givenName ?? '';
  final familyName = contact.familyName ?? '';
  final phoneNumber = contact.phones?.isNotEmpty == true ? contact.phones!.first.value ?? '' : '';

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Payment_confirm_page(
        displayName: displayName,
        familyName : familyName,
        phoneNumber: phoneNumber,
      ),
    ),
  );
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
    backgroundColor: sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: AppBar(
            elevation: 0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
             onPressed: () => Navigator.pop(context),
            ),

            centerTitle: true,
            title: Text(
              "Send Money",
              style: TextStyle(fontFamily: "Titillium Web", fontWeight: FontWeight.bold),
            ),
            backgroundColor: sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft:Radius.circular(30)),
        ),
        child: Padding(
          padding: EdgeInsets.only(top:25, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Contact", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              SizedBox(height: 12.0),
              TextFormField(
                keyboardType: TextInputType.number,

                style: TextStyle(
                  letterSpacing: 1.7,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 16.0),
                  hintText: "Enter Receiver Phone Number",
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0,
                    fontSize: 15,
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
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: _is11DigitsEntered
                        ? Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 32,
                    )
                        : null,
                  ),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(11),
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (value) {
                  setState(() {
                    _is11DigitsEntered = value.length == 11;
                  });
                },
                controller: myController,
              ),
              SizedBox(height: 20,),
              Text("Your Contacts",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              SizedBox(
                height: 20,
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(top: 24),
                  decoration: BoxDecoration(
                  ),
                  height: 400,
                  child: Column(
                    children: [
                      TextField(
                        controller: searchController,
                        onChanged: _filterContacts,
                        decoration: InputDecoration(
                          hintText: 'Search by names',
                          hintStyle: TextStyle(color: Colors.black26),
                          prefixIcon: Icon(Icons.search, color: Colors.black12,),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(.5)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71)),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: isLoading
                            ? Center(
                          child: CircularProgressIndicator(
                            color: sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
                          ),
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
                              onTap: () => _showContactInfo(contact),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 1.2,
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: () {
                  String number = myController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Payment_confirm_page(
                        displayName: "Unk",
                        familyName : "nown",
                        phoneNumber: number,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 100.0,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                      color: sharedValue=="Adult"?Color(0xFFFFAE58):Color(0xFF2ECC71),
                      borderRadius: BorderRadius.circular(
                          20.0)),
                  child: Center(
                    child: Text("Continue",
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
      ),
    );
  }
}
