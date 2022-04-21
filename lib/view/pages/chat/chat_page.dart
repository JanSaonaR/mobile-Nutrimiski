import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_nutrimiski/presenter/child_presenter.dart';
import 'package:mobile_nutrimiski/presenter/parent_presenter.dart';
import 'package:mobile_nutrimiski/presenter/user_presenter.dart';
import 'package:mobile_nutrimiski/view/pages/chat/chat_user_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../../util/util.dart';
import 'chat_nutritionist_page.dart';

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
        height: size.height * 0.35,
        child: isParent() ?
        Container(
          width: size.width,
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(0, 20)
              )
            ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: size.height * 0.04,
                    backgroundColor: Colors.black,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Doctor', style: TextStyle(fontSize: 12),),
                      Text(Provider.of<ChildPresenter>(context, listen: false).getParentNutritionist().firstName!, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                      Text(Provider.of<ChildPresenter>(context, listen: false).getParentNutritionist().lastName!, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.phone, size: 15),
                  Text(Provider.of<ChildPresenter>(context, listen: false).getParentNutritionist().phone!, style: TextStyle(fontSize: 13,),),
                  Icon(Icons.email, size: 15,),
                  Text(Provider.of<ChildPresenter>(context, listen: false).getParentNutritionist().email!, style: TextStyle(fontSize: 13,),),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.profile_circled, size: 15),
                  SizedBox(
                    width: 10,
                  ),
                  Text(Provider.of<ChildPresenter>(context, listen: false).getParentNutritionist().dni!, style: TextStyle(fontSize: 13,),),
                ],
              ),
              SizedBox(
                height: size.height * 0.1,
                child: ChannelsBloc(
                  lockChannelsOrder: true,
                  //key: _keyChannels,
                  child: ChannelListView(
                    listBuilder: (context, channels){
                      return ListTile(
                        tileColor: Colors.transparent,
                        title: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text('Ir al Chat'),
                              IconButton(onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        duration: const Duration(milliseconds: 200),
                                        reverseDuration: const Duration(milliseconds: 200),
                                        type: PageTransitionType.rightToLeft,
                                        child: ChatNutritionistPage(channel: channels[0],)
                                    )
                                );
                              }, icon: Icon(Icons.arrow_forward_ios))
                            ],
                          ),
                        ),
                      );
                    },
                    pullToRefresh: false,
                    limit: 1,
                    filter: Filter.in_('members', [StreamChat.of(context).currentUser!.id]),
                    //channelWidget: ChatUserPage(),
                    separatorBuilder: (context, value){
                      return const SizedBox();
                    },
                  ),
                ),
              )
            ],
          )
        )
        : ChannelsBloc(
          //key: _keyChannels,
          child: ChannelListView(
            filter: Filter.in_('members', [StreamChat.of(context).currentUser!.id]),
            channelWidget: ChatUserPage(),
          ),
        )
    );
  }
}