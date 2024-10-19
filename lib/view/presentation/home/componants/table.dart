import 'package:enjaz/view/presentation/home/componants/price_format.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/app_values.dart';

class ProjectDetails extends StatelessWidget {
  final dynamic project; // Replace with your actual project model.

  ProjectDetails({required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Table(
        border: TableBorder.all(
          color: Color(0xFFEAEAEA), // Border color
          width: .5,
          borderRadius:
          const BorderRadius.all(Radius.circular(5)), // Border width
        ),
        columnWidths: const {
          0: FractionColumnWidth(0.5), // Adjust the width of the first column
          1: FractionColumnWidth(0.5), // Adjust the width of the second column
        },
        children: [
          buildTableRow("موقع المشروع",
              project.location?.first ?? 'No location available', false),
          buildDividerRow(),
          buildTableRow("نوع المشروع",
              project.sections!.type?.name ?? 'No type available', false),
          buildDividerRow(),
          buildTableRow(
              "الأسعار تبدأ من",
              project.price != null && project.price!.isNotEmpty
                  ? project.price![0].toString() // Pass PriceWidget
                  : 'No price available',
              true),
          buildDividerRow(),
          buildTableRow(
              "أنظمة السداد",
              (project.downpayment != null &&
                  project.downpayment!.isNotEmpty &&
                  project.installment != null &&
                  project.installment!.isNotEmpty)
                  ? "مقدم ${project.downpayment![0]}, ${project.installment![0]} تقسيط"
                  : "No payment systems available",
              false),
          buildDividerRow(),
         if (project.sections!.developer?.image !=
              null &&
              project.sections!.developer!.image !=
                  "false")...[

          buildDeveloperRow(context, "المطور العقاري")],
        ],
      ),
    );
  }

  TableRow buildTableRow(String title, String value, bool isPrice) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        isPrice
            ? Padding(
          padding: const EdgeInsets.all(12),
          child: PriceWidget(
            price: value,
            style: TextStyle(
                color: Colors.black45,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        )
            : Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            value, // Ensure this is a string
            style: TextStyle(
                color: Colors.black45,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  TableRow buildDeveloperRow(BuildContext context, String title) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Developer image
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: project.sections!.developer?.image != null &&
                    project.sections!.developer!.image != "false"
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image(
                    image:
                    NetworkImage(project.sections!.developer!.image!),
                    fit: BoxFit.cover,
                  ),
                )
                    : const SizedBox(),
              ),
              SizedBox(
                width: mediaQueryHeight(context) * 0.01,
              ),
              // Developer name
              Expanded(
                child: Text(
                  project.sections!.developer?.name ?? 'No developer name',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black45, // Adjust to match your style
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TableRow buildDividerRow() {
    return const TableRow(
      children: [
        Divider(color: Color(0xFFEAEAEA), height: 0.5),
        Divider(color: Color(0xFFEAEAEA), height: .5),
      ],
    );
  }


}
