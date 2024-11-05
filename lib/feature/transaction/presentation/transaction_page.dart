import 'package:finwell/core/constants/constants.dart';
import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/extensions/ext_date_time.dart';
import 'package:finwell/core/extensions/ext_string.dart';
import 'package:finwell/core/route_manager/navigator_service.dart';
import 'package:finwell/core/route_manager/route_manager.dart';
import 'package:finwell/core/widgets/horizontal_calendar.dart';
import 'package:finwell/feature/transaction/domain/entities/transaction_model.dart';
import 'package:finwell/feature/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  DateTime currentSelectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.currentTheme!.backgroundColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Add Transaction',
        onPressed: () {
          NavigationService().pushNamed(routeAddTransaction);
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: SafeArea(
        child: Column(
          children: [
            HorizontalCalendar(
              onDateChange: (selectedDate) {
                currentSelectedDate = selectedDate;
                NavigationService()
                    .navigationContext!
                    .read<TransactionBloc>()
                    .add(FetchTransactionEvent(
                        transactionDate:
                            currentSelectedDate.toCustomFormattedString()));
              },
            ),
            Expanded(
              child: BlocConsumer<TransactionBloc, TransactionState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state.status == TransactionStatus.loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if ((state.fetchedTransactions ?? []).isEmpty) {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 80.w,
                              height: 80.w,
                              child: Image.asset("assets/expense.png")),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "No Records Found",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Divider(),
                        );
                      },
                      itemCount: state.fetchedTransactions?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TransactionCard(
                            transaction: state.fetchedTransactions?[index],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  TransactionModel? transaction;
  TransactionCard({
    super.key,
    this.transaction,
  });

  Icon getCategoryIcon(String category) {
    Icon icon = Icon(Icons.currency_bitcoin);
    for (Map<String, dynamic> item in dropdownItems) {
      if (item["text"] == category) {
        icon = item["icon"];
        break;
      }
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Container(
                    child:
                        getCategoryIcon(transaction?.transactionCategory ?? ""),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${transaction?.transactionName}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 18,
                            color: context.currentTheme!.buttonColor,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(transaction?.transactionDate
                                  .toCustomFormattedString() ??
                              ""),
                          Spacer(),
                        ],
                      )
                    ],
                  ),
                ),
                Text(
                  "${transaction?.transactionAmount}".formatAsNumber(),
                  style: TextStyle(
                      fontSize: 16.sp,
                      color:
                          (transaction?.transactionType ?? "").toLowerCase() ==
                                  "expense"
                              ? Colors.red
                              : context.currentTheme!.buttonColor),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
