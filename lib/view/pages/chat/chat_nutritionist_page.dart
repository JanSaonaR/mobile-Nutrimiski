import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatNutritionistPage extends StatefulWidget {

  final Channel? channel;

  const ChatNutritionistPage({Key? key, required this.channel}) : super(key: key);

  @override
  _ChatNutritionistPageState createState() => _ChatNutritionistPageState();
}

class _ChatNutritionistPageState extends State<ChatNutritionistPage>{

  late StreamChatClient client;
  late Channel channel;


  @override
  void initState() {
    if(widget.channel != null){
      channel = widget.channel!;
      channel.watch();
    }
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return StreamChannel(
      channel: channel,
      child: Scaffold(
        appBar: ChannelHeader(),
        body: Column(
          children: [
            Expanded(
                child: MessageListView()),
            MessageInput(),
          ],
        ),
      ),
    );
  }
}
