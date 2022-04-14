import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatUserPage extends StatefulWidget {

  const ChatUserPage({Key? key}) : super(key: key);

  @override
  _ChatUserPageState createState() => _ChatUserPageState();
}

class _ChatUserPageState extends State<ChatUserPage>{

  late StreamChatClient client;
  late Channel channel;


  @override
  void initState() {
    // channel = widget.channel;
    // channel.watch();
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: ChannelHeader(),
      body: Column(
        children: [
          Expanded(
              child: MessageListView()),
          MessageInput(),
        ],
      ),
    );
  }
}
