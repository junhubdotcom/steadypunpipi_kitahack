import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

class ChatPet extends StatefulWidget {
  @override
  State<ChatPet> createState() => _ChatPetState();
}

class _ChatPetState extends State<ChatPet> {
  final Gemini gemini = Gemini.instance;
  final ChatUser currentUser = ChatUser(id: "0", firstName: "Me");
  final ChatUser geminiUser = ChatUser(
      id: "1", firstName: "Gemini", profileImage: "assets/images/temppet.png");
  List<ChatMessage> messages = [];

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      List<Uint8List>? images;
      ChatMessage? lastMessage;

      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
        ];
      }

      gemini
          .streamGenerateContent(
        question,
        images: images,
      )
          .listen((event) {
        String responseChunk =
            event.content?.parts?.fold("", (previous, current) {
                  if (current is TextPart) {
                    return "$previous${current.text}";
                  } else {
                    return previous;
                  }
                }) ??
                "";

        setState(() {
          if (lastMessage == null) {
            lastMessage = ChatMessage(
              text: responseChunk,
              user: geminiUser,
              createdAt: DateTime.now(),
            );
            messages.insert(0, lastMessage!);
          } else {
            lastMessage!.text += responseChunk;
          }
        });
      }, onError: (error) {
        print("Gemini API Error: $error");
      }, onDone: () {
        lastMessage = null; //reset last message.
      });
    } catch (e) {
      print("General Error: $e");
      // Handle general errors
    }
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        text: "Describe this image",
        user: currentUser,
        medias: [
          ChatMedia(
            url: file.path,
            fileName: "",
            type: MediaType.image,
          )
        ],
        createdAt: DateTime.now(),
      );
      _sendMessage(chatMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DashChat(
      inputOptions: InputOptions(trailing: [
        IconButton(
            onPressed: _sendMediaMessage,
            icon: const Icon(
              Icons.image,
            ))
      ]),
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }
}
