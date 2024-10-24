// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finwell/core/widgets/custom_drop_down.dart';
import 'package:finwell/core/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionForm extends StatefulWidget {
  bool isforExpense;
  TransactionForm({super.key, this.isforExpense = true});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final List<CustomDropDownItem> financialCategories = [
    CustomDropDownItem(
      text: 'Housing',
      icon: Icon(Icons.home, color: Colors.blue),
    ),
    CustomDropDownItem(
      text: 'Transportation',
      icon: Icon(Icons.directions_car, color: Colors.green),
    ),
    CustomDropDownItem(
      text: 'Food & Groceries',
      icon: Icon(Icons.local_grocery_store, color: Colors.orange),
    ),
    CustomDropDownItem(
      text: 'Utilities & Bills',
      icon: Icon(Icons.receipt_long, color: Colors.red),
    ),
    CustomDropDownItem(
      text: 'Health & Wellness',
      icon: Icon(Icons.local_hospital, color: Colors.pink),
    ),
    CustomDropDownItem(
      text: 'Entertainment & Leisure',
      icon: Icon(Icons.movie, color: Colors.purple),
    ),
    CustomDropDownItem(
      text: 'Personal Care',
      icon: Icon(Icons.spa, color: Colors.teal),
    ),
    CustomDropDownItem(
      text: 'Education',
      icon: Icon(Icons.school, color: Colors.indigo),
    ),
    CustomDropDownItem(
      text: 'Debt Payments',
      icon: Icon(Icons.payment, color: Colors.brown),
    ),
    CustomDropDownItem(
      text: 'Insurance',
      icon: Icon(Icons.shield, color: Colors.grey),
    ),
    CustomDropDownItem(
      text: 'Investments & Savings',
      icon: Icon(Icons.trending_up, color: Colors.green),
    ),
    CustomDropDownItem(
      text: 'Gifts & Donations',
      icon: Icon(Icons.card_giftcard, color: Colors.redAccent),
    ),
    CustomDropDownItem(
      text: 'Miscellaneous',
      icon: Icon(Icons.more_horiz, color: Colors.black),
    ),
    // Income Categories
    CustomDropDownItem(
      text: 'Salary/Wages',
      icon: Icon(Icons.attach_money, color: Colors.greenAccent),
    ),
    CustomDropDownItem(
      text: 'Freelance/Side Jobs',
      icon: Icon(Icons.work, color: Colors.blueAccent),
    ),
    CustomDropDownItem(
      text: 'Investments',
      icon: Icon(Icons.show_chart, color: Colors.purpleAccent),
    ),
    CustomDropDownItem(
      text: 'Rental Income',
      icon: Icon(Icons.house, color: Colors.amber),
    ),
    CustomDropDownItem(
      text: 'Business Income',
      icon: Icon(Icons.business, color: Colors.blueGrey),
    ),
    CustomDropDownItem(
      text: 'Government Benefits',
      icon: Icon(Icons.account_balance, color: Colors.deepOrange),
    ),
    CustomDropDownItem(
      text: 'Gifts',
      icon: Icon(Icons.card_giftcard, color: Colors.pinkAccent),
    ),
    CustomDropDownItem(
      text: 'Refunds & Rebates',
      icon: Icon(Icons.receipt, color: Colors.cyan),
    ),
    CustomDropDownItem(
      text: 'Bonuses & Commissions',
      icon: Icon(Icons.emoji_events, color: Colors.yellow),
    ),
    CustomDropDownItem(
      text: 'Royalties',
      icon: Icon(Icons.library_books, color: Colors.deepPurple),
    ),
  ];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Transaction Name",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: CustomTextField(
                padding: EdgeInsets.all(8),
                controller: _nameController,
                borderStyle: CustomTextFieldStyle.underline,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Transaction Type",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 40.h,
              child: CustomDropdownButton(
                options: [
                  CustomDropDownItem(
                      text: "Income", icon: Image.asset("assets/income.png")),
                  CustomDropDownItem(
                      text: "Expense", icon: Image.asset("assets/expense.png")),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Amount",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: CustomTextField(
                padding: EdgeInsets.all(8),
                controller: _amountController,
                keyboardType: TextInputType.number,
                borderStyle: CustomTextFieldStyle.underline,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Category",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 40.h,
              child: CustomDropdownButton(
                options: financialCategories,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Date",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: CustomTextField(
                padding: EdgeInsets.all(8),
                onTap: () {
                  _selectDate(context);
                },
                controller: _amountController,
                keyboardType: TextInputType.number,
                borderStyle: CustomTextFieldStyle.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      // setState(() {
      //   // Format the date as needed, here using 'yyyy-MM-dd'
      //   _dateController.text =
      //       "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      // });
    }
  }
}
