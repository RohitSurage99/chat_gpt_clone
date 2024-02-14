
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_chat_app/constants/constants.dart';
import 'package:my_chat_app/models/chat_model.dart';
import 'package:my_chat_app/providers/models_provider.dart';
import 'package:my_chat_app/services/api_services.dart';
import 'package:my_chat_app/widgets/chat_widget.dart';
import 'package:provider/provider.dart';
import '../services/assets_manager.dart';
import '../services/services.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

   bool _isTyping = false;

   late FocusNode focusNode;
   late TextEditingController textEditingController;
  @override
  void initState() {
    focusNode = FocusNode();
    textEditingController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  List<ChatModel> chatList = [];

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    return Scaffold(
      appBar: AppBar(elevation: 2,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.openaiLogo),
        ),
        title: const Text("ChatGPT"),
        actions: [
          IconButton(
            onPressed: () async {
              await Services.showModalSheet(context: context);
            },
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.white,),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  itemCount: chatList.length,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      msg: chatList[index].msg,
                      chatIndex: chatList[index].chatIndex,
                      // msg: chatMessages[index]["msg"].toString(),
                      //  chatIndex: int.parse(
                      //   chatMessages[index]["chatIndex"].toString()),
                      //chatIndex:
                    );
                  }
              ),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 20,
              ),
            ],
            const SizedBox(height: 18,),
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                         focusNode: focusNode,
                        style: const TextStyle(color: Colors.white),
                        controller: textEditingController,
                        onSubmitted: (value) async {
                          await sendMessageFCT(
                            modelsProvider: modelsProvider,
                          );
                        },
                        decoration: const InputDecoration.collapsed(
                            hintText: "How can i help you",
                            hintStyle: TextStyle(color: Colors.grey)
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          await sendMessageFCT(modelsProvider: modelsProvider,);
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,)
                    )
                  ],
                ),
              ),
            )
          ],

        ),
      ),
    );
  }
  Future<void> sendMessageFCT (
      {required ModelsProvider modelsProvider}) async {
     try {
       setState(() {
         _isTyping = true;
         chatList.add(ChatModel(
             msg: textEditingController.text,
             chatIndex: 0));
         textEditingController.clear();
         focusNode.unfocus();

       });
       chatList.addAll(await ApiService.sendMessage(
         message: textEditingController.text,
         modelId: modelsProvider.getCurrentModel,
       )
     );
       setState(() {

       });
     } catch (error) {
     log("error $error");
     } finally {
       setState(() {
         _isTyping = false;
       });
     }
     }
   }
