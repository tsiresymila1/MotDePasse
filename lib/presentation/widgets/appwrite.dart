import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';



base class AppWriteContext extends InheritedWidget {
  final Client client;
  const AppWriteContext({super.key, required super.child, required this.client});

  @override
  bool updateShouldNotify(covariant AppWriteContext oldWidget) {
    return oldWidget.client != client;
  }

  static AppWriteContext? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppWriteContext>();
  }

  static AppWriteContext of(BuildContext context) {
    final AppWriteContext? result = maybeOf(context);
    assert(result != null, 'No AppWriteProvider found in context');
    return result!;
  }
}

class AppWriteProvider extends StatelessWidget {
  final Widget child;
  final Client client;

  const AppWriteProvider(
      {super.key, required this.child, required this.client});

  @override
  Widget build(BuildContext context) {
    return AppWriteContext(
      client: client,
      child: Builder(builder: (context) => child),
    );
  }
}

extension AppWrite on BuildContext {
  Client get appWrite => AppWriteContext.of(this).client;
}
