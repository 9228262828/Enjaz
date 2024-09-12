import 'package:enjaz/shared/global/app_colors.dart';
import 'package:flutter/material.dart';

class AdvancedSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('خيارات البحث',style: Theme .of(context).textTheme.titleMedium,),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputSection(
                context: context,

                label: 'اسم المشروع',
                icon: Icons.business,
                isDropdown: false,
              ),
              SizedBox(height: 16),

              // Region Dropdown
              _buildInputSection(
                context: context,

                label: 'المنطقة',
                icon: Icons.location_on,
                isDropdown: true,
                dropdownItems: ['المنطقة 1', 'المنطقة 2', 'المنطقة 3'],
              ),
              SizedBox(height: 16),

              // Project Type Dropdown
              _buildInputSection(
                context: context,
                label: 'نوع المشروع',
                icon: Icons.home,
                isDropdown: true,
                dropdownItems: ['نوع 1', 'نوع 2', 'نوع 3'],
              ),

              // Search Button

            ],
          ),
        ),
        bottomNavigationBar:    Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // Add search functionality here
              },
              icon: Icon(Icons.search),
              label: Text('بحث'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16), backgroundColor: AppColors.primary, // Adjust the button color
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
  // Helper method to build input sections
  Widget _buildInputSection({
    required BuildContext context,
    required String label,
    required IconData icon,
    required bool isDropdown,
    List<String>? dropdownItems,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, style: Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontWeight: FontWeight.w500,
    ),
        ),
        SizedBox(height: 8),
        isDropdown
            ? _buildDropdown(context, dropdownItems!)
            : _buildTextField(context,"اسم المشروع", icon),
      ],
    );
  }

  // TextField for input
  Widget _buildTextField(context, String hint, IconData icon) {
    return TextField(style: Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontWeight: FontWeight.w500,
    ),
      decoration: InputDecoration(
        hintText: hint,
        labelStyle:   Theme.of(context).textTheme.bodyMedium!.copyWith(

        ),
        hintStyle:  Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.dark
        ),
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),
    );
  }

  // DropdownButton for dropdown selection
  Widget _buildDropdown(context, List<String> items) {
    String? selectedValue;
    return DropdownButtonFormField<String>(
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w500,
      ),
      value: selectedValue,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),
      items: items
          .map((item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      ))
          .toList(),
      onChanged: (value) {
        selectedValue = value;
      },
      hint: Text('اختر من القائمة'),
    );
  }
}

