import 'package:flutter/material.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_management/pages/category_page.dart';
import 'package:money_management/pages/home_page.dart';

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
                  padding: EdgeInsets.symmetric(vertical: 42, horizontal: 16),
                  child: Text(
                    "Kategori",
                    style: GoogleFonts.montserrat(fontSize: 20),
                  ),
                ),
              ),
            ),
      floatingActionButton: Visibility(
        visible: (currentIndex == 0) ? true : false,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.amber[800],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: Icon(Icons.add),
        ),
      ),
      body: _page[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  onTapped(0);
                },
                icon: Icon(Icons.home)),
            SizedBox(
              width: 100,
            ),
            IconButton(
                onPressed: () {
                  onTapped(1);
                },
                icon: Icon(Icons.list_alt)),
          ],
        ),
      ),
    );
  }
}
