import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context)async {
  
  // Request
  final request = context.request;

  final params = request.uri.queryParameters;
  final body = await request.body();

  return Response(
    body: 'hi there ${params["test"]} $body',
  );
}
