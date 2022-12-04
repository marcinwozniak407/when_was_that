import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:when_was_that/app/my%20account/my_account_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('When was that?'),
      ),
      body: Builder(builder: (context) {
        if (currentIndex == 0) {
          return const Center(
              child: Text('List', style: TextStyle(fontSize: 50)));
        }
        if (currentIndex == 1) {
          return const Center(
              child: Text('Add', style: TextStyle(fontSize: 50)));
        }
        return MyAccountPage(email: widget.user.email);
      }),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (NewIndex) {
          setState(() {
            currentIndex = NewIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My account',
          ),
        ],
      ),
    );
  }
}
