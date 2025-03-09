import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:logger/logger.dart';

// Import your project-specific files
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/communication/domain/entities/communication.dart';
import 'package:edu_sphere/features/communication/presentation/bloc/communication_cubit.dart';
import 'package:edu_sphere/features/communication/presentation/widgtes/add_facebook_alert_widget.dart';
import 'package:edu_sphere/features/communication/presentation/widgtes/add_phone_alert_widget.dart';
import 'package:edu_sphere/features/communication/presentation/widgtes/add_telegram_mobile_alert_widget.dart';
import 'package:edu_sphere/features/communication/presentation/widgtes/add_whatsApp_mobile_alert_widget.dart';
import 'package:edu_sphere/features/communication/presentation/widgtes/communication_section_card_shimmer.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';

class CommunicationMainPage extends StatelessWidget {
  const CommunicationMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CommunicationCubit>().emitGetAllCommunicationUseCase();
    return SliverWidget(
      widget: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: BlocBuilder<CommunicationCubit, CommunicationState>(
          builder: (context, state) {
            if (state is GetAllCommunicationLoadingState) {
              return const CommunicationSectionCardShimmer();
            } else if (state is GetAllCommunicationLoadedDataState) {
              Logger().f('------------${state.communication}');
              return _buildCommunicationSection(context,state.communication);
            }
            return _buildCommunicationSection(context,context.read<CommunicationCubit>().communicationList);
          },
        ),
      ),
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
      trailingIcon: 'assets/svgs/edite_icon.svg',
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

class CommunicationOption extends StatelessWidget {
  final BuildContext context;
  final Widget icon;
  final String title;
  final String? trailingIcon;
  final Function()? onTapEdit;
  final String? url;

  const CommunicationOption({
    super.key,
    required this.context,
    required this.icon,
    required this.title,
     this.trailingIcon,
    this.onTapEdit,
    this.url,
  });

  Future<void> _launchURL(String url) async {
    Logger().e(url);
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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: icon,
      title: Text(
        title,
        style: TextStyles.font14NeutralGray400Weight,
      ),
      trailing: trailingIcon==null?null:GestureDetector(
        onTap: onTapEdit,
        child: SvgPicture.asset(trailingIcon!),
      ),
      onTap: () {
        if (url != null) {
          _launchURL(url!); // Launch the URL when the option is tapped
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No valid URL found for $title.')),
          );
        }
      },
    );
  }
}
