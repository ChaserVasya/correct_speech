import 'package:correct_speech/features/core/person/domain/model/sex.dart';
import 'package:correct_speech/infrastructure/extensions.dart';

class SexMapper {
  final _toSex = {
    0: Sex.male,
    1: Sex.female,
  };

  late final _toCode = _toSex.invert();

  int toCode(Sex sex) => _toCode[sex]!;
  Sex toSex(int code) => _toSex[code]!;
}
