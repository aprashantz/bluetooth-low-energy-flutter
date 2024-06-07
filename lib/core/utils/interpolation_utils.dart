import 'dart:ui';
import 'package:learn_bluetooth/models/color_range_model.dart';

class InterpolationUtils {
  static Color getInterpolatedColor(
      {required ColorRangeModel colorRange, required int value}) {
    value = value.clamp(-100, 0);
    double ratio = (value + 100) / 100;
    int red = ((1 - ratio) * colorRange.firstColor.red +
            ratio * colorRange.midColor.red)
        .round();
    int green = ((1 - ratio) * colorRange.firstColor.green +
            ratio * colorRange.midColor.green)
        .round();
    int blue = ((1 - ratio) * colorRange.firstColor.blue +
            ratio * colorRange.midColor.blue)
        .round();
    int alpha = ((1 - ratio) * colorRange.firstColor.alpha +
            ratio * colorRange.midColor.alpha)
        .round();

    if (value < 0) {
      double ratio2 = 1 - ratio;
      red = ((ratio2) * red + (1 - ratio2) * colorRange.lastColor.red).round();
      green = ((ratio2) * green + (1 - ratio2) * colorRange.lastColor.green)
          .round();
      blue =
          ((ratio2) * blue + (1 - ratio2) * colorRange.lastColor.blue).round();
      alpha = ((ratio2) * alpha + (1 - ratio2) * colorRange.lastColor.alpha)
          .round();
    }

    return Color.fromARGB(alpha, red, green, blue);
  }
}
