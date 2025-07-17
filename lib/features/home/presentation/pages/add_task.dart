import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/routers/app_routers.dart';
import 'package:todo/features/home/data/model/todo_mode.dart';
import 'package:todo/features/home/presentation/bloc/todo_bloc.dart';
import 'package:todo/features/home/presentation/widgets/mybutton.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late final TextEditingController degree;
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  int degreeValue = 4;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    degree = TextEditingController();
  }

  void addData() {
    if (_globalKey.currentState!.validate()) {
      final id = DateTime.now().microsecondsSinceEpoch;
      context.read<TodoBloc>().add(
        AddToDoEvent(
          TodoMode(id: id, name: controller.text, degree: degreeValue),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.push(AppRouters.home),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Add Task',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Color(0xff9395D3),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Form(
            key: _globalKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(hintText: "ToDo name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter ToDo name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: degree,
                  readOnly: true,
                  onTap: () async {
                    final result = await showModalBottomSheet<int>(
                      context: context,
                      builder:
                          (ctx) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              
                              ListTile(
                                title: Text("Zarur"),
                                onTap: () => Navigator.pop(ctx, 1),
                              ),
                              ListTile(
                                title: Text("O‘rtacha"),
                                onTap: () => Navigator.pop(ctx, 2),
                              ),
                              ListTile(
                                title: Text("Zarur emas"),
                                onTap: () => Navigator.pop(ctx, 3),
                              ),
                            ],
                          ),
                    );
                    if (result != null) {
                      setState(() {
                        degreeValue = result;
                        switch (result) {
                          case 1:
                            degree.text = "Zarur";
                            break;
                          case 2:
                            degree.text = "O‘rtacha";
                            break;
                          case 3:
                            degree.text = "Zarur emas";
                            break;
                        }
                      });
                    }
                  },
                  decoration: InputDecoration(hintText: "Darajani tanlang"),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Darajani tanlang";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 50),
                Mybutton(
                  title: 'ADD',
                  onTap: () {
                    addData();
                    context.go(AppRouters.home);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
