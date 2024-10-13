import 'package:flutter/material.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_management/pages/category_page.dart';
import 'package:money_management/pages/home_page.dart';
import 'package:money_management/pages/transaction_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> _page = [HomePage(), CategoryPage()];

  int currentIndex = 0;

  void onTapped(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (currentIndex == 0)
          ? CalendarAppBar(
              backButton: false,
              accent: Colors.amber[800],
              locale: 'id',
              onDateChanged: (value) => print(value),
              firstDate: DateTime.now().subtract(Duration(days: 140)),
              lastDate: DateTime.now(),
            )
          : PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: Container(
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 42, horizontal: 16)),
              ),
            ),
      floatingActionButton: Visibility(
        visible: (currentIndex == 0) ? true : false,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return TransactionPage();
            }));
          },
          backgroundColor: Colors.amber[800],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: Icon(Icons.add),
        ),
      ),
      body: _page[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white, // Set background color to white
        elevation: 8.0, // Add elevation for shadow effect
        shape: CircularNotchedRectangle(), // Optional: Add a notch for the FAB
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                onTapped(0);
              },
              icon: Icon(
                Icons.home_outlined, // Use outlined icon for a modern look
                color: currentIndex == 0
                    ? Colors.amber[800]
                    : Colors.grey, // Highlight selected icon
              ),
            ),
            SizedBox(
              width: 100,
            ),
            IconButton(
              onPressed: () {
                onTapped(1);
              },
              icon: Icon(
                Icons.category_outlined, // Use outlined icon for a modern look
                color: currentIndex == 1
                    ? Colors.amber[800]
                    : Colors.grey, // Highlight selected icon
              ),
            ),
          ],
        ),
      ),
    );
  }
}
