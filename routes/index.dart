
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_course/models/user.dart';

// Route @GET "/"
Future<Response> onRequest(RequestContext context) async {
  final users = context.read<List<User>>();

  return Response.json(body: users);
}
