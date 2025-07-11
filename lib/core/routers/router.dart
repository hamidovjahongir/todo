import 'package:go_router/go_router.dart';
import 'package:todo/core/routers/app_routers.dart';
import 'package:todo/features/home/presentation/pages/add_task.dart';
import 'package:todo/features/home/presentation/pages/completed_screen.dart';
import 'package:todo/features/home/presentation/pages/edit_task.dart';
import 'package:todo/features/home/presentation/pages/home_page.dart';
import 'package:todo/features/main/presentation/pages/main_screen.dart';

final GoRouter apppRoute = GoRouter(
  initialLocation: AppRouters.home,
  routes: [
    GoRoute(
      path: AppRouters.add,
      name: AppRouters.add,
      pageBuilder: (context, state) => NoTransitionPage(child: AddTask()),
    ),

    GoRoute(
      path: AppRouters.edit,
      name: AppRouters.edit,
      pageBuilder: (context, state) => NoTransitionPage(child: EditTask()),
    ),
    StatefulShellRoute.indexedStack(
      builder:
          (context, state, navigationShell) =>
              MainScreen(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouters.home,
              name: AppRouters.home,
              pageBuilder:
                  (context, state) => NoTransitionPage(child: HomePage()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRouters.completed,
              name: AppRouters.completed,
              pageBuilder:
                  (context, state) =>
                      NoTransitionPage(child: CompletedScreen()),
            ),
          ],
        ),
      ],
    ),
  ],
);
