import 'package:diploma/blocs/categories/categories_bloc.dart';
import 'package:diploma/ui/widgets/spending/slidable_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:module_business/module_business.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({
    required this.category,
    Key? key,
  }) : super(key: key);

  final CategoryEntity category;

  @override
  State<StatefulWidget> createState() => CategoryDetailScreenState();
}

class CategoryDetailScreenState extends State<CategoryDetailScreen> {
  late Color appBarColor;
  late List<SpendingEntity> spendings;

  @override
  void initState() {
    appBarColor = widget.category.getColor();
    spendings = widget.category.spendings;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        backgroundColor: appBarColor,
      ),
      body: BlocListener<CategoriesBloc, CategoriesState>(
        listener: (context, state) {
          if (state is CategoriesLoaded) {
            spendings = state.categories
                .where((element) => element.id == widget.category.id)
                .toList()
                .first
                .spendings;

            setState(() {});
          }
        },
        child: ListView.separated(
          padding: const EdgeInsets.all(25.0),
          itemCount: spendings.length,
          separatorBuilder: (context, index) {
            return const SizedBox(height: 20);
          },
          itemBuilder: (context, index) {
            final spending = spendings[index];
            final formattedDate =
                DateFormat('dd MMMM yy / kk:mm').format(spending.date);

            return SlidableListTile(
              title: '${spending.amount}',
              subtitle: formattedDate,
              onDelete: () {
                deleteSpendingDialog(context, spending);
              },
            );
          },
        ),
      ),
    );
  }

  void deleteSpendingDialog(BuildContext context, SpendingEntity spending) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.only(left: 30, right: 30),
        title: Text(
          AppLocalizations.of(context)!.delete_spending,
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  deleteSpendingAction(context, spending);
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

  void deleteSpendingAction(BuildContext context, SpendingEntity spending) {
    context.read<CategoriesBloc>().add(RemoveSpendingEvent(spending: spending));
    Navigator.pop(context);
  }
}
