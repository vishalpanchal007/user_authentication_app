import 'package:flutter/material.dart';

class AlertBox extends StatefulWidget {
  const AlertBox({super.key});

  @override
  State<AlertBox> createState() => _AlertBoxState();
}

class _AlertBoxState extends State<AlertBox> {

  List roleData = [
    'admin',
    'manager',
    'clerk',
    'employee'
  ];
  dynamic initialValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<dynamic>(
        value: initialValue,
        items: roleData.map((e) => DropdownMenuItem(
          value: "$e",
          child: Text("$e"),
        )).toList(),
        onChanged: (val) {
          setState(() {
            initialValue = val;
          });
        },
      ),
    );
  }
}
