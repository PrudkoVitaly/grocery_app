import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 143,
                  color: Colors.white,
                ),
                Expanded(
                  child: Expanded(
                    child: Container(
                      color: const Color(0XFFF4F5F9),
                      padding: EdgeInsets.only(top: 130, left: 16),
                      child: ListView(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.person_outline,
                                color: Colors.green),
                            title: const Text(
                              'About me',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Colors.grey),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: const Icon(Icons.shopping_bag_outlined,
                                color: Colors.green),
                            title: const Text('My Orders',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Colors.grey),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: const Icon(Icons.favorite_border,
                                color: Colors.green),
                            title: const Text('My Favorites',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Colors.grey),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: Icon(Icons.location_on_outlined,
                                color: Colors.green),
                            title: const Text('My Address',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Colors.grey),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: const Icon(Icons.add_card_sharp,
                                color: Colors.green),
                            title: const Text('Credit Cards',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Colors.grey),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: const Icon(Icons.transfer_within_a_station,
                                color: Colors.green),
                            title: const Text('Transactions',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Colors.grey),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: const Icon(
                                Icons.notifications_active_outlined,
                                color: Colors.green),
                            title: const Text('Notifications',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Colors.grey),
                            onTap: () {},
                          ),
                          ListTile(
                            leading:
                                const Icon(Icons.logout, color: Colors.green),
                            title: const Text('Sign out',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Positioned(
              top: 90,
              left: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage("assets/profile_img.png")),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Olivia Austin",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    "oliviaaustin@gmail.com",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
