import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/features/home/presentation/bloc/todo_bloc.dart';

class MainScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({super.key, required this.navigationShell});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _onTap(int index) {
    if (index == 0) {
      context.read<TodoBloc>().add(GetToDoEvent());
    } else if (index == 1) {
      context.read<TodoBloc>().add(GetCompletedEvent());
    }

    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD6D7EF),
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: Colors.transparent,
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.menu, color: Color(0XFF9395D3)),
            icon: Icon(Icons.menu, color: Colors.black54),
            label: 'All',
          ),

          NavigationDestination(
            selectedIcon: Icon(Icons.done, color: Color(0XFF9395D3)),
            icon: Icon(Icons.done, color: Colors.black54),
            label: 'Completed',
          ),
        ],
      ),
    );
  }
}
