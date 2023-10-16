import 'package:diploma/core/extensions/string_extension.dart';
import 'package:module_business/module_business.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DonutChart extends StatefulWidget {
  final List<CategoryEntity> categories;
  const DonutChart({required this.categories, super.key});

  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double height = constraints.maxHeight;
      List<PieChartSectionData> pieChartSections = [];
      for (var category in widget.categories) {
        final pieChartSection = PieChartSectionData(
          value: category.getTotalSpending(),
          title: category.name.trimLengthWithEllipsis(10),
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          color: category.getColor(),
          radius: height / 3,
        );
        pieChartSections.add(pieChartSection);
      }
      return PieChart(
        PieChartData(
          startDegreeOffset: 90,
          sectionsSpace: 0,
          sections: pieChartSections,
        ),
      );
    });
  }
}
