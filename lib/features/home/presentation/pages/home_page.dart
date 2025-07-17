import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/routers/app_routers.dart';
import 'package:todo/features/home/data/repository/todo_repository.dart';
import 'package:todo/features/home/presentation/bloc/todo_bloc.dart';
import 'package:todo/features/home/presentation/widgets/my_task_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TodoRepository todoRepository = TodoRepository();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  late final TextEditingController degree;
  int degreeValue = 4;

  bool buttonDelete = false;
  bool delete = false;
  List<int> selectedIds = [];

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(GetToDoEvent());
    controller = TextEditingController();
    degree = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD6D7EF),
      appBar: AppBar(
        backgroundColor: Color(0xff9395D3),
        title: Text(
          "TODO APP",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            icon: Icon(Icons.sort, color: Colors.white, size: 32),
            onSelected: (value) {
              setState(() {
                degreeValue = value;
              });
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(value: 4, child: Text("Hammasi")),
                  PopupMenuItem(value: 1, child: Text("Zarur")),
                  PopupMenuItem(value: 2, child: Text("Ortacha")),
                  PopupMenuItem(value: 3, child: Text("Zarur emas")),
                ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is TodoLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is TodoError) {
                return Center(child: Text(state.error));
              }

              if (state is TodoSuccsess) {
                if (state.todos.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                        ),
                        Text("Ma'lumotlar yo'q."),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    final data = state.todos[index];
                    if (degreeValue == 4 || data.degree == degreeValue) {
                      if (data.isDone == false) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),

                          child: MyTaskWidget(
                            isDone: () {
                              context.read<TodoBloc>().add(
                                IsDoneEvent(true, index),
                              );
                            },

                            edit: () async {
                              context.go(AppRouters.edit, extra: data);
                            },

                            delete: () {
                              context.read<TodoBloc>().add(
                                RemoveToDoEvent(data.id),
                              );
                            },

                            todoTitle: data.name,
                            todoSubTitle:
                                data.degree == 1
                                    ? "Zarur"
                                    : data.degree == 2
                                    ? "Ortacha"
                                    : "Zaril emas",
                          ),
                        );
                      }
                    }
                    return SizedBox();
                  },
                );
              }
              return Container(width: 300, height: 300, color: Colors.amber);
            },
          ),
        ),
      ),
      floatingActionButton: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          context.go(AppRouters.add);
        },
        child: Ink(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 5,
                color: Colors.black.withOpacity(0.2),
                offset: Offset(0, 10),
              ),
            ],
            color: Color(0xff9395D3),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
