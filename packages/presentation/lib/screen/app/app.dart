import 'package:flutter/material.dart';
import 'package:presentation/screen/app/bloc/app_bloc.dart';
import 'package:presentation/base/bloc_data.dart';
import 'package:presentation/base/bloc_state.dart';
import 'package:flutter/services.dart';
import 'package:presentation/screen/app/bloc/app_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends BlocState<App, AppBloc> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  final globalRootNavKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    bloc.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color(0xFF87C009),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0.0,
        ),
        primarySwatch: Colors.blue,
      ),
      navigatorKey: globalRootNavKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: _home(),
    );
  }

  StreamBuilder _home() {
    return StreamBuilder<BlocData>(
      stream: bloc.dataStream,
      builder: (context, snapshot) {
        final blocData = snapshot.data;
        final appData = blocData?.data;
        if (appData is AppData) {
          return _content(context, blocData, appData);
        } else {
          return Container();
        }
      },
    );
  }

  Navigator _content(
    BuildContext context,
    BlocData? blocData,
    AppData appData,
  ) {
    return Navigator(
      key: _navigatorKey,
      pages: appData.pages.toList(),
      onPopPage: (route, result) {
        bloc.handleRemoveRouteSettings(route.settings);
        return route.didPop(result);
      },
    );
  }
}
