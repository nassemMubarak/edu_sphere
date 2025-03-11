import 'package:edu_sphere/core/helpers/constants.dart';
import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/shared_pref_helper.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/alert_dialog_widget.dart';
import 'package:flutter/cupertino.dart';

class LogoutAlertDialogWidget extends StatelessWidget {
  const LogoutAlertDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(title: 'Logout', textButton: 'Logout', widget: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Do you really want to logout ?',style: TextStyles.font14Red500Weight,textAlign: TextAlign.center,),
        verticalSpace(16),
        Text('If you log out, you will have to retype your username and password again',style: TextStyles.font12Black400Weight,textAlign: TextAlign.center),
      ],
    ), onTapButton: ()async{
      await SharedPrefHelper.removeData(SharedPrefKeys.cachedUser);
      await SharedPrefHelper.removeData(SharedPrefKeys.cachedToken);
      await SharedPrefHelper.removeData(SharedPrefKeys.cachedIsCampSuccess);
      context.pushReplacementNamed(Routes.loginScreen);
    });
  }
}
