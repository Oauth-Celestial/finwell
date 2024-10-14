import 'package:finwell/core/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:ultimate_extension/ultimate_extension.dart';

FinThemeModel darkTheme = FinThemeModel(
    backgroundColor: ColorHelper.fromHex("#222831"),
    textColor: Colors.white,
    buttonColor: ColorHelper.fromHex("#30b481"));

FinThemeModel lightTheme = FinThemeModel(
    backgroundColor: Colors.white,
    textColor: Colors.black,
    buttonColor: ColorHelper.fromHex("#30b481"));
