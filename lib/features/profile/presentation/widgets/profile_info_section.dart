import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/edit_age_dialog.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/edit_email_dialog.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/edit_gender.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/edit_level_dialog.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/edit_major_dialog.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/edit_password_dialog.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/edit_user_name_dialog.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/profile_info_row.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ProfileInfoSection extends StatelessWidget {
  User user;
   ProfileInfoSection({Key? key,required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  bool isStudent = user.type!.toUpperCase()=='STUDENT';
    // Sample user data; in a real application, this should come from a user model or state management.
    return Column(
      children: [
        ProfileInfoRow(
          iconPath: 'assets/svgs/person_icon_outline.svg',
          label: user.name,
          onEdit: () {
           showDialog(context: context, builder: (context) => EditUserNameDialog(user: user));
          },
        ),
        ProfileInfoRow(
          iconPath: 'assets/svgs/email_icon.svg',
          label: user.email,
          onEdit: () {
           showDialog(context: context, builder: (context) => EditEmailDialog(user: user));
          },
        ),
        // ProfileInfoRow(
        //   iconPath: 'assets/svgs/bio_icon.svg',
        //   label: user.bio,
        //   onEdit: () {
        //    showDialog(context: context, builder: (context) => EditBioDialog());
        //   },
        // ),
        ProfileInfoRow(
          iconPath: 'assets/svgs/lock_icon.svg',
          label: 'Password',
          onEdit: () {
           showDialog(context: context, builder: (context) => EditPasswordDialog(user: user));
          },
        ),
        ProfileInfoRow(
          iconPath: 'assets/svgs/mail_icon.svg',
          label: user.sex,
          onEdit: () {
           showDialog(context: context, builder: (context) => EditGender(user: user));
          },
        ),
        if(!isStudent&&user.specialization!=null)
          ProfileInfoRow(
            iconPath: 'assets/svgs/university_teacher.svg',
            label: user.specialization!,
            onEdit: () {
              showDialog(context: context, builder: (context) => EditMajorDialog(user: user,));
            },
          ),
        if(isStudent&&user.level!=null)
            ProfileInfoRow(
              iconPath: 'assets/svgs/educational.svg',
              label: user.level!.toString(),
              onEdit: () {
              showDialog(context: context, builder: (context) => EditLevelDialog(user: user,));
                // Handle edit action for level
              },
            ),
        ProfileInfoRow(
          iconPath: 'assets/svgs/circular-word-age.svg',
          label: user.age.toString(),
          onEdit: () {
            showDialog(context: context, builder: (context) => EditAgeDialog(user: user,));
          },
        ),
        // ProfileInfoRow(
        //   iconPath: 'assets/svgs/camp.svg',
        //   label: user.??'',
        //   onEdit: () {
        //     showDialog(context: context, builder: (context) => WarningMessageAlertDialog(changCampOnTap: (){},));
        //   },
        // ),
      ],
    );
  }
}
