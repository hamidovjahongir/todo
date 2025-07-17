import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:telegram_logger/telegram_logger.dart';
import 'package:todo/core/routers/router.dart';
import 'package:todo/core/theme/them_provider.dart';
import 'package:todo/features/home/data/model/todo_mode.dart';
import 'package:todo/features/home/data/repository/todo_repository.dart';
import 'package:todo/features/home/presentation/bloc/todo_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  TelegramLogger.init(
    botToken: '8089965761:AAHWenUCm_aYS2AIHpjR67v7Xm98qhQia18',
    chatId: '1744450808',
    appName: 'Salom',
  );
  Hive.registerAdapter(TodoModeAdapter());

  await Hive.openBox<TodoMode>('todos');
  runApp(
    ChangeNotifierProvider(
      create: (ctx) => ThemProvider(),
      child: const MainApp(),
    ),
  );
}

final TodoRepository repository = TodoRepository();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(repository),
      child: MaterialApp.router(
        routerConfig: apppRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
