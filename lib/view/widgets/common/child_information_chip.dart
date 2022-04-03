import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../util/colors.dart';

class ChildInformationChip extends StatelessWidget {
  final String text;
  final IconData icon;
  const ChildInformationChip({required this.text, required this.icon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(icon, size: 15.0, color: alternativeTextColor),
        const SizedBox(width: 10.0),
        Text(text, style: const TextStyle(color: alternativeTextColor, fontSize: 13.0))
      ],
    );
  }
}
