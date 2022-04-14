import 'package:flutter/cupertino.dart';
import 'package:mobile_nutrimiski/model/entitie/parent.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../model/entitie/user_session.dart';
import '../util/util.dart';

class ChatPresenter extends ChangeNotifier{


  Future<void> initChannels(String? nutritionistId, List<Parent> parents, StreamChatClient client) async{
    if(isParent()){
      final channel = client.channel(
          'messaging',
          id: "d${nutritionistId.toString()}p${UserSession().getDni()}",
          extraData: {
            'name' : 'Nutricionista',
            'members' : [UserSession().getDni()],
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
              'members' : [UserSession().getDni()],
            });
        await channel.create();
      }
    }
  }

}