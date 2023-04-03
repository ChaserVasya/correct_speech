import 'package:correct_speech/features/core/person/domain/model/sex.dart';
import 'package:correct_speech/infrastructure/extensions.dart';

abstract class SexUIMapper {
  static final _toText = Map.fromEntries(Sex.values.map((sex) {
    switch (sex) {
      case Sex.male:
        return MapEntry(sex, 'М');
      case Sex.female:
        return MapEntry(sex, 'Ж');
    }
  }));

  static final _toDomain = _toText.invert();

  String toText(Sex sex) => SexUIMapper._toText[sex]!;
  Sex toDomain(String text) => SexUIMapper._toDomain[text]!;
}
