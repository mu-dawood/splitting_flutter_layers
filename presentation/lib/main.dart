import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'image_picker_screen.dart';

GetIt injector = GetIt.I;
void main() {
  DomainDependencies.registerRepositories(getInstance: injector, registerSingleton: injector.registerFactory);
  DataDependencies.registerRepositories(registerSingleton: injector.registerLazySingleton);
  injector.registerLazySingleton<IMessenger>(() => MessengerImpl());
  injector.registerLazySingleton<INavigator>(() => NavigatorImpl());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ImagePickerBloc(injector),
      child: MaterialApp(
        title: 'Flutter Demo',
        scaffoldMessengerKey: MessengerImpl.key,
        navigatorKey: NavigatorImpl.key,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ImagePickerScreen(),
      ),
    );
  }
}

class MessengerImpl implements IMessenger {
  static final GlobalKey<ScaffoldMessengerState> key = GlobalKey<ScaffoldMessengerState>();
  @override
  void exception(exception) {
    if (exception is! Failure) {
      key.currentState?.showSnackBar(SnackBar(content: Text(exception.toString())));
    } else {
      key.currentState?.showSnackBar(
        const SnackBar(content: Text('Sorry you dont give us permission to do this action')),
      );
    }
  }
}

class NavigatorImpl implements INavigator {
  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  @override
  Future<bool> openPermissionDialog(PermissionType type) async {
    var result = await showModalBottomSheet(
        context: key.currentContext!,
        isScrollControlled: true,
        builder: (ctx) {
          return PermissionDialog(type: type);
        });
    return result == true;
  }
}
