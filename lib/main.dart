import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/layouts/main_layout/cubit/main_cubit.dart';
import 'package:project/layouts/main_layout/cubit/main_states.dart';
import 'package:project/layouts/main_layout/main_layout.dart';
import 'package:project/shared/network/local/cash_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();

  bool? isDark=CashHelper.getBool(key: 'isDarkMode');
  runApp(MyApp(isDark : (isDark==null)? false : isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  const MyApp({Key? key,required this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()..changeMode(fromShared: isDark)..initSql()..getData(),
      child: BlocConsumer<MainCubit,MainStates>(
        listener: (context, state) {

        },
        builder: (context , state){
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(

              primarySwatch: Colors.blue,
            ),
            home: MainLayout(),
          );
        },
      ),
    );
  }
}

