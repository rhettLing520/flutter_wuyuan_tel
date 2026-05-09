import 'dart:ui';

class FontWeightS {
  /// Creates a [FontWeight] object, which can be added to a [TextStyle] to
  /// select the thickness of a font's glyphs.
  const FontWeightS(this.value)
    : assert(value >= 1, 'Font weight must be between 1 and 1000'),
      assert(value <= 1000, 'Font weight must be between 1 and 1000');

  /// The encoded integer value of this font weight.
  @Deprecated('Use value, which is more precise.')
  int get index => (value ~/ 100 - 1).clamp(0, 8);

  /// The thickness value of this font weight.
  final int value;

  /// Thin, the least thick.
  static const FontWeight normal = FontWeight(400);

  static const FontWeight medium = FontWeight(500);

  static const FontWeight bold = FontWeight(700);
}
