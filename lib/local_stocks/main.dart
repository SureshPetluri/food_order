import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_order/local_stocks/dash_board/dash_board_provider.dart';
import 'package:food_order/local_stocks/profile/profile_provider.dart';
import 'package:food_order/local_stocks/routes/routes_names.dart';
import 'package:food_order/local_stocks/themes/theme.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'app_repository/repository.dart';
import 'cart/cart_provider.dart';
import 'constants/constants.dart';
import 'home/home_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await GetStorage.init(LOCAL_STORAGE);
  runApp(
      EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('es')],
          path: 'assest/local_stocks/i18n', // <-- change the path of the translation files
          fallbackLocale: const Locale('en'),
          child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  void didChangeDependencies() {
    if(Repository.isDark() == null){
      if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
        Repository.changeTheme(true);
      } else {
        Repository.changeTheme(false);
        _themeMode = ThemeMode.light;
      }
    }else if(Repository.isDark()==true){
      _themeMode = ThemeMode.dark;
    }else{
      _themeMode = ThemeMode.light;
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashBoardProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        // initialRoute: ,
        title: 'Local Stocks',
        theme: ThemeClass.lightTheme(context),
        darkTheme: ThemeClass.darkTheme(context),
        themeMode: _themeMode,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          // print("settings.name....${settings.name}");
          final routeName = settings.name;
          final builder = AppPages(themeMode: _themeMode, changeTheme: changeTheme).routes[routeName];

          if (builder != null) {
            return MaterialPageRoute(builder: builder);
          }

          // Handle unknown route here if needed
          return null;
        },
        // home: DashBoard(
        //   changeTheme: changeTheme,
        //    themeMode: _themeMode,
        // ),
      ),
    );
  }
}
/*

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key,
      required this.title,
      required this.themeMode,
      required this.changeTheme});

  final String title;
  final void Function(ThemeMode) changeTheme;
  final ThemeMode themeMode;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.primary),
              ),
              onPressed: () {
                print("object...${widget.themeMode} ${MediaQuery.of(context).platformBrightness}");
                if(MediaQuery.of(context).platformBrightness == Brightness.dark){

                }else{

                }
                widget.themeMode == ThemeMode.dark
                    ? widget.changeTheme(ThemeMode.light)
                    : widget.changeTheme(ThemeMode.dark);
              },
              child: Text(
                'pushed',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              child: TextFormField(
                decoration: InputDecoration(),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
*/
