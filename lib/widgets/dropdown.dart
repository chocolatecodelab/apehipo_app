import 'package:flutter/material.dart';

class DropdownTextFieldExample extends StatefulWidget {
  @override
  _DropdownTextFieldExampleState createState() =>
      _DropdownTextFieldExampleState();
}

class _DropdownTextFieldExampleState extends State<DropdownTextFieldExample> {
  String selectedValue = 'Sayuran'; // Nilai terpilih dari dropdown

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown in TextField'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedValue,
              onChanged: (newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
              items: ['Sayuran', 'Buah']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Pilih opsi',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DropdownTextFieldExample(),
  ));
}
