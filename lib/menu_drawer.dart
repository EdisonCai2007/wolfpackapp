import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'themes/theme_manager.dart';


class MenuDrawer extends Drawer {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20)),
      ),


      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon (change later to an actually icon)
          DrawerHeader(
            child: Text(
              '\n\nUHS Student Tools',
              style: GoogleFonts.lato(
                  fontSize: 30, fontWeight: FontWeight.w900)),
          ),

          // Home page button
          ListTile(
            leading: const Icon(Icons.home),
            title: Text('Home',
              style: GoogleFonts.lato(
                fontSize: 20, fontWeight: FontWeight.w400)),
            onTap: () {
              Navigator.pushNamed(context, '/homeScreen');
            },
          ),

          // Settings button
          ListTile(
              leading: const Icon(Icons.settings),
              title: Text('Settings',
                  style: GoogleFonts.lato(
                      fontSize: 20, fontWeight: FontWeight.w400)),
            onTap: () {
              Navigator.pushNamed(context, '/settingsScreen');
            },
          ),

          ListTile(
            leading: const Icon(Icons.login),
            title: Text('Sign In',
                style: GoogleFonts.lato(
                    fontSize: 20, fontWeight: FontWeight.w400)),
            onTap: () {
              Navigator.pushNamed(context, '/loginScreen');
            },
          ),
          
           Expanded(
             child: Align(
               alignment: FractionalOffset.bottomLeft,
               child: Padding(
                 padding: const EdgeInsets.only(
                   bottom: 8
                 ),
                 child: ElevatedButton(
                   style: ButtonStyle(
                     shape: const MaterialStatePropertyAll(CircleBorder()),
                     backgroundColor: const MaterialStatePropertyAll(Color.fromRGBO(0, 0, 0, 0)),
                     shadowColor: const MaterialStatePropertyAll(Color.fromRGBO(0, 0, 0, 0)),
                     minimumSize: const MaterialStatePropertyAll(Size(50, 50)),
                     iconColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.onSurface)
                   ),
                   onPressed: () {
                     Provider.of<ThemeManager>(context, listen: false).toggleThemeMode();
                   }, child: const Icon(Icons.dark_mode),
                 ),
               ),
             ),
           ),
        ],
      ),
    );
  }
}
