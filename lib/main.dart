import 'package:flutter/material.dart';
import 'package:flutter_appcenter_bundle/flutter_appcenter_bundle.dart';
import 'package:recipes/services/models/recipes_result.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:recipes/ui/home/pages/recipes_list.dart';
import 'dart:io' show Platform;

import 'core/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes',
      theme: ThemeData(
        primaryColor: appColorPrimary,
        accentColor: appColorSecondary,
      ),
      home: MyHomePage(title: 'Recipes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Recipe> data;

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/data/recipes.json');
    setState(() => data = RecipesResult.fromJson(json.decode(jsonText)).recipes );
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RecipesList(data)
      ),
      backgroundColor: backgroundColor,// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> appCenter() async {
    WidgetsFlutterBinding.ensureInitialized();
    const platform = const MethodChannel('recipes.platform/appcenter');

    var appSecretAndroid = '';
    var appSecretIOS = '';

    if (Platform.isAndroid) appSecretAndroid = await platform.invokeMethod('getAndroidAppSecret');
    if (Platform.isIOS) appSecretIOS = await platform.invokeMethod('getIOSAppSecret');

    await AppCenter.startAsync(
      appSecretAndroid: appSecretAndroid, //YOUR android APPSECRET CODE
      appSecretIOS: appSecretIOS, //YOUR iOS APPSECRET CODE
      enableAnalytics: false, // Defaults to true
      enableCrashes: false, // Defaults to true
      enableDistribute: true, // Defaults to false
      usePrivateDistributeTrack: false, // Defaults to false
      disableAutomaticCheckForUpdate: true, // Defaults to false
    );

    // await AppCenter.configureAnalyticsAsync(enabled: true);
    // await AppCenter.configureCrashesAsync(enabled: true);
    await AppCenter.configureDistributeAsync(enabled: true);
    // await AppCenter.configureDistributeDebugAsync(enabled: true); // Android Only
    // await AppCenter.checkForUpdateAsync(); // Manually check for update
  }
}
