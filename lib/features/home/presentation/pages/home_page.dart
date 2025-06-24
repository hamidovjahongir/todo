import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/theme/them_provider.dart';
import 'package:todo/features/home/data/model/todo_mode.dart';
import 'package:todo/features/home/data/repository/todo_repository.dart';
import 'package:todo/features/home/presentation/bloc/todo_bloc.dart';
import 'package:todo/features/home/presentation/widgets/my_widget.dart';
import 'package:todo/features/home/presentation/widgets/mybutton.dart';

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

  void addData() {
    if (_globalKey.currentState!.validate()) {
      final id = DateTime.now().microsecondsSinceEpoch;
      context.read<TodoBloc>().add(
        AddToDoEvent(
          TodoMode(id: id, name: controller.text, degree: degreeValue),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: Drawer(
        backgroundColor: Colors.deepPurple[100],
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20),
          child: Column(
            children: [
              SizedBox(height: 100),
              SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    fit: BoxFit.cover,
                    'https://as2.ftcdn.net/v2/jpg/01/51/99/39/1000_F_151993994_mmAYzngmSbNRr6Fxma67Od3WHrSkfG5I.jpg',
                  ),
                ),
              ),
              SizedBox(height: 20),
              MyWidget(
                width: MediaQuery.of(context).size.width * 0.95,
                height: 50,
                title: 'Settings',
                color: Colors.pinkAccent,
                onTap: () {},
              ),
              IconButton(
                onPressed: () {
                  Provider.of<ThemProvider>(
                    context,
                    listen: false,
                  ).toggleTheme();
                },
                icon: Icon(Icons.dark_mode),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("ToDo"),
        actions: [
          IconButton(
            onPressed: () {
              if (buttonDelete && selectedIds.isNotEmpty) {
                for (int id in selectedIds) {
                  context.read<TodoBloc>().add(RemoveToDoEvent(id));
                }
                setState(() {
                  selectedIds.clear();
                  buttonDelete = false;
                });
              } else {
                setState(() {
                  buttonDelete = !buttonDelete;
                });
              }
            },
            icon: Icon(Icons.delete),
          ),

          PopupMenuButton<int>(
            icon: Icon(Icons.sort),
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
                      return ListTile(
                        leading: Text("${index + 1}"),
                        subtitle:
                            data.degree == 1
                                ? Text(
                                  "Zarur",
                                  style: TextStyle(color: Colors.red),
                                )
                                : data.degree == 2
                                ? Text(
                                  "Ortacha",
                                  style: TextStyle(color: Colors.amber),
                                )
                                : Text(
                                  "Zaril emas",
                                  style: TextStyle(color: Colors.black),
                                ),

                        title: Text(
                          data.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        trailing:
                            buttonDelete
                                ? Checkbox(
                                  value: selectedIds.contains(data.id),
                                  onChanged: (value) {
                                    setState(() {
                                      if (value!) {
                                        selectedIds.add(data.id);
                                      } else {
                                        selectedIds.remove(data.id);
                                      }
                                    });
                                  },
                                )
                                : null,
                      );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder:
                (context) => SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 50.0,
                      left: 10,
                      right: 10,
                      bottom: 20,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: "ToDo name",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter ToDo name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
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
                          decoration: InputDecoration(
                            hintText: "Darajani tanlang",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Darajani tanlang";
                            }
                            return null;
                          },
                        ),

                        Spacer(),

                        Mybutton(title: "Add ToDo", onTap: addData),
                      ],
                    ),
                  ),
                ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
