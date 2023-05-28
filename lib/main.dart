import 'package:ipl_master/constants/global_variable.dart';
import 'package:ipl_master/features/home/home_screen.dart';
import 'package:ipl_master/providers/user_provider.dart';
import 'package:ipl_master/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/widgets/bottom_bar.dart';
import 'features/auth/auth_screen.dart';
import 'features/auth/services/auth_services.dart';

void main() {
  runApp(MultiProvider(providers:[
    ChangeNotifierProvider(
      create: (context)=> UserProvider(),
    )
  ],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IPL Master',
        theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            colorScheme: const ColorScheme.light(
              primary: GlobalVariables.secondaryColor,
            ),
            appBarTheme: const AppBarTheme(
                elevation: 0,
                iconTheme: IconThemeData(
                    color: Colors.black
                )
            )
        ),
        onGenerateRoute: (settings)=>generateRoute(settings),
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? const BottomBar()
            : const AuthScreen()
    );
  }
}
