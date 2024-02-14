import 'package:flutter/material.dart';
import 'package:my_chat_app/constants/constants.dart';
import 'package:my_chat_app/models/models_model.dart';
import 'package:my_chat_app/providers/models_provider.dart';
import 'package:my_chat_app/services/api_services.dart';
import 'package:my_chat_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class ModelDropDownWidget extends StatefulWidget {
  const ModelDropDownWidget({Key? key}) : super(key: key);

  @override
  State<ModelDropDownWidget> createState() => _ModelDropDownWidgetState();
}

class _ModelDropDownWidgetState extends State<ModelDropDownWidget> {
  String? currentModel;

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    currentModel = modelsProvider.getCurrentModel;
    return FutureBuilder<List<ModelsModel>>(
        future: modelsProvider.getAllModels(),
        builder: (context, snapShot) {
          if (snapShot.hasError) {
            return Center(
              child: TextWidget(
                  label: snapShot.error.toString()),
            );
          }

          return snapShot.data == null
              || snapShot.data!.isEmpty
              ? const SizedBox.shrink()
              : FittedBox(
            child: DropdownButton(
              dropdownColor: scaffoldBackgroundColor,
              iconEnabledColor: Colors.white,
              items: List<DropdownMenuItem<String>>.generate(
                  snapShot.data!.length,
                      (index) =>
                      DropdownMenuItem(
                          value: snapShot.data![index].id,
                          child: TextWidget(
                            label: snapShot.data![index].id,
                            fontSize: 15,
                          ))),
              value: currentModel,
              onChanged: (value) {
                setState(() {
                  currentModel = value.toString();
                });
                modelsProvider.setCurrentModel(
                  value.toString(),
                );
              },
            ),
          );
        }
    );
  }
}


/*DropdownButton(
      dropdownColor: scaffoldBackgroundColor,
        items: getModelsItem,
        value: currentModels,
        iconEnabledColor: Colors.white,
        onChanged: (value) {
          setState(() {
            currentModels = value.toString();
          });
        },
    );*/
