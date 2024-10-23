import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/extensions/ext_string.dart';
import 'package:finwell/core/route_manager/navigator_service.dart';
import 'package:finwell/core/route_manager/route_manager.dart';
import 'package:finwell/core/widgets/next_button.dart';
import 'package:finwell/core/widgets/text_field/custom_text_field.dart';
import 'package:finwell/feature/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:typewritertext/typewritertext.dart';

class SpendingPage extends StatefulWidget {
  const SpendingPage({super.key});

  @override
  State<SpendingPage> createState() => _SpendingPageState();
}

class _SpendingPageState extends State<SpendingPage> {
  final TextEditingController _controller = TextEditingController();
  static const _locale = 'en';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale)
      .format(int.parse(s.isEmpty ? "0" : s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
  bool showField = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.currentTheme?.backgroundColor,
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150.h,
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TypeWriter.text(
                    duration: const Duration(milliseconds: 50),
                    "What is your appoximate monthly spending ?",
                    onFinished: (value) {
                      setState(() {
                        showField = true;
                      });
                    },
                    style: TextStyle(
                        color: context.currentTheme!.textColor, fontSize: 25),
                  )
                  // Text(
                  //   "What is your appoximate monthly spending",
                  //   style: TextStyle(color: Colors.white, fontSize: 25),
                  // ),
                  ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(end: 10.w, start: 8.w),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: showField ? 1 : 0,
                  child: CustomTextField(
                    controller: _controller,
                    hintText: "e.g 10,000",
                    keyboardType: TextInputType.number,
                    onChange: (string) {
                      string = _formatNumber(string.replaceAll(',', ''));
                      _controller.value = TextEditingValue(
                        text: string,
                        selection:
                            TextSelection.collapsed(offset: string.length),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: showField ? 1 : 0,
                  child: NextButton(
                    onPressed: () {
                      context.read<OnboardingCubit>().updateMonthlyExpense(
                          monthlyExpense: _controller.text.removeCommas);
                      NavigationService().pushNamed(routeUserSuccess);
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 50.h,
          )
        ],
      ),
    );
  }
}
