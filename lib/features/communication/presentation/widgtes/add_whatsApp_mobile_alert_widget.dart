import 'package:edu_sphere/core/widgets/alert_dialog_widget.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/communication/domain/entities/communication.dart';
import 'package:edu_sphere/features/communication/presentation/bloc/communication_cubit.dart';
import 'package:edu_sphere/features/communication/presentation/widgtes/loading_communication_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AddWhatsappMobileAlertWidget extends StatelessWidget {
  int? indexInList;
  Communication? communication;
  AddWhatsappMobileAlertWidget({super.key,this.indexInList,this.communication});
  TextEditingController whatsAppTextEditingController = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    whatsAppTextEditingController = TextEditingController(text: communication?.content);
    return AlertDialogWidget(
        title: 'Edit WhatsApp mobile',
        textButton: 'Save',
        widget: Form(
          key: globalKey,
          child: Column(
            children: [
              LoadingCommunicationWidget(message: communication==null?'Add WhatsApp mobile Successfully':'Update WhatsApp mobile Successfully'),

              LabelAndWidget(
                label: 'WhatsApp mobile',
                widget: AppTextFormField(
                  textInputType: TextInputType.phone,
                  controller: whatsAppTextEditingController,
                  hintText: 'WhatsApp mobile',
                  validator: (value) {
                    if (value == null) {
                      return 'Enter WhatsApp mobile';
                    }
                  },

                ),
              ),
            ],
          ),
        ),
        onTapButton: () {
          if(globalKey.currentState!.validate()){
            if(communication!=null){
              context.read<CommunicationCubit>().emitUpdateCommunicationUseCase(data: {
                'content':whatsAppTextEditingController.text
              }, content: whatsAppTextEditingController.text, id: communication!.id, index: indexInList!);

            }else if(communication==null){
              context.read<CommunicationCubit>().emitAddCommunicationUseCase(data: {
                'name':'WhatsApp mobile',
                'type':'number',
                'content':whatsAppTextEditingController.text
              });
            }
          } }
    );
  }
}
