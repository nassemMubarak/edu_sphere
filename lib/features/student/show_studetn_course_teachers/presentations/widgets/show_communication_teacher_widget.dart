import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/communication/domain/entities/communication.dart';
import 'package:edu_sphere/features/communication/presentation/pages/communication_main_page.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowCommunicationTeacherWidget extends StatelessWidget {
  List<Communication> communications;
   ShowCommunicationTeacherWidget({super.key,required this.communications});

  @override
  Widget build(BuildContext context) {
    return SectionCard(title: 'Communication',
      icon: 'assets/svgs/communication_icon.svg',
      widget: communications.isNotEmpty?Column(
        children: [
          Visibility(
            visible: searchCommunication('Phone Number', communications)!=null?true:false,
            child: _buildCommunicationOption(
              context: context,
              icon: const Icon(Icons.phone, color: ColorsManager.neutralGray),
              title: 'Phone Number',
              communicationList: communications,
              url: _getPhoneUrl(communications), // Pass WhatsApp URL
            ),
          ),
          Visibility(
            visible: searchCommunication('WhatsApp mobile', communications)!=null?true:false,

            child: _buildCommunicationOption(
              context: context,
              icon: SvgPicture.asset('assets/svgs/whats_app_icon.svg'),
              title: 'WhatsApp mobile',
              communicationList: communications,
              url: _getWhatsAppUrl(communications), // Pass WhatsApp URL
            ),
          ),
          Visibility(
            visible: searchCommunication('Telegram mobile', communications)!=null?true:false,
            child: _buildCommunicationOption(
              context: context,
              icon: SvgPicture.asset('assets/svgs/telegram_icon.svg'),
              title: 'Telegram mobile',
              communicationList: communications,
              url: _getTelegramUrl(communications), // Pass Telegram URL
            ),
          ),
          Visibility(
            visible: searchCommunication('Facebook account', communications)!=null?true:false,

            child: _buildCommunicationOption(
              context: context,
              icon: SvgPicture.asset('assets/svgs/facebook_icon.svg'),
              title: 'Facebook account',
              communicationList: communications,
              url: _getFacebookUrl(communications), // Pass Facebook URL
            ),
          ),

        ],
      ):ImageAndTextEmptyData(message: 'Not Added Communication')
      ,);
  }
  Communication? searchCommunication(String name, List<Communication> communication) {
    for (var comm in communication) {
      if (comm.name == name) {
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

  Widget _buildCommunicationOption({
    required BuildContext context,
    required Widget icon,
    required String title,
    required List<Communication> communicationList,
    String? url, // Add a URL parameter
  }) {
    final communication = searchCommunication(title, communicationList);
    return CommunicationOption(
      context: context,
      icon: icon,
      title: communication?.content ?? title,
      url: url, // Pass the URL
    );
  }
}
