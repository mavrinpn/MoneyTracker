import 'package:diploma/theme/color_theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SlidableListTile extends StatelessWidget {
  const SlidableListTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.onDelete,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Function()? onTap;
  final Function()? onDelete;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<ColorThemeExtension>()!;
    final borderRadius = BorderRadius.circular(10);

    return InkWell(
      borderRadius: borderRadius,
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: colorTheme.tileBackgroundColor,
          borderRadius: borderRadius,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              offset: Offset(0, 4),
              blurRadius: 13,
            )
          ],
        ),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
          ),
          child: Slidable(
            key: const ValueKey(0),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    if (onDelete != null) {
                      onDelete!();
                    }
                  },
                  backgroundColor: colorTheme.dangerButtonColor,
                  foregroundColor: colorTheme.buttonLabelColor,
                  label: AppLocalizations.of(context)!.delete,
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 25, right: 15),
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius,
              ),
              title: Text(title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  )),
              subtitle: Text(subtitle,
                  style: TextStyle(
                    color: colorTheme.subtitleTextColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  )),
              trailing: trailing,
            ),
          ),
        ),
      ),
    );
  }
}
