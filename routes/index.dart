import 'package:dart_frog/dart_frog.dart';

// Route @GET "/"
Future<Response> onRequest(RequestContext context)async {
  final request = context.request;

  //returning all data from body
  final body = await request.json();


  return Response.json(body: body);
}
