import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  bool isExpense = true;
  String? selectedCategory;
  String? description;
  DateTime? selectedDate;
  final TextEditingController _amountController = TextEditingController();

  final List<String> categories = [
    'Makan dan Jajan',
    'Transportasi',
    'Pakaian',
    'Kesehatan',
    'Hiburan',
    'Pendidikan',
    'Lainnya'
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.amber[800]!,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.amber[800],
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _saveTransaction() {
    // Implement your save logic here
    print('Transaction saved');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Transaksi',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.amber[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTransactionTypeSwitch(),
              SizedBox(height: 20),
              _buildAmountField(),
              SizedBox(height: 20),
              _buildCategoryDropdown(),
              SizedBox(height: 20),
              _buildDescriptionField(),
              SizedBox(height: 20),
              _buildDatePicker(),
              SizedBox(height: 30),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionTypeSwitch() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Pengeluaran',
            style: GoogleFonts.poppins(
              color: isExpense ? Colors.red : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          Switch(
            value: isExpense,
            onChanged: (value) {
              setState(() {
                isExpense = value;
              });
            },
            activeColor: Colors.red,
            inactiveTrackColor: Colors.green,
          ),
          Text(
            'Pemasukan',
            style: GoogleFonts.poppins(
              color: !isExpense ? Colors.green : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountField() {
    return TextFormField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      style: GoogleFonts.poppins(),
      decoration: InputDecoration(
        labelText: 'Nominal',
        labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
        prefixIcon: Icon(Icons.attach_money, color: Colors.amber[800]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.amber[800]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.amber[800]!, width: 2),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      hint: Text('Pilih Kategori', style: GoogleFonts.poppins()),
      items: categories.map((String category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category, style: GoogleFonts.poppins()),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedCategory = newValue;
        });
      },
      decoration: InputDecoration(
        labelText: 'Kategori',
        labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
        prefixIcon: Icon(Icons.category, color: Colors.amber[800]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.amber[800]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.amber[800]!, width: 2),
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      style: GoogleFonts.poppins(),
      decoration: InputDecoration(
        labelText: 'Deskripsi',
        labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
        prefixIcon: Icon(Icons.description, color: Colors.amber[800]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.amber[800]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.amber[800]!, width: 2),
        ),
      ),
      onChanged: (value) {
        setState(() {
          description = value;
        });
      },
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () => _selectDate(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Tanggal',
          labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
          prefixIcon: Icon(Icons.calendar_today, color: Colors.amber[800]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.amber[800]!),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate == null
                  ? 'Pilih Tanggal'
                  : DateFormat('dd/MM/yyyy').format(selectedDate!),
              style: GoogleFonts.poppins(),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.amber[800]),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _saveTransaction,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber[800],
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          'Simpan Transaksi',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
