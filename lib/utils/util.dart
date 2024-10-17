// import 'dart:io';

// import 'package:image_picker/image_picker.dart';

// class Utils {
//   final ImagePicker picker = ImagePicker();
//   Future<File?> pickImage({source = ImageSource.gallery}) async {
//     final XFile? image = await picker.pickImage(source: source);
//     return image != null ? File(image.path) : null;
//   }
// }

// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Util {
  static String formatDate(DateTime date) {
    var now = DateTime.now(); // Current
    var isToday = date.day == now.day;
    var isTomorrow = date.day == (now.day + 1);
    if (isToday) {
      return "Today ${DateFormat('hh:mm a').format(date)}";
    } else if (isTomorrow) {
      return "Tomorrow ${DateFormat('hh:mm a').format(date)}";
    } else
      return "${DateFormat('EEEE').format(date)} ${DateFormat('hh:mm a').format(date)}";
  }

  static void showError(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }

  static void showSuccess(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    ));
  }
}
