import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController city;
  VoidCallback onPressed;

  CustomTextField({Key? key, required this.city, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
return    TextField(
      controller: city,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text('City'),
        labelStyle: TextStyle(fontSize: 20),
        icon: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(15),
              primary: Colors.tealAccent.withOpacity(0.1),
              shadowColor: Colors.yellow,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              side: BorderSide(
                  color: Colors.yellow.withOpacity(0.6), width: 1.7)),
          onPressed: onPressed,
          child: Icon(Icons.search, color: Colors.black),
        ),
      ),
    );
  }
}
