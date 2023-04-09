import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context, String personId) async {
  return Response(body: 'id $personId');
}
