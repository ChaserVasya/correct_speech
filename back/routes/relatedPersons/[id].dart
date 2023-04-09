import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context, String personId) {
  return Response(body: 'id $personId');
}
