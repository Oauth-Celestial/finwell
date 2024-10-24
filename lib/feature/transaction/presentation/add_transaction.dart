import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/feature/transaction/presentation/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AddTransaction extends StatelessWidget {
  const AddTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.currentTheme!.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.currentTheme!.buttonColor),
        backgroundColor: context.currentTheme!.backgroundColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40.h,
          ),
          SizedBox(
            height: 200.h,
            child: SvgPicture.asset("assets/svgs/transaction.svg"),
          ),
          SizedBox(
            height: 40.h,
          ),
          Text(
            "What Kind of Transaction is this?",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 25.h,
          ),
          Row(
            children: [
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => TransactionForm(
                              isforExpense: false,
                            )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color of the container
                      borderRadius:
                          BorderRadius.circular(12.0), // Corner radius
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3), // Shadow color
                          spreadRadius: 3, // Spread radius
                          blurRadius: 3, // Blur radius
                          offset:
                              const Offset(0, 1), // Changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                              width: 80.w,
                              height: 80.w,
                              child: Image.asset("assets/income.png")),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Income",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => TransactionForm()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color of the container
                      borderRadius:
                          BorderRadius.circular(12.0), // Corner radius
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3), // Shadow color
                          spreadRadius: 3, // Spread radius
                          blurRadius: 3, // Blur radius
                          offset:
                              const Offset(0, 1), // Changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                              width: 80.w,
                              height: 80.w,
                              child: Image.asset("assets/expense.png")),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "Expense",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
            ],
          )
        ],
      ),
    );
  }
}
