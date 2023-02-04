import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:not_zero/i18n/translations.g.dart';
import 'package:not_zero/themes/charts_colors.dart';

class WeeklyStatsChart extends StatelessWidget {
  const WeeklyStatsChart(
    this.weeklyStats, {
    super.key,
    required this.rendererKey,
  });

  final Key rendererKey;
  final List<int> weeklyStats;

  @override
  Widget build(BuildContext context) {
    final chartsColors = Theme.of(context).chartsColorScheme;

    final maxHeight = weeklyStats.fold<int>(
          0,
          (element, previousValue) {
            if (element > previousValue) {
              return element;
            }
            return previousValue;
          },
        ) +
        8.0;

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: maxHeight,
        lineBarsData: [
          LineChartBarData(
            spots: _getChartSpots(),
            isCurved: false,
            // curveSmoothness: 2,
            barWidth: 5,
            isStrokeCapRound: true,
            color: chartsColors.weeklyStatsLine,
            belowBarData: BarAreaData(
              show: true,
              gradient: chartsColors.weeklyStatsBelowGradient,
            ),
          ),
        ],
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: _getBottomTitleWidget,
            ),
          ),
        ),
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: chartsColors.tooltipBackgroundColor,
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          drawHorizontalLine: false,
          verticalInterval: 1,
          getDrawingVerticalLine: (_) {
            return FlLine(
              color: chartsColors.gridColor,
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.fromBorderSide(
            BorderSide(color: chartsColors.borderColor),
          ),
        ),
      ),
      chartRendererKey: rendererKey,
    );
  }

  List<FlSpot> _getChartSpots() {
    return List.generate(
      weeklyStats.length,
      (index) {
        return FlSpot(
          index.toDouble(),
          weeklyStats[index].toDouble(),
        );
      },
    );
  }

  // It is normal to return widgets since it is builder function for chart.
  // ignore: avoid-returning-widgets
  static Widget _getBottomTitleWidget(double value, TitleMeta _) {
    final weekDay = DateTime.now()
        .subtract(
          Duration(days: 6 - value.round()),
        )
        .weekday;
    final title = _getShortNameOfWeekDay(weekDay);
    return Text(title);
  }

  static String _getShortNameOfWeekDay(int weekDay) {
    switch (weekDay) {
      case 1:
        return t.common.weekDays.short.monday;
      case 2:
        return t.common.weekDays.short.tuesday;
      case 3:
        return t.common.weekDays.short.wednesday;
      case 4:
        return t.common.weekDays.short.thursday;
      case 5:
        return t.common.weekDays.short.friday;
      case 6:
        return t.common.weekDays.short.saturday;
      case 7:
        return t.common.weekDays.short.sunday;
      default:
        return '';
    }
  }
}
