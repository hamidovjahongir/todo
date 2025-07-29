import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/routers/app_routers.dart';
import 'package:todo/features/home/data/model/todo_mode.dart';
import 'package:todo/features/home/presentation/bloc/todo_bloc.dart';
import 'package:todo/features/home/presentation/widgets/mybutton.dart';

class EditTask extends StatefulWidget {
  final TodoMode todo;
  const EditTask({super.key, required this.todo});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late final TextEditingController nameController;
  TextEditingController degreeController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  int degreeValue = 4;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.todo.name);

    degreeValue = widget.todo.degree;
    String degreeText;
    switch (degreeValue) {
      case 1:
        degreeText = "Zarur";
        break;
      case 2:
        degreeText = "O‘rtacha";
        break;
      case 3:
        degreeText = "Zarur emas";
        break;
      default:
        degreeText = "";
    }

    degreeController = TextEditingController(text: degreeText);
  }

  void updateTodo() async {
    final updated = widget.todo.copywith(
      name: nameController.text,
      degree: int.tryParse(degreeController.text) ?? widget.todo.degree,
    );
    context.read<TodoBloc>().add(UpdateToDoEvent(updated));
    context.go(AppRouters.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.push(AppRouters.home),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Edit Task',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Color(0xff9395D3),
      ),

      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: "ToDo name"),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: degreeController,
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
                            degreeController.text = "Zarur";
                            break;
                          case 2:
                            degreeController.text = "O‘rtacha";
                            break;
                          case 3:
                            degreeController.text = "Zarur emas";
                            break;
                        }
                      });
                    }
                  },
                  decoration: InputDecoration(hintText: "Darajani tanlang"),
                ),

                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Mybutton(
                      title: 'Update',
                      width: MediaQuery.of(context).size.width * 0.45 - 15,
                      fontSize: 16,
                      onTap: updateTodo,
                    ),
                    Mybutton(
                      title: 'Cancel',
                      width: MediaQuery.of(context).size.width * 0.45 - 15,
                      fontSize: 16,
                      onTap: () => context.go(AppRouters.home),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
