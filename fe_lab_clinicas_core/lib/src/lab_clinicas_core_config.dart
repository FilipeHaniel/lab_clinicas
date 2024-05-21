import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:fe_lab_clinicas_core/src/loader/lab_clinicas_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class LabClinicasCoreConfig extends StatelessWidget {
  final ApplicationBindings? binding;
  final List<FlutterGetItPageRouter>? pages;
  final List<FlutterGetItPageBuilder>? pagesBuilders;
  final List<FlutterGetItModule>? modules;
  final String title;

  const LabClinicasCoreConfig({
    super.key,
    this.binding,
    this.pages,
    this.pagesBuilders,
    this.modules,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterGetIt(
      debugMode: kDebugMode,
      bindings: binding,
      bindingsBuilder: () => [
        Bind.lazySingleton((i) => 'Filipe'),
      ],
      pages: [
        ...pages ?? [],
        ...pagesBuilders ?? [],
      ],
      modules: modules,
      builder: (context, routes, flutterGetItNavObserver) {
        return AsyncStateBuilder(
          loader: LabClinicasLoader(),
          builder: (navigatorObserver) {
            return MaterialApp(
              navigatorObservers: [
                navigatorObserver,
                flutterGetItNavObserver,
              ],
              routes: routes,
              title: title,
            );
          },
        );
      },
    );
  }
}
