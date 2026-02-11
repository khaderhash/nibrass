import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/models/chat_message.dart';

class ChatController extends GetxController {
  final DioClient dioClient = DioClient(Dio(), const FlutterSecureStorage());

  final messageController = TextEditingController();
  final scrollController = ScrollController();
  var messages = <ChatMessage>[].obs;
  var isSending = false.obs;

  @override
  void onInit() {
    super.onInit();
    messages.add(
      ChatMessage(
        text:
            "Hello! I am Nibrass AI. Ask me anything about your housing, busess, or services.",
        isUser: false,
        time: DateTime.now(),
      ),
    );
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    messages.add(ChatMessage(text: text, isUser: true, time: DateTime.now()));
    messageController.clear();
    _scrollToBottom();

    try {
      isSending.value = true;

      final response = await dioClient.dio.post(
        '/chat/ask/',
        data: {"message": text},
      );

      final botReply = response.data['reply'];
      messages.add(
        ChatMessage(text: botReply, isUser: false, time: DateTime.now()),
      );
      _scrollToBottom();
    } catch (e) {
      messages.add(
        ChatMessage(
          text:
              "Sorry, I'm having trouble connecting right now. Please try again.",
          isUser: false,
          time: DateTime.now(),
        ),
      );
    } finally {
      isSending.value = false;
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
