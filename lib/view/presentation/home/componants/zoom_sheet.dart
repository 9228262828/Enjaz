import 'package:enjaz/shared/global/app_theme.dart';
import 'package:enjaz/shared/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'dart:convert';

import 'package:enjaz/shared/components/toast_component.dart';
import 'package:enjaz/shared/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../shared/global/app_colors.dart';

class ScheduleBottomSheet extends StatefulWidget {
  @override
  _ScheduleBottomSheetState createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final String scriptUrl =
     "https://script.google.com/macros/s/AKfycbyIckkZtDVbpMpb-eekNRnyW7LuKAsDoIbxFI_TB_Zkrqs3LGTXh2Bv7HnSVrTHMsgKgA/exec"; // Replace with your URL
  final _formKey = GlobalKey<FormState>();
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final response = await http.post(
          Uri.parse(scriptUrl),
          body: jsonEncode({
            'name': _nameController.text,
            'email': _selectedDate .toString(),
            'phone': _phoneController.text, // Include phone number in request body
            'message': _selectedTime.format(context).toString(),
          }),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          showToast(text: "تم ارسال الرسالة بنجاح", state: ToastStates.SUCCESS);
          print('Response: ${response.body}');
          Navigator.pop(context);
        } else {
          showToast(text: "تم ارسال الرسالة بنجاح", state: ToastStates.SUCCESS);
          print('Response: ${response.body}');
          Navigator.pop(context);

        }
      } catch (e) {
        showToast(text: "فشل في الارسال", state: ToastStates.ERROR);
        print('Error: $e');
      }
    }
  }
  String _selectedDate = '';
  TimeOfDay _selectedTime = TimeOfDay(hour: 10, minute: 0);

  // Function to generate the next 7 days dynamically (in Arabic)
  List<String> getNext7Days() {
    List<String> days = [];
    DateTime now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      DateTime date = now.add(Duration(days: i));
      String formattedDate =
          DateFormat('EEEE\ndd MMM', 'ar').format(date); // Format in Arabic
      days.add(formattedDate);
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    List<String> _dates = getNext7Days(); // Dynamically generate next 7 days

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: mediaQueryHeight(context) * 0.02),
                // Name Input
                TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: customInputDecoration(context, 'الاسم', 'ادخل الاسم'),
                ),
                SizedBox(height: mediaQueryHeight(context) * 0.02),
                // Phone Input
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: customInputDecoration(
                      context, 'رقم الهاتف', 'ادخل رقم الهاتف'),
                ),
                SizedBox(height: mediaQueryHeight(context) * 0.02),
                // Date Selection
                Text('اختر التاريخ', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: mediaQueryHeight(context) * 0.02),
                SizedBox(
                  height: mediaQueryHeight(context)*.1, // Set a fixed height for the horizontal list
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // Make the list scroll horizontally
                    itemCount: _dates.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ChoiceChip(
                          label: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _dates[index].split('\n')[0],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(_dates[index].split('\n')[1]),

                            ],
                          ),
                          selected: _selectedDate == _dates[index],
                          selectedColor: AppColors.primary,
                          // Color when selected
                          backgroundColor: Colors.grey.shade300,
                          // Background when not selected
                          labelStyle: TextStyle(
                            color: _selectedDate == _dates[index]
                                ? Colors.white
                                : Colors.black,
                          ),
                          onSelected: (selected) {
                            setState(() {
                              _selectedDate = _dates[index];
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: mediaQueryHeight(context) * 0.02),
                // Time Picker
                Text('اختر الوقت', style: TextStyle(fontWeight: FontWeight.bold)),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color:Color(0xFFFEAEAEA),
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8.0),
                      child: DropdownButton<TimeOfDay>(
                        borderRadius: BorderRadius.circular(5),
                        underline:  Container(

                        ),

                        style:  Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        value: _selectedTime,
                        items: [
                          TimeOfDay(hour: 10, minute: 0),
                          TimeOfDay(hour: 11, minute: 0),
                          TimeOfDay(hour: 12, minute: 0),
                          TimeOfDay(hour: 1, minute: 0),
                          TimeOfDay(hour: 2, minute: 0),
                          TimeOfDay(hour: 3, minute: 0),
                          TimeOfDay(hour: 4, minute: 0),
                          TimeOfDay(hour: 5, minute: 0),
                          TimeOfDay(hour: 6, minute: 0),
                        ].map((TimeOfDay time) {
                          return DropdownMenuItem<TimeOfDay>(
                            value: time,
                            child: Text(time.format(context)),
                          );
                        }).toList(),
                        onChanged: (TimeOfDay? newValue) {
                          setState(() {
                            _selectedTime = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: mediaQueryHeight(context) * 0.02),
                // Confirm Button
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ElevatedButton(
                    style:  ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF000000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),

                    ),
                    onPressed: () {
                      print('Phone: ${_phoneController.text}');
                      print('Name: ${_nameController.text}');
                      print('Selected Date: $_selectedDate');
                      print('Selected Time: ${_selectedTime.format(context)}');
                      print(
                          "'name': ${_nameController.text} 'date' $_selectedDate ,'phone': ${_phoneController.text}, body'time': ${_selectedTime.format(context)},"
                      );
                      _submitForm();
                    },
                    child: Text('تأكيد الموعد'),
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
