import 'package:diploma/blocs/categories/categories_bloc.dart';
import 'package:diploma/core/extensions/datetime_extension.dart';
import 'package:diploma/core/extensions/string_extension.dart';
import 'package:diploma/core/validators.dart';
import 'package:diploma/theme/color_theme_extension.dart';
import 'package:diploma/ui/widgets/spending/slidable_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:module_business/module_business.dart';

class CategoryItem extends StatelessWidget {
  final spendingFormKey = GlobalKey<FormState>();
  final dateFormKey = GlobalKey<FormState>();
  final amountTextController = TextEditingController();

  final CategoryEntity category;
  final Period selectedPeriod;
  CategoryItem({
    required this.category,
    required this.selectedPeriod,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SlidableListTile(
      title: category.name,
      subtitle: category.spendings.isEmpty
          ? AppLocalizations.of(context)!.add_spending
          : '${AppLocalizations.of(context)!.total}: ${category.getTotalSpending()}',
      onTap: () {
        addSpendingDialog(context, category, selectedPeriod);
      },
      onDelete: () {
        deleteCategoryDialog(context, category);
      },
      trailing: IconButton(
        onPressed: () {
          context.go(
            '/spending/category',
            extra: category,
          );
        },
        icon: const Icon(Icons.arrow_forward_ios_rounded),
        color: category.getColor(),
      ),
    );
  }

  void deleteCategoryDialog(BuildContext context, CategoryEntity category) {
    final colorTheme = Theme.of(context).extension<ColorThemeExtension>()!;

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.only(left: 30, right: 30),
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${AppLocalizations.of(context)!.delete_category} ',
              ),
              TextSpan(
                text: '${category.name}?',
                style: TextStyle(
                  color: colorTheme.accentColor,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.delete_category_message,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  deleteCategoryAction(context, category);
                },
                child: Text(AppLocalizations.of(context)!.confirm),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteCategoryAction(BuildContext context, CategoryEntity category) {
    context.read<CategoriesBloc>().add(RemoveCategoryEvent(category: category));
    Navigator.pop(context);
  }

  void addSpendingDialog(
      BuildContext context, CategoryEntity category, Period period) {
    final colorTheme = Theme.of(context).extension<ColorThemeExtension>()!;

    late DateTime date;
    if (period.isCurrent()) {
      date = DateTime.now();
    } else {
      date = DateTimeExtension.fromPeriod(period);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        titlePadding:
            const EdgeInsets.only(top: 10, left: 24, right: 12, bottom: 12),
        contentPadding: const EdgeInsets.only(left: 24, right: 24),
        title: StatefulBuilder(builder: (context, setState) {
          String formattedDate =
              '${date.day} ${AppLocalizations.of(context)!.short_month('month_${date.month}')} ${date.year}';

          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.add_spending),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
                onPressed: () {
                  changeDateDialog(context, date, (newDate) {
                    setState(() {
                      date = newDate;
                    });
                  });
                },
                child: Text(formattedDate),
              ),
            ],
          );
        }),
        content: SizedBox(
          width: double.maxFinite,
          child: Form(
            key: spendingFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: amountTextController,
                  validator: (value) => doubleValidator(value, context),
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        left: 24, right: 24, top: 1, bottom: 1),
                    labelText: AppLocalizations.of(context)!.enter_amount,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorTheme.accentColor),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorTheme.accentColor),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colorTheme.accentColor),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                  ],
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () {
                    addSpendingAction(date, context, category);
                  },
                  child: Text(AppLocalizations.of(context)!.add),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.cancel),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addSpendingAction(
      DateTime date, BuildContext context, CategoryEntity category) {
    final formValidator = spendingFormKey.currentState!.validate();
    if (formValidator) {
      final amount = double.parse(amountTextController.text);

      final spending = SpendingEntity(
        id: '',
        date: date,
        amount: amount,
        categoryId: category.id,
      );

      context.read<CategoriesBloc>().add(AddSpendingEvent(spending: spending));
      Navigator.pop(context);
    } else {}
  }

  void changeDateDialog(BuildContext context, DateTime date, Function setNewDate) {
    final colorTheme = Theme.of(context).extension<ColorThemeExtension>()!;
    String formattedDate =
        '${date.day} ${AppLocalizations.of(context)!.short_month('month_${date.month}')} ${date.year}';
    String formattedDay = DateFormat('EE').format(date).capitalize();
    String dateTitle = '$formattedDate, $formattedDay';
    String dateInitialValue = DateFormat('dd/MM/yy').format(date);

    final dateTextController = TextEditingController(text: dateInitialValue);

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        clipBehavior: Clip.antiAlias,
        titlePadding: const EdgeInsets.all(0),
        contentPadding: const EdgeInsets.only(left: 24, right: 24),
        title: Container(
          color: colorTheme.accentColor,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 30, left: 24, right: 24, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.select_date,
                  style: TextStyle(
                    color: colorTheme.buttonLabelColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dateTitle,
                      style: TextStyle(color: colorTheme.buttonLabelColor),
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: colorTheme.buttonLabelColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Form(
            key: dateFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: dateTextController,
                  validator: (value) => dateValidator(value, context),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.date,
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp("[0-9/]")),
                  ],
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () {
                    final formValidator = dateFormKey.currentState!.validate();
                    if (formValidator) {
                      final dateArray = dateTextController.text.split('/');
                      DateTime newDate = DateTime.now();
                      if (dateArray.length == 3) {
                        final dateString =
                            '20${dateArray[2]}-${dateArray[1]}-${dateArray[0]}';
                        newDate = DateTime.parse(dateString);
                      }

                      setNewDate(newDate);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.confirm),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.cancel),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
