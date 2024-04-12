import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/stats/bloc/stats_bloc.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<StatsBloc>().state;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stats'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              key: const Key('statsView_completedTasks_listTile'),
              leading: const Icon(Icons.check_rounded),
              title: const Text('Completed tasks'),
              trailing: Text(
                '${state.completedTasks}',
                style: textTheme.headlineSmall,
              ),
            ),
            ListTile(
              key: const Key('statsView_activeTasks_listTile'),
              leading: const Icon(Icons.radio_button_unchecked_rounded),
              title: const Text('Active tasks'),
              trailing: Text(
                '${state.activeTasks}',
                style: textTheme.headlineSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
