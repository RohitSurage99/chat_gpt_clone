import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:my_chat_app/models/chat_model.dart';
import 'package:my_chat_app/models/models_model.dart';


String BASE_URL = "https://api.openai.com/v1";
String  API_KEY = "your_api_key_here : ) ";

class ApiService{
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
       // Uri.parse("$BASE_URL/completions"),
        Uri.parse("$BASE_URL/models"),
        headers: {
          'Authorization': 'Bearer $API_KEY'
        },

      );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse ['error']!= null){
      print("jsonResponse ['error'] ${jsonResponse ['error']["message"]}");
        throw HttpException(jsonResponse ['error']["message"]);
      }
     print ("jsonResponse $jsonResponse");
      List temp = [];
      for (var value in jsonResponse["data"]){
        temp.add(value);
      //start: if we get only Id then apply this
       //      print("temp ${value["id"]}");
        //end: if we get only Id then apply this
        log("temp $value");

      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
    log("error $error");
      rethrow;
    }
  }

  // send message fun^

  static Future<List<ChatModel>> sendMessage( {
      required String message, required String modelId}) async {
    try {
      var response = await http.post(
        // Uri.parse("$BASE_URL/chat/completions"),
        Uri.parse("$BASE_URL/completions"),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          "Content-Type": "application/json"
        },
           body: jsonEncode(   {
             "model":  modelId,
             "prompt": message,
             "max_tokens": 100,
           },
           ),
           );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse ['error']!= null){
        //   print("jsonResponse ['error'] ${jsonResponse ['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }

      List<ChatModel> chatList =[];
      if (jsonResponse["choices"].length > 0){
     //   log("jsonResponse[choices]text ${jsonResponse["choices"][0]['text']}");
 chatList = List.generate(
   jsonResponse["choices"].length,
       (index) => ChatModel(
     msg: jsonResponse["choices"][index]['text'],
   chatIndex: 1,
     ),
     );
      }
      return chatList;

    } catch (error) {
      print ("this is error");
      log("error $error");
      rethrow;
    }
  }

}

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// // String BASE_URL = "https://api.openai.com/v1";
// // String  API_KEY = "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";
// //
// // class ApiService{
// //   static Future<List<ModelsModel>> getModels() async {
// //     try {
// //       var response = await http.get(
// //         Uri.parse("$BASE_URL/models"),
// //         headers: {'Authorization': 'Bearer $API_KEY'
// //
// //         },
// //       );
// //
// //       Map jsonResponse = jsonDecode(response.body);
// //
// //       // for error
// //       if (jsonResponse['error'] != null) {
// //         print("jsonResponse['error'] ${jsonResponse['error']['message']}");
// //         throw HttpException(jsonResponse['error']["message"]);
// //       }
// //        print ("jsonResponse $jsonResponse");
// //       List temp = [];
// //       for (var value in jsonResponse["data"]) {
// //         temp.add(value);
// //         log("temp $value");
// //       }
// //       return ModelsModel.modelsFromSnapshot(temp);
// //     } catch (error) {
// //       log("error $error");
// //       rethrow;
// //     }
// //   }
// // }
