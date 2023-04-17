import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/chat/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/chat/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/chat/widgets/shared/message_field_box.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';

class ChatScreen extends StatelessWidget {
  final imageUrl =
      'https://th.bing.com/th/id/OIP.F_aOQBs2uLhzRlV5QKQJcAHaHa?pid=ImgDet&rs=1';

  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        title: const Text('Yes No Maybe Bot'),
        centerTitle: true,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  controller: chatProvider.chatScrollController,
                  itemCount: chatProvider.messageList.length,
                  itemBuilder: (context, index) {
                    final message = chatProvider.messageList[index];

                    return (message.fromWho == FromWho.hers)
                        ? HerMessageBubble( message: message,)
                        : MyMessageBubble( message: message,);
                  }),
            ),

            //caja de texto
             MessageFieldBox(
              onValue: chatProvider.sendMessage ,
             ),
          ],
        ),
      ),
    );
  }
}
