import 'package:enjaz/view/presentation/home/componants/price_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectDetails extends StatelessWidget {
  final dynamic project; // Replace with your actual project model.

  ProjectDetails({required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Table(
        border: TableBorder.all(
          color: Colors.grey, // Border color
          width: 1.0,         // Border width
        ),
        columnWidths: const {
          0: FractionColumnWidth(0.5), // Adjust the width of the first column
          1: FractionColumnWidth(0.5), // Adjust the width of the second column
        },
        children: [
          buildTableRow("موقع المشروع",
              project.location?.first ?? 'No location available',false),
          buildDividerRow(),
          buildTableRow("نوع المشروع",
              project.sections!.type?.name ?? 'No type available',false),
          buildDividerRow(),
          buildTableRow("الأسعار تبدأ من",
              project.price != null && project.price!.isNotEmpty
                  ? project.price![0].toString() // Pass PriceWidget
                  : 'No price available',true),
          buildDividerRow(),
          buildTableRow("أنظمة السداد",
              (project.downpayment != null &&
                  project.downpayment!.isNotEmpty &&
                  project.installment != null &&
                  project.installment!.isNotEmpty)
                  ? "مقدم ${project.downpayment![0]}, ${project.installment![0]} تقسيط"
                  : "No payment systems available",false),
        ],
      ),
    );
  }

  TableRow buildTableRow(String title, String value,bool isPrice ) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        isPrice?Padding(
          padding: const EdgeInsets.all(8.0),
          child: PriceWidget(price: value,style:TextStyle(color: Colors.black45, fontSize: 16),),
        ):
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value, // Ensure this is a string
            style: TextStyle(color: Colors.black45, fontSize: 16),
          ),
        ),
      ],
    );
  }

  TableRow buildDividerRow() {
    return const TableRow(
      children: [
        Divider(color: Colors.grey, height: 1.0),
        Divider(color: Colors.grey, height: 1.0),
      ],
    );
  }
}