import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/extensions/ext_date_time.dart';
import 'package:finwell/feature/pending_transactions/domain/entity/pending_transaction_model.dart';
import 'package:finwell/feature/pending_transactions/presentation/bloc/pending_transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PendingTransactionPage extends StatefulWidget {
  const PendingTransactionPage({super.key});

  @override
  State<PendingTransactionPage> createState() => _PendingTransactionPageState();
}

class _PendingTransactionPageState extends State<PendingTransactionPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PendingTransactionBloc>().add(FetchPendingTransactionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.currentTheme!.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pending Transactions"),
      ),
      body: BlocBuilder<PendingTransactionBloc, PendingTransactionState>(
        builder: (context, state) {
          if (state.status == PendingTransactionStatus.fetched) {
            return ListView.separated(
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Divider(),
                  );
                },
                itemCount: state.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return PendingTransactionCard(cardData: state.data?[index]);
                });
          }
          return Container(
            child: Text("You have no pending transaction"),
          );
        },
      ),
    );
  }
}

class PendingTransactionCard extends StatelessWidget {
  PendingTransactionModel? cardData;
  PendingTransactionCard({super.key, this.cardData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 25,
                            color: context.currentTheme!.buttonColor,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            cardData?.transctionDate.formatDateTimeWithAmPm() ??
                                "",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      if (cardData?.isExpense ?? false) ...[
                        Text(
                          "-" + (cardData?.amount ?? ""),
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold),
                        )
                      ] else ...[
                        Text(
                          "+" + (cardData?.amount ?? ""),
                          style: TextStyle(
                              color: context.currentTheme!.buttonColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold),
                        )
                      ]
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 35.w,
                      height: 35.w,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          color: context.currentTheme!.buttonColor,
                          shape: BoxShape.circle),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      width: 35.w,
                      height: 35.w,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
