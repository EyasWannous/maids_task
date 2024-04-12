import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/animation/fade_indexed_stack.dart';
import 'package:task_manager_app/edit_task/view/edit_task_page.dart';
import 'package:task_manager_app/home/cubit/home_cubit.dart';
import 'package:task_manager_app/home/widgets/home_tab_button.dart';
import 'package:task_manager_app/stats/view/stats_page.dart';
import 'package:task_manager_app/tasks_overview/bloc/tasks_overview_bloc.dart';
import 'package:task_manager_app/tasks_overview/view/tasks_overview_page.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    return Scaffold(
      body: FadeIndexedStack(
        index: selectedTab.index,
        children: const [TasksOverviewPage(), StatsPage()],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        key: const Key('homeView_addTask_floatingActionButton'),
        onPressed: () => Navigator.of(context).push(
          EditTaskPage.route(
            tasksOverviewBloc: context.read<TasksOverviewBloc>(),
            initialTask: null,
          ),
        ),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.todos,
              icon: const Icon(Icons.list),
            ),
            HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.stats,
              icon: const Icon(Icons.show_chart_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
