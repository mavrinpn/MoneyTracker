import 'package:flutter/material.dart';

class ActiveAppBarTitle extends StatelessWidget {
  final Function onTap;
  final String titleText;
  const ActiveAppBarTitle({
    required this.titleText,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 6, bottom: 6),
        child: Text(titleText),
      ),
    );
  }
}
