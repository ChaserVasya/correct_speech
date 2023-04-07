import 'dart:async';

Stream<T> periodicStream<T>(
  FutureOr<T> Function() code, [
  Duration duration = const Duration(seconds: 1),
]) {
  final controller = StreamController<T>();
  final timer = Timer.periodic(duration, (_) async {
    controller.add(await code());
  });
  controller.onCancel = () {
    timer.cancel();
    controller.close();
  };
  return controller.stream;
}
