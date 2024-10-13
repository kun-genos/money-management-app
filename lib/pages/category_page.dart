import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_management/database/database_helper.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<CategoryPage> createState() => _CategoryPageState();

  static const routeName = '/category';
}

class _CategoryPageState extends State<CategoryPage> {
  bool isExpenseCategory = true;
  final TextEditingController _categoryController = TextEditingController();
  List<Map<String, dynamic>> _categories = [];

  @override
  void initState() {
    super.initState();
    _refreshCategories();
  }

  void _refreshCategories() async {
    final data = await DatabaseHelper.instance.getCategories(isExpenseCategory);
    setState(() {
      _categories = data;
    });
  }

  void openDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            isExpenseCategory
                ? "Tambah Kategori Pengeluaran"
                : "Tambah Kategori Pemasukan",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isExpenseCategory ? Colors.red : Colors.green,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _categoryController,
                  cursorColor: isExpenseCategory ? Colors.red : Colors.green,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: isExpenseCategory ? Colors.red : Colors.green),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: isExpenseCategory ? Colors.red : Colors.green,
                          width: 2),
                    ),
                    hintText: "Contoh: Uang Makan",
                    hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                    prefixIcon: Icon(Icons.category,
                        color: isExpenseCategory ? Colors.red : Colors.green),
                  ),
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isExpenseCategory ? Colors.red : Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    elevation: 5,
                  ),
                  onPressed: () async {
                    if (_categoryController.text.isNotEmpty) {
                      await DatabaseHelper.instance.createCategory(
                          _categoryController.text, isExpenseCategory);
                      _categoryController.clear();
                      Navigator.of(context).pop();
                      _refreshCategories();
                    }
                  },
                  child: Text(
                    "Tambah",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kategori',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Switch(
                        value: isExpenseCategory,
                        onChanged: (bool value) {
                          setState(() {
                            isExpenseCategory = value;
                            _refreshCategories();
                          });
                        },
                        activeColor: Colors.red,
                        inactiveTrackColor: Colors.green,
                      ),
                      Text(
                        isExpenseCategory ? 'Pengeluaran' : 'Pemasukan',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isExpenseCategory ? Colors.red : Colors.green,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: openDialog,
                    icon: Icon(Icons.add, color: Colors.white),
                    label: Text(
                      'Tambah',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isExpenseCategory ? Colors.red : Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      elevation: 5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Expanded(
                child: ListView.builder(
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return _buildCategoryItem(
                        category['name'], Icons.category, category['id']);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String categoryName, IconData icon, int id) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: CircleAvatar(
          backgroundColor: isExpenseCategory
              ? Colors.red.withOpacity(0.1)
              : Colors.green.withOpacity(0.1),
          child: Icon(
            icon,
            color: isExpenseCategory ? Colors.red : Colors.green,
          ),
        ),
        title: Text(
          categoryName,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () async {
            await DatabaseHelper.instance.deleteCategory(id);
            _refreshCategories();
          },
        ),
      ),
    );
  }
}
