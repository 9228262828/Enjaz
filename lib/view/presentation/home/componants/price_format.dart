import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../../../shared/global/app_colors.dart';

class PriceWidget extends StatelessWidget {
  final String? price; // Price as a string
  final TextStyle? style;

  PriceWidget({this.price, this.style});

  @override
  Widget build(BuildContext context) {
    // Parse the price string to an integer (fallback to null if it fails)
    final int? parsedPrice = int.tryParse(price ?? '');

    // Format the price with a period as thousands separator, or show "N/A"
    final formattedPrice = parsedPrice != null
        ? NumberFormat('#,##0', 'en_US').format(parsedPrice).replaceAll(',', ',')
        : "N/A";

    return Text(
      "$formattedPrice ج.م",
      style: style,
    );
  }
}
