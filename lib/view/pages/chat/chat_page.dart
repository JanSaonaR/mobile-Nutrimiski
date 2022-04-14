import 'package:flutter/cupertino.dart';
import 'package:mobile_nutrimiski/view/pages/chat/chat_user_page.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../../util/util.dart';

class ChatPage extends StatefulWidget {

  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>{

  final _keyChannels = GlobalKey<ChannelsBlocState>();

  @override
  void initState() {
    //_keyChannels.currentState!.queryChannels();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return SizedBox(
        height: size.height,
        child: ChannelsBloc(
          //key: _keyChannels,
          child: ChannelListView(
            filter: Filter.in_('members', [StreamChat.of(context).currentUser!.id]),
            channelWidget: ChatUserPage(),
          ),
        )
    );
  }
}