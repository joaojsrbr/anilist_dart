// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';

import 'anilist_request.dart';
import 'models/models.dart';

class AnilistMediaRequest extends AnilistMediaSelect with AnilistRequest {
  static const String URL = 'https://graphql.anilist.co';

  BaseOptions get options => BaseOptions(baseUrl: URL);

  AnilistMediaRequest({Dio? client}) {
    this.client = client?.clone(options: options) ?? Dio(options);
    arguments['id'] = null;
  }

  AnilistMediaRequest.fromArguments(Map<String, dynamic> withArguments) {
    client = Dio(options);
    super.arguments = withArguments;
  }

  AnilistMediaRequest copy() {
    var newArgs = Map<String, dynamic>.from(arguments);
    return AnilistMediaRequest.fromArguments(newArgs);
  }

  Future<AnilistMedia> byId(int id) async {
    var response = await client.post('', data: {
      "query": query,
      "variables": {'id': id}
    });
    var media = response.data['data']['Media'];
    return AnilistMedia.fromJson(media);
  }

  Future<AnilistQueryResult<AnilistMedia>> list(int perPage, int page) async {
    return listRequest<AnilistMedia>(perPage, page);
  }
}
