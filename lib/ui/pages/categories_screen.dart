import 'package:diploma/blocs/categories/categories_bloc.dart';
import 'package:diploma/core/validators.dart';
import 'package:diploma/ui/widgets/category/category_item.dart';
import 'package:diploma/ui/widgets/category/month_calendar_gridview.dart';
import 'package:diploma/ui/widgets/category/active_appbar_title.dart';
import 'package:diploma/ui/widgets/dialog/bottom_actions.dart';
import 'package:diploma/ui/widgets/spending/donut_chart.dart';
import 'package:diploma/theme/color_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:module_business/module_business.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var selectedPeriod = Period.current();

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<ColorThemeExtension>()!;
    context
        .read<CategoriesBloc>()
        .add(LoadCategoriesEvent(period: selectedPeriod));

    return Scaffold(
      appBar: AppBar(
        title: ActiveAppBarTitle(
          titleText:
              '${AppLocalizations.of(context)!.long_month('month_${selectedPeriod.month}')} ${selectedPeriod.year}',
          onTap: () {
            selectPariodDialog(
              context: context,
              period: selectedPeriod,
              onSetPeriod: (newPeriod) {
                setState(() {
                  selectedPeriod = newPeriod;
                });
              },
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () => addCategoryDialog(context),
            tooltip: AppLocalizations.of(context)!.add_category,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (contex, state) {
        return Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: colorTheme.subviewBackgroundColor,
                child: Builder(builder: (context) {
                  if (state is CategoriesLoaded) {
                    final categories = state.categories;

                    if (state.noSpendings) {
                      return Center(
                        child: Text(AppLocalizations.of(context)!
                            .no_spending_for(AppLocalizations.of(context)!
                                .long_month('month_${selectedPeriod.month}'))),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(14),
                        child: DonutChart(
                          categories: categories,
                        ),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
              ),
            ),
            Expanded(
              flex: 3,
              child: Builder(
                builder: (context) {
                  if (state is CategoriesLoaded) {
                    final categories = state.categories;

                    return ListView.separated(
                      padding: const EdgeInsets.all(25.0),
                      itemCount: categories.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 20);
                      },
                      itemBuilder: (context, index) {
                        final category = categories[index];

                        return CategoryItem(
                          category: category,
                          selectedPeriod: selectedPeriod,
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

extension _CategoriesScreenDialogs on _CategoriesScreenState {
  void addCategoryDialog(BuildContext context) {
    final categoryFormKey = GlobalKey<FormState>();
    final nameTextController = TextEditingController();
    final colorTextController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.only(left: 30, right: 30),
        title: Text(
          AppLocalizations.of(context)!.add_category,
          textAlign: TextAlign.center,
        ),
        content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SizedBox(
            width: double.maxFinite,
            child: Form(
              key: categoryFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameTextController,
                    validator: (value) => nameValidator(value, context),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      errorText: null,
                      labelText: AppLocalizations.of(context)!.name,
                    ),
                  ),
                  TextFormField(
                    controller: colorTextController,
                    validator: (value) => colorValidator(value, context),
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      errorText: null,
                      labelText: AppLocalizations.of(context)!.color,
                      hintText: 'hex',
                      counterText: '${colorTextController.text.length}/6',
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[0-9a-fA-F]")),
                    ],
                    maxLength: 6,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                  BottomActions(
                    title: AppLocalizations.of(context)!.add,
                    onTap: () {
                      final formValidator =
                          categoryFormKey.currentState!.validate();
                      if (formValidator) {
                        final category = CategoryEntity(
                          name: nameTextController.text,
                          color: colorTextController.text,
                          id: '',
                          owner: '',
                          spendings: const [],
                        );
                        context
                            .read<CategoriesBloc>()
                            .add(AddCategoryEvent(category: category));
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void selectPariodDialog({
    required BuildContext context,
    required Period period,
    required Function onSetPeriod,
  }) {
    final colorTheme = Theme.of(context).extension<ColorThemeExtension>()!;
    var selectedPeriod = period;

    showDialog(
      context: context,
      builder: (BuildContext context) =>
          StatefulBuilder(builder: (context, StateSetter setState) {
        return AlertDialog(
          clipBehavior: Clip.antiAlias,
          titlePadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.only(top: 20, left: 24, right: 24),
          title: Container(
            color: colorTheme.accentColor,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 30, left: 24, right: 10, bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!
                        .long_month('month_${selectedPeriod.month}'),
                    style: TextStyle(
                      color: colorTheme.buttonLabelColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${selectedPeriod.year}',
                        style: TextStyle(color: colorTheme.buttonLabelColor),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                selectedPeriod.year++;
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_up_rounded,
                              color: colorTheme.buttonLabelColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                selectedPeriod.year--;
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: colorTheme.buttonLabelColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MonthCalendarGridView(
                    period: selectedPeriod,
                    onPeriodChanged: (newPeriod) {
                      setState(() {
                        selectedPeriod = newPeriod;
                      });
                    }),
                BottomActions(
                  title: AppLocalizations.of(context)!.confirm,
                  onTap: () {
                    onSetPeriod(selectedPeriod);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
