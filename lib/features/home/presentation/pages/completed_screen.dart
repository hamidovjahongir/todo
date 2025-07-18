import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/home/presentation/bloc/todo_bloc.dart';
import 'package:todo/features/home/presentation/widgets/my_task_widget.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  int degreeValue = 4;

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(GetCompletedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD6D7EF),

      appBar: AppBar(
        title: Text(
          'Completed Task',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever, color: Colors.white),
            onPressed: () {
              context.read<TodoBloc>().add(ClearAllEvent());
            },
          ),
        ],
        backgroundColor: Color(0xff9395D3),
      ),

      body: BlocBuilder<TodoBloc, TodoState>(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [                    
                    Text("Ma'lumotlar yo'q."),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final data = state.todos[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: MyTaskWidget(
                    showAction: false,
                    todoTitle: data.name,
                    todoSubTitle:
                        data.degree == 1
                            ? "Zarur"
                            : data.degree == 2
                            ? "Ortacha"
                            : "Zarur emas",
                  ),
                );
              },
            );
          }
          return Container(width: 300, height: 300, color: Colors.amber);
        },
      ),
    );
  }
}
