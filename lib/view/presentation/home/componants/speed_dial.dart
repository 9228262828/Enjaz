import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/global/app_colors.dart';

SpeedDialChild buildphone(BuildContext context) {
  return SpeedDialChild(
    child: Icon(Icons.phone, color: Colors.white),
    backgroundColor: AppColors.primary,
    onTap: () {
      makePhoneCall();
    },
  );
}

void makePhoneCall() async {
  const phoneNumber = 'tel:+201127314881';
  if (await launchUrl(Uri.parse(phoneNumber))) {
    await launchUrl(Uri.parse (phoneNumber));
  } else {
    throw 'Could not launch $phoneNumber';
  }
}
SpeedDialChild buildWhatsapp(BuildContext context) {
  return SpeedDialChild(
    child: FaIcon(
      FontAwesomeIcons.whatsapp,
      color: Colors.white,
    ),
    backgroundColor: Colors.green,
    onTap: () {
      openWhatsApp();
    },
  );
}

void openWhatsApp() async {
  final Uri whatsappUri = Uri.parse('https://wa.me/201204232759?text=phone');

  if (await launchUrl(whatsappUri)) {
    await launchUrl(whatsappUri,);
  } else {
    throw 'Could not launch $whatsappUri';
  }
}
