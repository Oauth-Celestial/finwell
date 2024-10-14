import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/routes/custom_route_builder.dart';
import 'package:finwell/core/widgets/next_button.dart';
import 'package:finwell/core/widgets/text_field/custom_text_field.dart';
import 'package:finwell/feature/onboarding/presentation/spending_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:typewritertext/typewritertext.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
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
                  softWrap: false,
                  duration: const Duration(milliseconds: 50),
                  "What is your monthly income",
                  onFinished: (value) {
                    setState(() {
                      showField = true;
                    });
                  },
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                ),
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
                  duration: const Duration(milliseconds: 650),
                  opacity: showField ? 1 : 0,
                  child: NextButton(onPressed: () {
                    Navigator.of(context).push(
                        StackSlide(to: const SpendingPage(), fromPage: widget));
                  }),
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
