import 'package:flutter/cupertino.dart';
import 'package:mobile_nutrimiski/model/entitie/parent.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../model/entitie/user_session.dart';
import '../util/util.dart';

class ChatPresenter extends ChangeNotifier{


  Future<void> initChannels(String? nutritionistDni, List<Parent> parents, StreamChatClient client) async{
    if(isParent()){
      final channel = client.channel(
          'messaging',
          id: "d${nutritionistDni.toString()}p${UserSession().getDni()}",
          extraData: {
            'name' : getChannelName(),
            'members' : [UserSession().getDni(), nutritionistDni],
          });
      await channel.create();
    }
    else{
      for(int i = 0; i < parents.length; i++){
        var channel = client.channel(
            'messaging',
            id: "d${UserSession().getDni()}p${parents[i].user!.dni}",
            extraData: {
              'name' : parents[i].user!.firstName,
            });
        await channel.create();
      }
    }
  }

}