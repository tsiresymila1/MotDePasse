import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

base class StorageContext extends InheritedWidget {
  final GetStorage storage;
  const StorageContext({super.key, required super.child, required this.storage});

  @override
  bool updateShouldNotify(covariant StorageContext oldWidget) {
    return oldWidget.storage != storage;
  }

  static StorageContext? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StorageContext>();
  }

  static StorageContext of(BuildContext context) {
    final StorageContext? result = maybeOf(context);
    assert(result != null, 'No StorageProvider found in context');
    return result!;
  }
}

class StorageProvider extends StatelessWidget {
  final Widget child;
  final GetStorage storage;

  const StorageProvider(
      {super.key, required this.child, required this.storage});

  @override
  Widget build(BuildContext context) {
    return StorageContext(
      storage: storage,
      child: Builder(builder: (context) => child),
    );
  }
}

extension Storage on BuildContext {
  GetStorage get storage => StorageContext.of(this).storage;
}
