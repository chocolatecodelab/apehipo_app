import 'dart:developer';
import 'package:Apehipo/modules/keloka_kebun/widgets/app_bar.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

const List<String> _list = [
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  'Juli',
  'Agustus',
  'September',
  'November',
  'Desember',
];

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarKelolaKebun(title: "History"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomDropdown<String>(
                      hintText: 'Select job role',
                      items: _list,
                      initialItem: _list[0],
                      onChanged: (value) {
                        log('changing value to: $value');
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomDropdown<String>(
                      hintText: 'Select job role',
                      items: _list,
                      initialItem: _list[0],
                      onChanged: (value) {
                        log('changing value to: $value');
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomDropdown<String>(
                      hintText: 'Select job role',
                      items: _list,
                      initialItem: _list[0],
                      onChanged: (value) {
                        log('changing value to: $value');
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
