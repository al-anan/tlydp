// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tlydp/screens/landing_screen.dart';

import '../screens/login_screen.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: buildMenuItems(context),
      
    ));
  }

  List<Widget> buildMenuItems(BuildContext context) {
    final List<String> menuTitles = [
      'Home',
      'Find a duck',
      'Log a found duck',
      'Register a new duck',
    ];
    List<Widget> menuItems = [];
    menuItems.add(Container(
      height: 200,
      child: DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.green,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('The Little Yellow Duck Project',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25)),
                SizedBox(
                  height: 10,
                ),
                Image(
                  image: AssetImage('assets/images/yellow-outlined-duck.png'),
                  width: 50,
                  height: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Ducks to be found: ',
                    style: TextStyle(fontSize: 14, color: Colors.white))
              ])),
    ));
    menuTitles.forEach((String element) {
      Widget screen = Container();
      menuItems.add(ListTile(
          title: Text(element, style: TextStyle(fontSize: 18)),
          onTap: () {
            switch (element) {
              case 'Home':
                screen = LoginScreen();
                break;
              case 'Find a duck':
                screen = LandingScreen();
                break;
              case 'Log a found duck':
                screen = LandingScreen();
                break;
              case 'Register a new duck':
                screen = LandingScreen();
                break;
            }
            Navigator.of(context).pop();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => screen));
          }));
    });
    return menuItems;
  }
}
