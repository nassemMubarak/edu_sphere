import 'package:edu_sphere/core/widgets/warning_message_alert_dialog.dart';
import 'package:edu_sphere/features/teacher/profile/presentation/pages/profile_page.dart';
import 'package:edu_sphere/features/teacher/profile/presentation/widgets/edit_age_dialog.dart';
import 'package:edu_sphere/features/teacher/profile/presentation/widgets/edit_bio_dialog.dart';
import 'package:edu_sphere/features/teacher/profile/presentation/widgets/edit_email_dialog.dart';
import 'package:edu_sphere/features/teacher/profile/presentation/widgets/edit_gender.dart';
import 'package:edu_sphere/features/teacher/profile/presentation/widgets/edit_major_dialog.dart';
import 'package:edu_sphere/features/teacher/profile/presentation/widgets/edit_password_dialog.dart';
import 'package:edu_sphere/features/teacher/profile/presentation/widgets/edit_user_name_dialog.dart';
import 'package:edu_sphere/features/teacher/profile/presentation/widgets/profile_info_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileInfoSection extends StatelessWidget {
  const ProfileInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample user data; in a real application, this should come from a user model or state management.
    final user = UserProfile(
      name: 'Nassem Ah Mubarak',
      email: 'nassemmubarak@gmail.com',
      bio: 'bio bio bio',
      password: 'Password', // Typically, you wouldn't display the password
      sex: 'Male',
      level: 'Level 5',
      age: '15',
      major: 'University Major',
      campName: 'Camp Name',
    );

    return Column(
      children: [
        ProfileInfoRow(
          iconPath: 'assets/svgs/person_icon_outline.svg',
          label: user.name,
          onEdit: () {
           showDialog(context: context, builder: (context) => EditUserNameDialog());
          },
        ),
        ProfileInfoRow(
          iconPath: 'assets/svgs/email_icon.svg',
          label: user.email,
          onEdit: () {
           showDialog(context: context, builder: (context) => EditEmailDialog());
          },
        ),
        ProfileInfoRow(
          iconPath: 'assets/svgs/bio_icon.svg',
          label: user.bio,
          onEdit: () {
           showDialog(context: context, builder: (context) => EditBioDialog());
          },
        ),
        ProfileInfoRow(
          iconPath: 'assets/svgs/lock_icon.svg',
          label: user.password,
          onEdit: () {
           showDialog(context: context, builder: (context) => EditPasswordDialog());
          },
        ),
        ProfileInfoRow(
          iconPath: 'assets/svgs/mail_icon.svg',
          label: user.sex,
          onEdit: () {
           showDialog(context: context, builder: (context) => EditGender());
          },
        ),
        ProfileInfoRow(
          iconPath: 'assets/svgs/university_teacher.svg',
          label: user.major,
          onEdit: () {
            showDialog(context: context, builder: (context) => EditMajorDialog());
          },
        ),
        // ProfileInfoRow(
        //   iconPath: 'assets/svgs/educational.svg',
        //   label: user.level,
        //   onEdit: () {
        //     // Handle edit action for level
        //   },
        // ),
        ProfileInfoRow(
          iconPath: 'assets/svgs/circular-word-age.svg',
          label: user.age,
          onEdit: () {
            showDialog(context: context, builder: (context) => EditAgeDialog());
          },
        ),
        ProfileInfoRow(
          iconPath: 'assets/svgs/camp.svg',
          label: user.campName,
          onEdit: () {
            showDialog(context: context, builder: (context) => WarningMessageAlertDialog(changCampOnTap: (){},));
          },
        ),
      ],
    );
  }
}
