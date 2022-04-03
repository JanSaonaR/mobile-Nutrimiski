
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mobile_nutrimiski/util/connection_tags.dart';

import '../../model/entitie/child.dart';
import '../../model/entitie/user_session.dart';
import 'multipart_register_service.dart';


class ParentService{

  ParentService();

  Future<bool> registerParent(Map<String, dynamic> parent, File file) async {

    String dataEncoded = json.encode(parent);

    MultipartField mf = MultipartField(dataEncoded, headers: {
      Headers.contentTypeHeader : "application/json"
    });

    var uri = Uri.parse(baseUrl + userEndpoint + parentRegister);
        var req = MultipartRequestEx('POST', uri)
      ..fields["request"] = mf
      ..files.add(await http.MultipartFile.fromPath('profilePic', file.path, contentType: MediaType('application', 'x-tar')));

    var response = await req.send();

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> registerChild(Map<String, dynamic> child) async {
    final dio = Dio();

    // FormData formData = FormData.fromMap(child);
    //
    // String fileName = file.path.split('/').last;
    //
    // formData.files.add(MapEntry('profilePic', await MultipartFile.fromFile(file.path, filename:fileName)));
    //
    dio.options.headers["authorization"] = "Bearer ${UserSession().getToken()}";

    var uri = baseUrl + parentEndpoint + childRegister;

    var response = await dio.post(uri, data: child, queryParameters: {'parentId' : UserSession().getId()});

    if(response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<List<Child>> getChildrenFromParent() async {
    final dio = Dio();
    dio.options.headers["authorization"] = "Bearer ${UserSession().getToken()}";

    var uri = baseUrl + parentEndpoint + getChildren;

    var response = await dio.get(uri, queryParameters: {'parentId' : UserSession().getId()});

    if(response.statusCode == 200) {
      List aux = response.data.map((e) => Child.fromJson(e)).toList();
      return aux.cast<Child>();
    }
    return [];
  }

}