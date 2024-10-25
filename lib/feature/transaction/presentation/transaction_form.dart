// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/extensions/ext_date_time.dart';
import 'package:finwell/core/extensions/ext_string.dart';
import 'package:finwell/core/widgets/custom_drop_down.dart';
import 'package:finwell/core/widgets/text_field/custom_text_field.dart';
import 'package:finwell/feature/transaction/domain/entities/transaction_model.dart';
import 'package:finwell/feature/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  bool isforExpense;
  TransactionForm({super.key, this.isforExpense = true});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  DateTime? picked = DateTime.now();
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
  TextEditingController _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedTransactionType = "";
  String selectedCategory = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dateController.text = picked!.toCustomFormattedString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Transaction"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 45.h,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter transaction name';
                      }
                      return null;
                    },
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
                    selectedItem: (value) {
                      selectedTransactionType = value;
                    },
                    initialSelection: widget.isforExpense
                        ? CustomDropDownItem(
                            text: "Expense",
                            icon: Image.asset("assets/expense.png"))
                        : CustomDropDownItem(
                            text: "Income",
                            icon: Image.asset("assets/income.png")),
                    options: [
                      CustomDropDownItem(
                          text: "Income",
                          icon: Image.asset("assets/income.png")),
                      CustomDropDownItem(
                          text: "Expense",
                          icon: Image.asset("assets/expense.png")),
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
                    onChange: (string) {
                      string = string.replaceAll(',', '').formatAsNumber();
                      _amountController.value = TextEditingValue(
                        text: string,
                        selection:
                            TextSelection.collapsed(offset: string.length),
                      );
                      ;
                    },
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.replaceAll(",", "") == "0") {
                        return 'Please enter valid amount';
                      }
                      return null;
                    },
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
                  height: 5.h,
                ),
                SizedBox(
                  height: 40.h,
                  child: CustomDropdownButton(
                    options: financialCategories,
                    selectedItem: (value) {
                      selectedCategory = value;
                    },
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
                    controller: _dateController,
                    keyboardType: TextInputType.number,
                    borderStyle: CustomTextFieldStyle.underline,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          String transactionId = Uuid().v1();
                          TransactionModel currentTransaction =
                              TransactionModel(
                            transactionId: transactionId,
                            transactionName: _nameController.text,
                            transactionType: selectedTransactionType,
                            transactionAmount:
                                _amountController.text.removeCommas,
                            transactionDate: picked!,
                            transactionCategory: selectedCategory,
                          );
                          context.read<TransactionBloc>().add(
                              CreateTransactionEvent(
                                  transaction: currentTransaction));
                        }
                      },
                      child: BlocConsumer<TransactionBloc, TransactionState>(
                        listener: (context, state) {
                          if (state.status == TransactionStatus.failed) {
                            print("Failed");
                          }
                        },
                        builder: (context, state) {
                          if (state.status == TransactionStatus.creating) {
                            return CircularProgressIndicator();
                          }
                          return Container(
                            decoration: BoxDecoration(
                                color: context.currentTheme!.buttonColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "Add Transaction",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        // Format the date as needed, here using 'yyyy-MM-dd'
        _dateController.text = picked!.toCustomFormattedString();
      });
    }
  }
}
