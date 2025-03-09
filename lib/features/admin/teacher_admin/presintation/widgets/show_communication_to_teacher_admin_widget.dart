import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/teacher_informstion.dart';
import 'package:edu_sphere/features/communication/domain/entities/communication.dart';
import 'package:edu_sphere/features/communication/presentation/pages/communication_main_page.dart';
import 'package:edu_sphere/features/communication/presentation/widgtes/add_facebook_alert_widget.dart';
import 'package:edu_sphere/features/communication/presentation/widgtes/add_phone_alert_widget.dart';
import 'package:edu_sphere/features/communication/presentation/widgtes/add_telegram_mobile_alert_widget.dart';
import 'package:edu_sphere/features/communication/presentation/widgtes/add_whatsApp_mobile_alert_widget.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowCommunicationToTeacherAdminWidget extends StatelessWidget {
  TeacherInformation teacherInformation;
  ShowCommunicationToTeacherAdminWidget({
    super.key,
     required this.teacherInformation
  });

  @override
  Widget build(BuildContext context) {
    Logger().e(teacherInformation);
    return teacherInformation.communications.isNotEmpty?_buildCommunicationSection(context,  teacherInformation.communications)        :SectionCard(
      title: 'Communication',
      icon: 'assets/svgs/communication_icon.svg',
    widget: ImageAndTextEmptyData(
    message: 'There is no communication yet'),
    );
  }
  Widget _buildCommunicationSection(BuildContext context,List<Communication> communicationList) {
    return SectionCard(
      title: 'Communication',
      icon: 'assets/svgs/communication_icon.svg',
      widget: Column(
        children: [
          verticalSpace(10),
          _buildCommunicationOption(
            context: context,
            icon: const Icon(Icons.phone, color: ColorsManager.neutralGray),
            title: 'Phone Number',
            communicationList: communicationList,
            alertWidgetBuilder: (communication, index) => AddPhoneAlertWidget(
              communication: communication,
              indexInList: index,
            ),
            url: _getPhoneUrl(communicationList), // Pass WhatsApp URL
          ),
          _buildCommunicationOption(
            context: context,
            icon: SvgPicture.asset('assets/svgs/whats_app_icon.svg'),
            title: 'WhatsApp mobile',
            communicationList: communicationList,
            alertWidgetBuilder: (communication, index) => AddWhatsappMobileAlertWidget(
              communication: communication,
              indexInList: index,
            ),
            url: _getWhatsAppUrl(communicationList), // Pass WhatsApp URL
          ),
          _buildCommunicationOption(
            context: context,
            icon: SvgPicture.asset('assets/svgs/telegram_icon.svg'),
            title: 'Telegram mobile',
            communicationList: communicationList,
            alertWidgetBuilder: (communication, index) => AddTelegramMobileAlertWidget(
              communication: communication,
              indexInList: index,
            ),
            url: _getTelegramUrl(communicationList), // Pass Telegram URL
          ),
          _buildCommunicationOption(
            context: context,
            icon: SvgPicture.asset('assets/svgs/facebook_icon.svg'),
            title: 'Facebook account',
            communicationList: communicationList,
            alertWidgetBuilder: (communication, index) => AddFacebookAlertWidget(
              communication: communication,
              indexInList: index,
            ),
            url: _getFacebookUrl(communicationList), // Pass Facebook URL
          ),
        ],
      ),
    );
  }
  Widget _buildCommunicationOption({
    required BuildContext context,
    required Widget icon,
    required String title,
    required List<Communication> communicationList,
    required Widget Function(Communication?, int?) alertWidgetBuilder,
    String? url, // Add a URL parameter
  }) {
    final communication = searchCommunication(title, communicationList);
    return CommunicationOption(
      context: context,
      icon: icon,
      title: communication?.content ?? title,
      // trailingIcon: 'assets/svgs/edite_icon.svg',
      onTapEdit: () {
        showDialog(
          context: context,
          builder: (context) => alertWidgetBuilder(
            communication,
            communication == null ? null : communicationList.indexOf(communication),
          ),
        );
      },
      url: url, // Pass the URL
    );
  }

  Communication? searchCommunication(String name, List<Communication> communication) {
    Logger().e(communication);
    for (var comm in communication) {
      if (comm.name == name) {
        Logger().f(comm);
        return comm;
      }
    }
    return null; // Return null if no match is found
  }

  // Helper function to generate Telegram URL
  String? _getTelegramUrl(List<Communication> communicationList) {
    final communication = searchCommunication('Telegram mobile', communicationList);
    if (communication != null && communication.content != null) {
      return "https://t.me/${communication.content}"; // Correct Telegram URL format
    }
    return null;
  }

// Helper function to generate WhatsApp URL
  String? _getWhatsAppUrl(List<Communication> communicationList) {
    final communication = searchCommunication('WhatsApp mobile', communicationList);
    if (communication != null && communication.content != null) {
      return "https://wa.me/${communication.content}"; // WhatsApp URL format
    }
    return null;
  }

// Helper function to generate Facebook URL
  String? _getFacebookUrl(List<Communication> communicationList) {
    final communication = searchCommunication('Facebook account', communicationList);
    if (communication != null && communication.content != null) {
      return communication.content; // Return both URLs for fallback
    }
    return null;
  }


// Helper function to generate Phone URL
  String? _getPhoneUrl(List<Communication> communicationList) {
    final communication = searchCommunication('Phone Number', communicationList);
    if (communication != null && communication.content != null) {
      return "tel:${communication.content}"; // Phone dialer URL format
    }
    return null;
  }
}
