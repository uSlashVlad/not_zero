import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:not_zero/themes/charts_colors.dart';
import 'package:not_zero/themes/tags_colors.dart';
import 'package:not_zero/themes/tasks_colors.dart';

final _lightThemeBase = FlexThemeData.light(
  scheme: FlexScheme.material,
  useMaterial3: true,
  extensions: const <ThemeExtension>[
    TasksColorScheme(
      notImportantColor: Color(0xFF78909C),
      normalColor: Colors.amber,
      importantColor: Colors.red,
    ),
    ChartsColorScheme(
      chartBackgroundColor: Color(0xFFF3EDFD),
      gridColor: Colors.black12,
      borderColor: Colors.black26,
      tooltipBackgroundColor: Color(0xFF1B171E),
      weeklyStatsLine: Color(0xFFBB86FC),
      weeklyStatsBelowGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0x80BB86FC),
          Color(0x60BB86FC),
        ],
      ),
    ),
    TagsColorScheme(
      gray: Color(0xFF636366),
      red: Color(0xFFFF3B30),
      orange: Color(0xFFFF9500),
      yellow: Color(0xFFFFCC00),
      green: Color(0xFF34C759),
      teal: Color(0xFF5AC8FA),
      blue: Color(0xFF007AFF),
      indigo: Color(0xFF5856D6),
      purple: Color(0xFFAF52DE),
      pink: Color(0xFFFF2D55),
    ),
  ],
);

final defaultLightTheme = _lightThemeBase.copyWith(
  textTheme: _lightThemeBase.textTheme.copyWith(
    titleSmall: TextStyle(color: Colors.grey.shade500),
  ),
  checkboxTheme: _lightThemeBase.checkboxTheme.copyWith(
    fillColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? _lightThemeBase.primaryColorLight
          : null,
    ),
  ),
  radioTheme: _lightThemeBase.radioTheme.copyWith(
    fillColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? _lightThemeBase.primaryColorLight
          : null,
    ),
  ),
  splashFactory: kIsWeb ? null : InkSparkle.splashFactory,
);

final _darkThemeBase = FlexThemeData.dark(
  scheme: FlexScheme.material,
  useMaterial3: true,
  extensions: const <ThemeExtension>[
    TasksColorScheme(
      notImportantColor: Color(0xFFD6D6D6),
      normalColor: Colors.amberAccent,
      importantColor: Colors.redAccent,
    ),
    ChartsColorScheme(
      chartBackgroundColor: Color(0xFF251E2C),
      gridColor: Colors.white10,
      borderColor: Colors.white24,
      tooltipBackgroundColor: Color(0xFF1B171E),
      weeklyStatsLine: Color(0xFF6200EE),
      weeklyStatsBelowGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0x806200EE),
          Color(0x40BB86FC),
        ],
      ),
    ),
    TagsColorScheme(
      gray: Color(0xFFAEAEB2),
      red: Color(0xFFFF453A),
      orange: Color(0xFFFF9F0A),
      yellow: Color(0xFFFFD60A),
      green: Color(0xFF32D74B),
      teal: Color(0xFF64D2FF),
      blue: Color(0xFF0A84FF),
      indigo: Color(0xFF5E5CE6),
      purple: Color(0xFFBF5AF2),
      pink: Color(0xFFFF2D55),
    ),
  ],
);

final defaultDarkTheme = _darkThemeBase.copyWith(
  textTheme: _darkThemeBase.textTheme.copyWith(
    titleSmall: TextStyle(color: Colors.grey.shade700),
  ),
  checkboxTheme: _darkThemeBase.checkboxTheme.copyWith(
    fillColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? _darkThemeBase.primaryColor
          : null,
    ),
  ),
  radioTheme: _darkThemeBase.radioTheme.copyWith(
    fillColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? _darkThemeBase.primaryColor
          : null,
    ),
  ),
  splashFactory: kIsWeb ? null : InkSparkle.splashFactory,
);
