
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  TextEditingController city;
  VoidCallback onPressed;
  CustomTextField({Key? key, required this.city,required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: city,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        label: Text('City'),
        labelStyle: TextStyle(fontSize: 20),
        icon:IconButton(onPressed: onPressed, icon: Icon(Icons.search)),
      ),
    );
  }
}
