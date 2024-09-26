import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<CategoryPage> createState() => _CategoryPageState();

  static const routeName = '/category';
}

class _CategoryPageState extends State<CategoryPage> {
  bool kontakSwitch = true;

  void openDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    (kontakSwitch)
                        ? "Tambah Kategori Pengeluaran"
                        : "Tambah Kategori Pemasukan",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    cursorColor: Colors.amber,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.amber,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.amber)),
                        hintText: "exp : uang dapur ..."),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              (kontakSwitch) ? Colors.red : Colors.green),
                      onPressed: () {},
                      child: Text(
                        "Tambah",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Switch(
                value: kontakSwitch,
                onChanged: (bool value) {
                  setState(() {
                    kontakSwitch = value;
                  });
                },
                activeColor: Colors.red,
                inactiveThumbColor: Colors.green,
                inactiveTrackColor: Colors.green[200],
              ),
              IconButton(
                  onPressed: () {
                    openDialog();
                  },
                  icon: Icon(Icons.add))
            ],
          ),
          Card(
            elevation: 5,
            child: ListTile(
              leading: (kontakSwitch)
                  ? Icon(
                      Icons.upload,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.download,
                      color: Colors.green,
                    ),
              title: Text("Uang Bensin"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                ],
              ),
            ),
          ),
          Card(
            elevation: 5,
            child: ListTile(
              leading: (kontakSwitch)
                  ? Icon(
                      Icons.upload,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.download,
                      color: Colors.green,
                    ),
              title: Text("Uang Bensin"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
