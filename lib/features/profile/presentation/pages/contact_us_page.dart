import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverWidget(widget: Padding(padding: EdgeInsets.all(16),child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 4,
            color: ColorsManager.shadowColor.withOpacity(0.3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/svgs/contact_us_icon.svg',width: 24.h,height: 24.h),
              horizontalSpace(12),
              Text('Contact us',style: TextStyles.font16Black500Weight),
            ],
          ),
          verticalSpace(24),
          ListTile(
            contentPadding: EdgeInsetsDirectional.zero,
            onTap: (){
              _launchURL(context, 'tel:0592815701');
            },
            leading: const Icon(Icons.phone, color: ColorsManager.neutralGray),
            title: Text('Phone',style: TextStyles.font14Black400Weight,),
          ),
          verticalSpace(16),
          ListTile(
            contentPadding: EdgeInsetsDirectional.zero,
            onTap: (){
              _launchURL(context, 'https://wa.me/0592817501');
            },
            leading: SvgPicture.asset('assets/svgs/whats_app_icon.svg'),
            title: Text('WhatsApp mobile',style: TextStyles.font14Black400Weight,),
          ),
          verticalSpace(16),
          ListTile(
            contentPadding: EdgeInsetsDirectional.zero,
            onTap: (){
              _launchURL(context, 'https://t.me/0592817501');
            },
            leading: SvgPicture.asset('assets/svgs/telegram_icon.svg'),
            title: Text('Telegram mobile',style: TextStyles.font14Black400Weight,),
          ),
          verticalSpace(16),
          ListTile(
            contentPadding: EdgeInsetsDirectional.zero,
            onTap: (){
              _launchURL(context, 'https://t.me/0592817501');
            },
            leading: SvgPicture.asset('assets/svgs/facebook_icon.svg'),
            title: Text('Facebook account',style: TextStyles.font14Black400Weight,),
          ),
          verticalSpace(16),
        ],
      ),
    ),));
  }
  Future<void> _launchURL(BuildContext context,String url) async {
    if (await canLaunch(url)) {
      await launch(url,universalLinksOnly: true);
      return;
    }
    // Show an error message if no URL can be launched
    debugPrint('Could not launch any of the URLs: $url');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Could not open the Facebook app.')),
    );
  }

}
