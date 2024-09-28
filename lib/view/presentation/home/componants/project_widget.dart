import 'package:enjaz/view/presentation/home/componants/speed_dial.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../shared/global/app_colors.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/utils/app_values.dart';

class ProjectWidget extends StatelessWidget {
 final String image;
 final String title;
 final String location;
 final String price;
  const ProjectWidget ({super.key, required this.image, required this.title,  required this.location, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section with favorite and share icons
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.network(
              image ,
              height: mediaQueryHeight(context) * 0.22,
              width: double .infinity,
              fit: BoxFit.fill,
            ),
          ),

          // Property Info section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title as String,
                  style: Theme.of(context ).textTheme.displayMedium!.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: mediaQueryHeight(context) * 0.01),
                Text(
                  location ,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[300],
          ),

          // Pricing info section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "السعر يبدء من :"+ price + ' ج.م',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.boldGrey,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    openWhatsApp();

                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
                SizedBox(
                  width: mediaQueryWidth(context) * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    print('jsdlkczxnm  ');
                  },
                  child: CircleAvatar(
                      radius: 15,
                      backgroundImage: Image.asset(
                        ImageAssets.zoom,
                      ).image
                  ),
                ),
                SizedBox(
                  width: mediaQueryWidth(context) * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    makePhoneCall();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      FontAwesomeIcons.phone,
                      color: Colors.green,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
