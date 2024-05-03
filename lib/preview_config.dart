import 'package:flutter/material.dart';

import 'core/app_export.dart';

Widget buildPreview(BuildContext context, Widget child) {
  // You may need to initialize app state here

  // Wrap the MaterialApp with any widgets your app requires, such as
  // ProviderScope for Riverpod or BlocProvider for Bloc.
  return MaterialApp(
    // TODO: Import your app's theme below
      theme: theme,
    // darkTheme: getDarkTheme(),
    home: child,
  );
}