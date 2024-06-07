import 'package:flutter/material.dart';

clearFocus() {
  FocusManager.instance.primaryFocus?.unfocus();
}
