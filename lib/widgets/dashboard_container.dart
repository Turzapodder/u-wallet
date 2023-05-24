import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';

class dashboard_container extends StatelessWidget {
  const dashboard_container({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.compare_arrows, color: Colors.white,),
                onPressed: () {
                  // Add your onPressed logic here
                },
              ),
              Text("Transfer", style: TextStyle(fontSize: 12, color: Colors.white),),
            ],
          ),
          Container(
            height: 40, // Set the desired height for the VerticalDivider container
            child: VerticalDivider(
              color: Colors.white60,
              thickness: 1,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(MaterialCommunityIcons.wallet_outline, color: Colors.white, size: 30,),
                onPressed: () {
                  // Add your onPressed logic here
                },
              ),
              Text("Add Money",style: TextStyle(fontSize: 12, color: Colors.white)),
            ],
          ),
          Container(
            height: 40, // Set the desired height for the VerticalDivider container
            child: VerticalDivider(
              color: Colors.white60,
              thickness: 1,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.history_outlined, color: Colors.white, size: 30,),
                onPressed: () {
                  // Add your onPressed logic here
                },
              ),
              Text("History", style: TextStyle(fontSize: 12, color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
