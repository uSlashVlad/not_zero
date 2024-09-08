import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nz_common/nz_common.dart';
import 'package:nz_flutter_core/nz_flutter_core.dart';

enum DateRangeType {
  day,
  week,
}

class DateRangeSwitch extends StatefulWidget {
  const DateRangeSwitch({
    required this.rangeType,
    this.initialDate,
    this.onChanged,
    super.key,
  });

  final DateRangeType rangeType;
  final DateTime? initialDate;
  final void Function(DateTime rangeStart, DateTime rangeEInd)? onChanged;

  @override
  State<DateRangeSwitch> createState() => _DateRangeSwitchState();
}

class _DateRangeSwitchState extends State<DateRangeSwitch> {
  late DateTime _currentDate;

  DateTime get _rangeStart => switch (widget.rangeType) {
        DateRangeType.day => _currentDate.startOfDay,
        DateRangeType.week => _currentDate.startOfWeek,
      };

  DateTime get _rangeEnd => switch (widget.rangeType) {
        DateRangeType.day => _currentDate.endOfDay,
        DateRangeType.week => _currentDate.endOfWeek,
      };

  @override
  void initState() {
    _currentDate = widget.initialDate ?? DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: _previousRange,
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        const SizedBox(width: 4),
        _MiddleButton(
          onTap: _todayRange,
          rangeStart: _rangeStart,
          rangeEnd: _rangeEnd,
        ),
        const SizedBox(width: 4),
        IconButton(
          onPressed: _nextRange,
          icon: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ],
    );
  }

  void _todayRange() {
    setState(() {
      _currentDate = DateTime.now();
    });
    widget.onChanged?.call(_rangeStart, _rangeEnd);
  }

  void _previousRange() {
    final newDate = switch (widget.rangeType) {
      DateRangeType.day => _currentDate.dayBefore,
      DateRangeType.week => _currentDate.weekBefore,
    };
    setState(() {
      _currentDate = newDate;
    });
    widget.onChanged?.call(_rangeStart, _rangeEnd);
  }

  void _nextRange() {
    final newDate = switch (widget.rangeType) {
      DateRangeType.day => _currentDate.dayAfter,
      DateRangeType.week => _currentDate.weekAfter,
    };
    setState(() {
      _currentDate = newDate;
    });
    widget.onChanged?.call(_rangeStart, _rangeEnd);
  }
}

class _MiddleButton extends StatelessWidget {
  const _MiddleButton({
    required this.onTap,
    required this.rangeStart,
    required this.rangeEnd,
  });

  final void Function() onTap;

  final DateTime rangeStart;
  final DateTime rangeEnd;

  bool get _isTodayInRange {
    final today = DateTime.now();
    return today.isAfter(rangeStart) && today.isBefore(rangeEnd);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        minimumSize: const Size(230, 45),
        foregroundColor: _isTodayInRange
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _DateRangeText(
          rangeStart,
          rangeEnd,
          key: ValueKey('$rangeStart $rangeEnd'),
        ),
      ),
    );
  }
}

class _DateRangeText extends StatelessWidget {
  const _DateRangeText(
    this.rangeStart,
    this.rangeEnd, {
    super.key,
  });

  final DateTime rangeStart;
  final DateTime rangeEnd;

  @override
  Widget build(BuildContext context) {
    final String text;

    if (rangeStart.isAtSameDay(rangeEnd)) {
      text = _formatSameDay();
    } else if (rangeStart.isAtSameMonth(rangeEnd)) {
      text = _formatSameMonth();
    } else if (rangeStart.isAtSameYear(rangeEnd)) {
      text = _formatSameYear();
    } else {
      text = _formatFull();
    }

    return Text(text, style: const TextStyle(fontSize: 17));
  }

  String _formatSameDay() {
    final dateToCompare = rangeStart;
    final today = DateTime.now();

    if (dateToCompare.isAtSameDay(today)) {
      return t.common.timeOptions.today;
    } else if (dateToCompare.isAtSameDay(today.dayBefore)) {
      return t.common.timeOptions.yesterday;
    } else if (dateToCompare.isAtSameDay(today.dayAfter)) {
      return t.common.timeOptions.tomorrow;
    }

    if (rangeStart.isAtSameYear(rangeEnd)) {
      return DateFormat.MMMd().format(rangeStart);
    } else {
      return DateFormat.yMMMd().format(rangeStart);
    }
  }

  String _formatSameMonth() {
    final start = DateFormat.d().format(rangeStart);
    final end = DateFormat.MMMd().format(rangeEnd);
    return '$start - $end';
  }

  String _formatSameYear() {
    final start = DateFormat.MMMd().format(rangeStart);
    final end = DateFormat.MMMd().format(rangeEnd);
    return '$start - $end';
  }

  String _formatFull() {
    final start = DateFormat.yMMMd().format(rangeStart);
    final end = DateFormat.yMMMd().format(rangeEnd);
    return '$start - $end';
  }
}
