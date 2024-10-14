import 'package:finwell/core/extensions/build_context.dart';
import 'package:finwell/core/routes/custom_route_builder.dart';
import 'package:finwell/core/widgets/next_button.dart';
import 'package:finwell/core/widgets/text_field/custom_text_field.dart';
import 'package:finwell/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:finwell/feature/onboarding/presentation/income_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:typewritertext/typewritertext.dart';

class NamePage extends StatefulWidget {
  const NamePage({super.key});

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  bool showField = false;
  User? user;
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = context.read<AuthBloc>().state.currentUser;
  }

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
                  "What should we call you ?",
                  onFinished: (value) {
                    setState(() {
                      nameController.text = user?.displayName ?? "";
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
                    controller: nameController,
                    hintText: "e.g John Doe",
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
                  duration: const Duration(seconds: 1),
                  opacity: showField ? 1 : 0,
                  child: NextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          StackSlide(to: const IncomePage(), fromPage: widget));
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
