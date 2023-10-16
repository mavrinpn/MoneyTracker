import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomActions extends StatelessWidget {
  final String title;
  final Function onTap;
  const BottomActions({
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        FilledButton(
          onPressed: () => onTap(),
          child: Text(title),
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
    );
  }
}
