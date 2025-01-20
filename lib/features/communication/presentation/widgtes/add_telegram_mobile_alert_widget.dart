import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/widgets/alert_dialog_widget.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/communication/domain/entities/communication.dart';
import 'package:edu_sphere/features/communication/presentation/bloc/communication_cubit.dart';
import 'package:edu_sphere/features/communication/presentation/widgtes/loading_communication_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AddTelegramMobileAlertWidget extends StatelessWidget {
  int? indexInList;
  Communication? communication;
  AddTelegramMobileAlertWidget({super.key,this.indexInList,this.communication});
  TextEditingController telegramTextEditingController = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    telegramTextEditingController = TextEditingController(text: communication?.content);

    return AlertDialogWidget(
        title: 'Edit Telegram mobile',
        textButton: 'Save',
        widget: Form(
          key: globalKey,
          child: Column(
            children: [
              LoadingCommunicationWidget(message: communication==null?'Add Telegram mobile Successfully':'Update Telegram mobile Successfully'),
              // LoadingProfileWidget(message: 'Update Name Successfully'),
              LabelAndWidget(
                label: 'Telegram mobile',
                widget: AppTextFormField(
                  textInputType: TextInputType.phone,
                  controller: telegramTextEditingController,
                  hintText: 'WhatsApp mobile',
                  validator: (value) {
                    if (value == null) {
                      return 'Enter WhatsApp mobile';
                    }
                  },
                  prefixIcon: Icon(Icons.telegram_rounded,size: 20,color: ColorsManager.neutralGray),
                ),
              ),
            ],
          ),
        ),
        onTapButton: () {
          if(globalKey.currentState!.validate()){
            if(communication!=null){
              context.read<CommunicationCubit>().emitUpdateCommunicationUseCase(data: {
                'content':telegramTextEditingController.text
              }, content: telegramTextEditingController.text, id: communication!.id, index: indexInList!);

            }else if(communication==null){
              context.read<CommunicationCubit>().emitAddCommunicationUseCase(data: {
                'name':'Telegram mobile',
                'type':'number',
                'content':telegramTextEditingController.text
              });
            }
          }
        }
    );
  }
}
