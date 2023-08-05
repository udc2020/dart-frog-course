import 'package:dart_frog/dart_frog.dart';

Response onRequest(
  RequestContext context,
  String pages,
) {
  return Response(body: 'This is a new route!');
}
