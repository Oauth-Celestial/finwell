// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finwell/core/constants/constants.dart';
import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/extensions/ext_date_time.dart';
import 'package:finwell/core/extensions/ext_string.dart';
import 'package:finwell/core/route_manager/navigator_service.dart';
import 'package:finwell/core/route_manager/route_manager.dart';
import 'package:finwell/core/widgets/custom_drop_down.dart';
import 'package:finwell/core/widgets/text_field/custom_text_field.dart';
import 'package:finwell/feature/pending_transactions/domain/entity/pending_transaction_model.dart';
import 'package:finwell/feature/pending_transactions/presentation/bloc/pending_transaction_bloc.dart';
import 'package:finwell/feature/transaction/domain/entities/transaction_model.dart';
import 'package:finwell/feature/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  bool isforExpense;
  PendingTransactionModel? pendingTransactionData;
  TransactionForm(
      {super.key, this.isforExpense = true, this.pendingTransactionData});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  DateTime? picked = DateTime.now();
  final List<CustomDropDownItem> financialCategories = dropdownItems.map((e) {
    return CustomDropDownItem(text: e["text"], icon: e["icon"]);
  }).toList();
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
    if (widget.pendingTransactionData != null) {
      picked = widget.pendingTransactionData?.transctionDate ?? DateTime.now();
      _amountController.text = widget.pendingTransactionData?.amount
              .toLowerCase()
              .replaceAll("rs", "")
              .replaceAll(",", "")
              .formatAsNumber() ??
          "";
      widget.isforExpense = widget.pendingTransactionData?.isExpense ?? false;
    }
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
                          if (widget.pendingTransactionData != null) {
                            context.read<PendingTransactionBloc>().add(
                                DeletePendingTransactionEvent(
                                    deleteTransaction:
                                        widget.pendingTransactionData!));
                          }
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
                          if (state.status == TransactionStatus.created) {
                            NavigationService().popUntil(routeDashboardScreen);
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
