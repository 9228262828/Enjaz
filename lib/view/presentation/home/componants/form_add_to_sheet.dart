
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String message = '';

  // Replace with your actual Google Apps Script Web App URL
  final String scriptUrl = 'https://script.google.com/macros/s/AKfycbwlAPb-0OBBZykrH0an-Xrn0gyBKAiaWF26Ywcjs1MCMyC9aLa-z-5yO1vfsoW0qklK/exec'; // Replace with your URL

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final response = await http.post(
          Uri.parse(scriptUrl),
          body: jsonEncode({
            'name': name,
            'email': email,
            'message': message,
          }),
          headers: {'Content-Type': 'application/json'},
        );

        // Check if the response is a redirect
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Form submitted successfully'),
          ));
        } else if (response.statusCode == 302 || response.statusCode == 301) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Form submitted successfully, but received a redirect.'),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to submit form: ${response.statusCode}'),
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to submit form: $e'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) {
                  name = value!;
                },
                validator: (value) {
                  return value!.isEmpty ? 'Please enter your name' : null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) {
                  email = value!;
                },
                validator: (value) {
                  return value!.isEmpty ? 'Please enter your email' : null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Message'),
                onSaved: (value) {
                  message = value!;
                },
                validator: (value) {
                  return value!.isEmpty ? 'Please enter a message' : null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
