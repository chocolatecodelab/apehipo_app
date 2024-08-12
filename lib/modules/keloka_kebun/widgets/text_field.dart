import '../../../widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TextFieldKelolaKebun extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? sufixText;
  final Icon? sufixIcon;
  final bool isNumber;
  final bool getDate;

  const TextFieldKelolaKebun({
    super.key,
    required this.label,
    required this.controller,
    required this.sufixText,
    required this.sufixIcon,
    required this.isNumber,
    required this.getDate,
  });

  @override
  State<TextFieldKelolaKebun> createState() => _TextFieldKelolaKebunState();
}

class _TextFieldKelolaKebunState extends State<TextFieldKelolaKebun> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: TextField(
        controller: widget.controller,
        cursorColor: AppColors.primaryColor,
        keyboardType:
            widget.isNumber ? TextInputType.number : TextInputType.text,
        inputFormatters: widget.isNumber
            ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
            : null,
        onTap: () {
          if (widget.getDate) {
            _selectDate();
          }
        },
        readOnly: widget.getDate ? true : false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.all(16),
          suffixText: widget.sufixText,
          suffixStyle: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 16,
          ),
          labelText: widget.label,
          labelStyle: TextStyle(
            color: Color(0xFFC1C1C1),
          ),
          floatingLabelStyle: TextStyle(
            color: Colors.black,
          ),
          suffixIcon: widget.sufixIcon,
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );

    if (_picked != null) {
      setState(() {
        widget.controller.text = _picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? _picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (_picked != null) {
      setState(
        () {
          widget.controller.text = _picked.format(context);
          // widget.controller.text =
          //     DateFormat.jms().parse(_picked.format(context)).toString();
        },
      );
    }
  }
}
