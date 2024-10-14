import 'package:flutter/material.dart';
import 'package:money_management/pages/category_page.dart';
import 'package:money_management/pages/home_page.dart';
import 'package:money_management/pages/transaction_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<Widget> _pages;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializePages();
  }

  void _initializePages() {
    _pages = [
      HomePage(key: UniqueKey()),
      CategoryPage(),
    ];
  }

  void refreshHomePage() {
    setState(() {
      _initializePages();
    });
  }

  void onTapped(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      floatingActionButton: Visibility(
        visible: (currentIndex == 0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TransactionPage(
                  refreshHomeCallback: refreshHomePage,
                ),
              ),
            );
          },
          backgroundColor: Colors.amber[800],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 8.0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                onTapped(0);
              },
              icon: Icon(
                Icons.home_outlined,
                color: currentIndex == 0 ? Colors.amber[800] : Colors.grey,
              ),
            ),
            SizedBox(width: 100),
            IconButton(
              onPressed: () {
                onTapped(1);
              },
              icon: Icon(
                Icons.category_outlined,
                color: currentIndex == 1 ? Colors.amber[800] : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
