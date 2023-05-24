
import 'package:flutter/material.dart';

import '../widgets/custom_follow_widget.dart';
import '../widgets/custom_like_notification.dart';

class NotitcationTap extends StatelessWidget {
  NotitcationTap({Key? key}) : super(key: key);
  List newItem = ["liked", "follow"];
  List todayItem = ["follow", "liked", "liked"];

  List oldesItem = ["follow", "follow", "liked", "liked"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFFFAE58),
        title: Text(
          'Notifications',
          style: TextStyle(fontFamily: "Titillium Web", fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 15,),
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
                "New",
                //style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: newItem.length,
                itemBuilder: (context, index) {
                  return newItem[index] == "follow"
                      ? CustomFollowNotifcation()
                      : CustomLikedNotifcation();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Today",
                  //style: Theme.of(context).textTheme.headline1,
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: todayItem.length,
                itemBuilder: (context, index) {
                  return todayItem[index] == "follow"
                      ? CustomFollowNotifcation()
                      : CustomLikedNotifcation();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Oldest",
                  //style: Theme.of(context).textTheme.headline1,
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: oldesItem.length,
                itemBuilder: (context, index) {
                  return oldesItem[index] == "follow"
                      ? CustomFollowNotifcation()
                      : CustomLikedNotifcation();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}