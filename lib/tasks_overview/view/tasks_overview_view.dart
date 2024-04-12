import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/edit_task/view/edit_task_page.dart';
import 'package:task_manager_app/tasks_overview/bloc/tasks_overview_bloc.dart';
import 'package:task_manager_app/tasks_overview/widgets/task_list_tile.dart';
import 'package:task_manager_app/tasks_overview/widgets/tasks_overview_options_button.dart';

class TasksOverviewView extends StatelessWidget {
  const TasksOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Tasks'),
        actions: const [
          TasksOverviewOptionsButton(enableLogOut: true),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TasksOverviewBloc, TasksOverviewState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == TasksOverviewStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('An error occurred while loading tasks.'),
                    ),
                  );
              }
            },
          ),
          BlocListener<TasksOverviewBloc, TasksOverviewState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedTask != current.lastDeletedTask &&
                current.lastDeletedTask != null,
            listener: (context, state) {
              final deletedTask = state.lastDeletedTask!;
              final messenger = ScaffoldMessenger.of(context);
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('Task ${deletedTask.todo} deleted.')),
                );
            },
          ),
        ],
        child: BlocBuilder<TasksOverviewBloc, TasksOverviewState>(
          builder: (context, state) {
            if (state.tasks.isEmpty) {
              if (state.status == TasksOverviewStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status != TasksOverviewStatus.success) {
                return const SizedBox();
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/images/tasks.jpg',
                        width: 250,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'No tasks found with the selected filters.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            }

            return state.tasks.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: context.read<TasksOverviewBloc>().onRefresh,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: context
                          .read<TasksOverviewBloc>()
                          .resultScrollController,
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        if (index != state.tasks.length - 1) {
                          return TaskListTile(
                            task: state.tasks.elementAt(index),
                            onDismissed: (_) {
                              context.read<TasksOverviewBloc>().add(
                                    TasksOverviewTaskDeleted(
                                      state.tasks.elementAt(index),
                                    ),
                                  );
                            },
                            onToggleCompleted: (isCompleted) {
                              context.read<TasksOverviewBloc>().add(
                                    TasksOverviewTaskCompletionToggled(
                                      task: state.tasks.elementAt(index),
                                      completed: isCompleted,
                                    ),
                                  );
                            },
                            onTap: () {
                              Navigator.of(context).push(
                                EditTaskPage.route(
                                  tasksOverviewBloc:
                                      context.read<TasksOverviewBloc>(),
                                  initialTask: state.tasks.elementAt(index),
                                ),
                              );
                            },
                          );
                        }
                        return Column(
                          children: [
                            TaskListTile(
                              task: state.tasks.elementAt(index),
                              onDismissed: (_) {
                                context.read<TasksOverviewBloc>().add(
                                      TasksOverviewTaskDeleted(
                                        state.tasks.elementAt(index),
                                      ),
                                    );
                              },
                              onToggleCompleted: (isCompleted) {
                                context.read<TasksOverviewBloc>().add(
                                      TasksOverviewTaskCompletionToggled(
                                        task: state.tasks.elementAt(index),
                                        completed: isCompleted,
                                      ),
                                    );
                              },
                              onTap: () {
                                Navigator.of(context).push(
                                  EditTaskPage.route(
                                    tasksOverviewBloc:
                                        context.read<TasksOverviewBloc>(),
                                    initialTask: state.tasks.elementAt(index),
                                  ),
                                );
                              },
                            ),
                            if (state.status == TasksOverviewStatus.loading)
                              const Center(child: RefreshProgressIndicator()),
                          ],
                        );
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}
