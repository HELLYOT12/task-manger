import 'package:dalioz/blocs/task_bloc.dart';
import 'package:dalioz/pages/Task_page.dart';
import 'package:dalioz/pages/add_task_page.dart';
import 'package:dalioz/pages/canceled_task_page.dart';
import 'package:dalioz/pages/completed_task_page.dart';
import 'package:dalioz/pages/home_page.dart';
import 'package:dalioz/pages/login_page.dart';
import 'package:dalioz/pages/ongoing_task_page.dart';
import 'package:dalioz/pages/pending_task_page.dart';
import 'package:dalioz/pages/root_page.dart';
import 'package:dalioz/pages/sign_up_page.dart';
import 'package:dalioz/pages/spalsh_page.dart';
import 'package:dalioz/utility/utility.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto-Regular',
        ).copyWith(
            colorScheme: const ColorScheme.light(
              background: Color(0xffFFFFFF),
            )
        ),
        home: RootPage(),
      ),
    );
  }
}
