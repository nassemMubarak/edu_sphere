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
import 'package:logger/logger.dart';
class AddFacebookAlertWidget extends StatelessWidget {
  int? indexInList;
  Communication? communication;
  AddFacebookAlertWidget({super.key,this.indexInList,this.communication});
  TextEditingController facebookTextEditingController = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Logger().f('message------------------------$communication');
    facebookTextEditingController = TextEditingController(text: communication?.content);
    return AlertDialogWidget(
        title: 'Edit Facebook account Url',
        textButton: 'Save',
        widget: Form(
          key: globalKey,
          child: Column(
            children: [
              LoadingCommunicationWidget(message: communication==null?'Add Facebook account Successfully':'Update Facebook account Successfully'),
              LabelAndWidget(
                label: 'Facebook account',
                widget: AppTextFormField(
                  textInputType: TextInputType.url,
                  controller: facebookTextEditingController,
                  hintText: 'Facebook account',
                  validator: (value) {
                    if (value == null) {
                      return 'Enter Facebook account';
                    }
                  },
                  prefixIcon: Icon(Icons.facebook,size: 20,color: ColorsManager.neutralGray),
                ),
              ),
            ],
          ),
        ),
        onTapButton: () {
          if(globalKey.currentState!.validate()){
            if(communication!=null){
              context.read<CommunicationCubit>().emitUpdateCommunicationUseCase(data: {
                'content':facebookTextEditingController.text
              }, content: facebookTextEditingController.text, id: communication!.id, index: indexInList!);

            }else if(communication==null){
              context.read<CommunicationCubit>().emitAddCommunicationUseCase(data: {
                'name':'Facebook account',
                'type':'url',
                'content':facebookTextEditingController.text
              });
            }
          }
        }
    );
  }
}
