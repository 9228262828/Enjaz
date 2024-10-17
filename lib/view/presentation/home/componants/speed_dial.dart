import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/global/app_colors.dart';

SpeedDialChild buildphone(BuildContext context) {
  return SpeedDialChild(
    shape:  CircleBorder(),
    child: Icon(Icons.phone, color: Colors.white),
    backgroundColor: AppColors.offBlue.withOpacity(.5),
    onTap: () {
      makePhoneCall();
    },
  );
}

void makePhoneCall() async {
  const phoneNumber = 'tel:+201098000666';
  if (await launchUrl(Uri.parse(phoneNumber))) {
    await launchUrl(Uri.parse (phoneNumber));
  } else {
    throw 'Could not launch $phoneNumber';
  }
}
SpeedDialChild buildWhatsapp(BuildContext context,String text) {
  return SpeedDialChild(
    shape:  CircleBorder(),
    child: FaIcon(
      FontAwesomeIcons.whatsapp,
      color: Colors.white,
    ),
    backgroundColor: Colors.green,
    onTap: () {
      openWhatsApp(
        text: 'استفساراي عن $text'
      );
    },
  );
}

void openWhatsApp(
    {required String text,}
    ) async {
  final Uri whatsappUri = Uri.parse('https://wa.me/201098000666?text= $text  (phone)');

  if (await launchUrl(whatsappUri)) {
    await launchUrl(whatsappUri,);
  } else {
    throw 'Could not launch $whatsappUri';
  }
}
void openGmail() async {
  final Uri emailUri = Uri.parse('mailto:info@enjazproperty.com');

  if (await launchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    throw 'Could not launch $emailUri';
  }
}