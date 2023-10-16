import 'package:diploma/core/extensions/string_extension.dart';
import 'package:diploma/theme/color_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:module_business/module_business.dart';

class MonthCalendarGridView extends StatelessWidget {
  final Function onPeriodChanged;
  final Period period;

  const MonthCalendarGridView({
    required this.period,
    required this.onPeriodChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      children: monthsTable(context),
    );
  }

  List<Widget> monthsTable(BuildContext context) {
    final colorTheme = Theme.of(context).extension<ColorThemeExtension>()!;

    List<Widget> result = [];
    for (var m = 1; m <= 12; m++) {
      var backgroundColor = Colors.transparent;
      var foregroundColor = colorTheme.titleTextColor;

      if (period.month == m) {
        backgroundColor = colorTheme.accentColor;
        foregroundColor = colorTheme.buttonLabelColor;
      } else if (period.year == DateTime.now().year &&
          m == DateTime.now().month) {
        backgroundColor = Colors.transparent;
        foregroundColor = colorTheme.accentColor;
      }

      final monthWidget = TextButton(
        onPressed: () {
          final newPeriod = Period(year: period.year, month: m);
          onPeriodChanged(newPeriod);
        },
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          textStyle: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
        child: Text(
            AppLocalizations.of(context)!.short_month('month_$m').capitalize()),
      );
      result.add(monthWidget);
    }
    return result;
  }
}
