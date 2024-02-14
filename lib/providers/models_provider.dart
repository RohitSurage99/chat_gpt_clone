import 'package:flutter/cupertino.dart';
import 'package:my_chat_app/models/models_model.dart';
import 'package:my_chat_app/services/api_services.dart';

class ModelsProvider with ChangeNotifier {

  String currentModel = "text-davinci-003";

  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelsModel> modelsList = [];

  List<ModelsModel> get getModelList {
    return modelsList;
  }

  Future<List<ModelsModel>> getAllModels() async {
    modelsList = await ApiService.getModels();
    return modelsList;
  }
}