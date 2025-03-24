import 'package:dio/dio.dart';

import 'anilist_request.dart';
import 'models/models.dart';

class AnilistStaffRequest extends AnilistStaffSelect with AnilistRequest {
  // ignore: constant_identifier_names
  static const String URL = 'https://graphql.anilist.co';

  BaseOptions get options => BaseOptions(baseUrl: URL);

  AnilistStaffRequest({Dio? client}) {
    this.client = client ?? Dio(options);
    arguments['id'] = null;
  }

  AnilistStaffRequest.fromArguments(Map<String, dynamic> withArguments) {
    client = Dio(options);
    super.arguments = withArguments;
  }

  AnilistStaffRequest copy() {
    var newArgs = Map<String, dynamic>.from(arguments);
    return AnilistStaffRequest.fromArguments(newArgs);
  }

  Future<AnilistStaff> byId(int id) async {
    var response = await client.post(URL, data: {
      "query": query,
      "variables": {'id': id}
    });
    var char = response.data['data'][name];
    return AnilistStaff.fromJson(char);
  }

  Future<AnilistQueryResult<AnilistStaff>> list(int perPage, int page) async {
    return listRequest<AnilistStaff>(perPage, page);
  }
}
