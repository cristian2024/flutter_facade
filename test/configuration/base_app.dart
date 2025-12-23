import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facade/application/injection.dart';

class BaseApp extends StatelessWidget {
  const BaseApp({
    super.key,
    required this.child,
    this.shouldInject = true,
    this.providers = const [],
  });

  final Widget child;
  final List<BlocProvider> providers;

  final bool shouldInject;

  @override
  Widget build(BuildContext context) {
    if (shouldInject) inject();
    final widgetChild = MaterialApp(home: child);
    if (providers.isNotEmpty) {
      return MultiBlocProvider(
        providers: providers,
        child: widgetChild,
      );
    }
    return widgetChild;
  }
}
