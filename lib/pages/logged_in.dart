import 'package:final_project/models/user.dart';
import 'package:final_project/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

//* MY Pages
import './home.dart';
import './search.dart';
import './notifications.dart';
import './profile.dart';

class LoggedIn extends StatefulWidget {
  LoggedIn({Key? key}) : super(key: key);

  @override
  _LoggedInState createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  int currentIndex = 0;

  final List<String> titles = ['Home', 'Search', 'Notifications', 'Profile'];

  final List<Widget> pages = [Home(), Search(), Notifications(), Profile()];

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
    
      appBar: AppBar(
        title: Image.asset(
          'assets/mate.png',
          scale: 3,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              icon: const Icon(Icons.settings)),
        ],
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.shifting,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white70),
            activeIcon: Icon(Icons.home, color: Colors.white),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.white70),
            activeIcon: Icon(Icons.search, color: Colors.white),
            label: "Search",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications, color: Colors.white70),
              activeIcon: Icon(Icons.notifications, color: Colors.white),
              label: "Notifications"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.userAlt, color: Colors.white70),
              activeIcon: FaIcon(FontAwesomeIcons.userAlt, color: Colors.white),
              label: "Profile"),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity! > 0) {
            // User swiped Left
            if (currentIndex != 0) {
              setState(() {
                currentIndex--;
              });
            }
          } else if (details.primaryVelocity! < 0) {
            // User swiped Right

            if (currentIndex != 3) {
              setState(() {
                currentIndex++;
              });
            }
          }
        },
        child: pages[currentIndex],
      ),
    );
  }
}
