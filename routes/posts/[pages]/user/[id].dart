import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context, String pages, String id) {
  return Response(body: 'Pages : $pages id : $id');
}
