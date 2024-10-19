import 'package:enjaz/view/presentation/home/componants/price_format.dart';
import 'package:enjaz/view/presentation/home/componants/speed_dial.dart';
import 'package:enjaz/view/presentation/home/componants/zoom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../shared/global/app_colors.dart';
import '../../../../shared/utils/app_assets.dart';
import '../../../../shared/utils/app_values.dart';
import '../data/project_model.dart';

class ProjectWidget extends StatelessWidget {
 final String? image;
 final String? title;
 final String? location;
 final String? price;
 final String? phone;
 final Project project;

  const ProjectWidget ({super.key, required this.image, required this.title,  required this.location, required this.price, required this.phone, required this.project,  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
       border: Border.all(color: Color(0xFFFEAEAEA), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section with favorite and share icons
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            child: Image.network(
              image ??"",
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
                    color: Color(0xFF0F0F0F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: mediaQueryHeight(context) * 0.01),
                Row(
                  children: [
                    Icon(
                     Icons.location_on_outlined,
                      size: 15,
                      color: Colors.grey[600],),
                    SizedBox(width: mediaQueryWidth(context) * 0.01),
                    Text(
                      location ??"",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    if (project.sections!.developer != null)
                    Row(
                      children: [
                        Icon(
                         Icons.location_city_outlined,
                          size: 15,
                          color: Colors.grey[600],),
                        SizedBox(width: mediaQueryWidth(context) * 0.01),

                        Text(
                          project.sections!.developer!.name ??"",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: Color(0xFFFEAEAEA),
          ),

          // Pricing info section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "السعر يبدأ من : ",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.dark,
                        ),
                      ),
                      price == ""?
                      const Text(
                         "N/A",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: AppColors.dark,
                        ),
                      )
                      :

                      PriceWidget(
                        price: price ,)
                    ],
                  ),
                ),

                Spacer(),
                GestureDetector(
                  onTap: () {
                    openWhatsApp(
                      text: '  استفساراي عن $phone '
                    );

                  },
                  child: Container(

                    decoration: BoxDecoration(

                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      ImageAssets.whatsApp,
                   width: mediaQueryWidth(context) * 0.08,
                  ),  ),
                ),
                SizedBox(
                  width: mediaQueryWidth(context) * 0.025
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Directionality(
                            textDirection: TextDirection.rtl,
                            child: ScheduleBottomSheet());
                      },
                    );
                  },
                  child: Container(

                    decoration: BoxDecoration(

                      shape: BoxShape.circle,
                    ),
                    child:  CircleAvatar(
                        radius: 15,
                        backgroundImage: Image.asset(
                          ImageAssets.zoom,
                        ).image
                    ),  ),
                ),
                SizedBox(
                  width: mediaQueryWidth(context) * 0.025
                ),
                GestureDetector(
                  onTap: () {
                    makePhoneCall();
                  },
                  child: Image.asset(
                    ImageAssets.phone,
                   width: mediaQueryWidth(context) * 0.08,
                  ),
                ),
                SizedBox(
                  width: mediaQueryWidth(context) * 0.025
                ),
                GestureDetector(
                  onTap: () {
                    openGmail();
                  },
                  child: Container(

                    decoration: BoxDecoration(

                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      ImageAssets.email,
                     width: mediaQueryWidth(context) * 0.08,
                    ),  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

