import 'package:dio/dio.dart';

import 'anilist_request.dart';
import 'models/models.dart';

class AnilistCharacterRequest extends AnilistCharacterSelect
    with AnilistRequest {
// ignore: constant_identifier_names
  static const String URL = 'https://graphql.anilist.co';

  BaseOptions get options => BaseOptions(baseUrl: URL);

  AnilistCharacterRequest({Dio? client}) {
    this.client = client?.clone() ?? Dio(options);
    arguments['id'] = null;
  }

  AnilistCharacterRequest.fromArguments(Map<String, dynamic> withArguments) {
    client = Dio(options);
    super.arguments = withArguments;
  }

  AnilistCharacterRequest copy() {
    var newArgs = Map<String, dynamic>.from(arguments);
    return AnilistCharacterRequest.fromArguments(newArgs);
  }

  Future<AnilistCharacter> byId(int id) async {
    var response = await client.post(URL, data: {
      "query": query,
      "variables": {'id': id}
    });
    var char = response.data['data']['Character'];
    return AnilistCharacter.fromJson(char);
  }

  Future<AnilistQueryResult<AnilistCharacter>> list(
      int perPage, int page) async {
    return listRequest<AnilistCharacter>(perPage, page);
  }
}
