import 'package:flutter/material.dart';
import 'SettingsPage.dart';
import 'NotificationDetailsPage.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          size: 24,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 13),
                  Expanded(
                    child: Text(
                      "Notifications",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsPage(),
                        ),
                      );
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.0,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.settings,
                        size: 24,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount:
                      10, // Replace with the actual number of items in your list
                  itemBuilder: (context, index) {
                    final notificationDate =
                        DateTime.now().subtract(Duration(days: index));

                    // Determine the section header based on the notification date
                    String sectionHeader = '';
                    if (notificationDate.day == DateTime.now().day) {
                      sectionHeader = 'Today';
                    } else if (notificationDate.day ==
                        DateTime.now().subtract(Duration(days: 1)).day) {
                      sectionHeader = 'Yesterday';
                    } else if (notificationDate
                        .isAfter(DateTime.now().subtract(Duration(days: 7)))) {
                      sectionHeader = 'Last 7 Days';
                    }

                    // Return the section header or the list item
                    if (index == 0 || sectionHeader.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Text(
                            sectionHeader,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          ListTile(
                            title: Text('Notification $index'),
                            subtitle: Text('Description $index'),
                            leading: Icon(Icons.notifications),
                            onTap: () {
                              // Navigate to the notification details page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationDetailsPage(
                                    notificationTitle: 'Notification $index',
                                    notificationDescription:
                                        'Description $index',
                                  ),
                                ),
                              );
                            },
                          ),
                          // Additional list items under the same section
                          ListTile(
                            title: Text('Notification ${index + 1}'),
                            subtitle: Text('Description ${index + 1}'),
                            leading: Icon(Icons.notifications),
                            onTap: () {
                              // Navigate to the notification details page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationDetailsPage(
                                    notificationTitle:
                                        'Notification ${index + 1}',
                                    notificationDescription:
                                        'Description ${index + 1}',
                                  ),
                                ),
                              );
                            },
                          ),
                          ListTile(
                            title: Text('Notification ${index + 2}'),
                            subtitle: Text('Description ${index + 2}'),
                            leading: Icon(Icons.notifications),
                            onTap: () {
                              // Navigate to the notification details page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotificationDetailsPage(
                                    notificationTitle:
                                        'Notification ${index + 2}',
                                    notificationDescription:
                                        'Description ${index + 2}',
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    } else {
                      return ListTile(
                        title: Text('Notification $index'),
                        subtitle: Text('Description $index'),
                        leading: Icon(Icons.notifications),
                        onTap: () {
                          // Navigate to the notification details page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationDetailsPage(
                                notificationTitle: 'Notification $index',
                                notificationDescription: 'Description $index',
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
