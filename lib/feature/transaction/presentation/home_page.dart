import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/extensions/ext_date_time.dart';
import 'package:finwell/core/route_manager/navigator_service.dart';
import 'package:finwell/core/route_manager/route_manager.dart';
import 'package:finwell/core/widgets/horizontal_calendar.dart';
import 'package:finwell/feature/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      body: Column(
        children: [
          HorizontalCalendar(
            onDateChange: (selectedDate) {
              NavigationService()
                  .navigationContext!
                  .read<TransactionBloc>()
                  .add(FetchTransactionEvent(
                      transactionDate: selectedDate.toCustomFormattedString()));
            },
          ),
          Expanded(
              child: BlocConsumer<TransactionBloc, TransactionState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state.status == TransactionStatus.loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: state.fetchedTransactions?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50.h,
                        color: Colors.green,
                      ),
                    );
                  });
            },
          ))
        ],
      ),
    );
  }
}
