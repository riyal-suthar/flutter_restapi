import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      // maxRadius: 112,
                      // minRadius: 30,
                      radius: 35,
                      backgroundImage: NetworkImage(
                          "https://tse3.mm.bing.net/th?id=OIP.Sy8clwLTkP2DO5tCB6m-IgAAAA&pid=Api&P=0",
                          scale: 2.0),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "{customer?.email}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          Text(
                            "Address:\nExcel ptp,\nIncome Tax road,\nAmdavad",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ]),
                  ],
                )),
          ),
          ListTile(
            // tileColor: Colors.black87,
            leading: Icon(
              Icons.logout,
              color: CupertinoColors.black,
            ),
            title: const Text(
              'Log out',
              style: TextStyle(
                  fontSize: 25,
                  // fontWeight: FontWeight.w500,
                  color: CupertinoColors.white),
              textAlign: TextAlign.center,
            ),
            onTap: () {
              // FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
