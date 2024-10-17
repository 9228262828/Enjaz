import 'dart:convert';

import 'package:enjaz/shared/components/toast_component.dart';
import 'package:enjaz/shared/utils/app_values.dart';
import 'package:enjaz/view/presentation/home/componants/appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../shared/global/app_theme.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String message = '';
  String phone = ''; // Add phone field

  final String scriptUrl =
      'https://script.google.com/macros/s/AKfycbwnw8VfZh3-Up-a-NeMoBl8wyuoomp2ws9TRdQ-tKsj_pryWscydDSm5eveYUK3x1Fr/exec'; // Replace with your URL

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final response = await http.post(
          Uri.parse(scriptUrl),
          body: jsonEncode({
            'name': name,
            'email': email,
            'phone': phone, // Include phone number in request body
            'message': message,
          }),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          showToast(text: "تم ارسال الرسالة بنجاح", state: ToastStates.SUCCESS);
          Navigator.pop(context);
        } else {
          showToast(text: "تم ارسال الرسالة بنجاح", state: ToastStates.SUCCESS);
          Navigator.pop(context);

        }
      } catch (e) {
        showToast(text: "فشل في الارسال", state: ToastStates.ERROR);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                appbar(title: 'تواصل معنا',),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.name,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                          decoration: customInputDecoration(
                            context,
                            'الاسم',
                            'أدخل الاسم',
                          ),
                          onSaved: (value) {
                            name = value!;
                          },
                          validator: (value) {
                            return value!.isEmpty ? 'من فضلك ادخل الاسم' : null;
                          },
                        ),
                        SizedBox(height: mediaQueryHeight(context) * 0.04),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                          decoration: customInputDecoration(
                            context,
                            'البريد الالكتروني',
                            'أدخل البريد الالكتروني',
                          ),
                          onSaved: (value) {
                            email = value!;
                          },
                          validator: (value) {
                            return value!.isEmpty ? 'من فضلك ادخل البريد الالكتروني' : null;
                          },
                        ),
                        SizedBox(height: mediaQueryHeight(context) * 0.04),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                          decoration: customInputDecoration(
                            context,
                            'رقم الهاتف',
                            'أدخل رقم الهاتف',
                          ),
                          onSaved: (value) {
                            phone = value!;
                          },
                          validator: (value) {
                            return value!.isEmpty
                                ? 'من فضلك ادخل رقم الهاتف'
                                : null;
                          },
                        ),
                        SizedBox(height: mediaQueryHeight(context) * 0.04),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                          decoration: customInputDecoration(
                            context,
                            'الرسالة',
                            'أدخل الرسالة',
                          ),
                          onSaved: (value) {
                            message = value!;
                          },
                          validator: (value) {
                            return value!.isEmpty ? 'من فضلك ادخل الرسالة' : null;
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _submitForm,
                          child: Text('ارسال',
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
