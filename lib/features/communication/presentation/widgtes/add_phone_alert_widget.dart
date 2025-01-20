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
class AddPhoneAlertWidget extends StatelessWidget {
  int? indexInList;
  Communication? communication;
  AddPhoneAlertWidget({super.key,this.indexInList,this.communication});
  TextEditingController phoneTextEditingController = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    phoneTextEditingController = TextEditingController(text: communication?.content);
    return AlertDialogWidget(
        title: 'Edit phone number',
        textButton: 'Save',
        widget: Form(
          key: globalKey,
          child: Column(
            children: [
              LoadingCommunicationWidget(message: communication==null?'Add Phone Number Successfully':'Update Phone Successfully'),
              // LoadingProfileWidget(message: 'Update Name Successfully'),
              LabelAndWidget(
                label: 'Phone Number',
                widget: AppTextFormField(
                  textInputType: TextInputType.phone,
                  controller: phoneTextEditingController,
                  hintText: 'Phone Number',
                  validator: (value) {
                    if (value == null) {
                      return 'Enter Phone Number';
                    }
                  },
                  prefixIcon: Icon(Icons.phone,size: 20,color: ColorsManager.neutralGray),
                ),
              ),
            ],
          ),
        ),
        onTapButton: () {
          if(globalKey.currentState!.validate()){
              if(communication!=null){
              context.read<CommunicationCubit>().emitUpdateCommunicationUseCase(data: {
                'content':phoneTextEditingController.text
              }, content: phoneTextEditingController.text, id: communication!.id, index: indexInList!);

            }else if(communication==null){
                context.read<CommunicationCubit>().emitAddCommunicationUseCase(data: {
                  'name':'Phone Number',
                  'type':'number',
                  'content':phoneTextEditingController.text
                });
              }
          }
        }
    );
  }
}
