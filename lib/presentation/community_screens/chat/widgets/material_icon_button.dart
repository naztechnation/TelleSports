import 'package:flutter/material.dart';

Widget buildMaterialIconButton({
  required IconData icon,
  required VoidCallback onTap,
}) {
  return Material(
    clipBehavior: Clip.antiAlias,
    color: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100.0),
    ),
    child: IconButton(
      onPressed: onTap,
      splashColor: Colors.grey,
      icon: Icon(
        icon,
        color: Colors.grey,
      ),
    ),
  );
}
