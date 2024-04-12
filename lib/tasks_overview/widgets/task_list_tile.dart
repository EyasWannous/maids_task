import 'package:flutter/material.dart';
import 'package:tasks_api/tasks_api.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    required this.task,
    super.key,
    this.onToggleCompleted,
    this.onDismissed,
    this.onTap,
  });

  final Task task;
  final ValueChanged<bool>? onToggleCompleted;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.bodySmall?.color;

    return Dismissible(
      key: Key('taskListTile_dismissible_${task.id}'),
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: theme.colorScheme.error,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(
          Icons.delete,
          color: Color(0xAAFFFFFF),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          task.todo,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: !task.completed
              ? TextStyle(
                  color: captionColor,
                  fontWeight: FontWeight.bold,
                )
              : TextStyle(
                  color: captionColor,
                  decoration: TextDecoration.lineThrough,
                  fontWeight: FontWeight.w400,
                ),
        ),
        subtitle: Text(
          task.userId.toString(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: Checkbox(
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          value: task.completed,
          onChanged: onToggleCompleted == null
              ? null
              : (value) => onToggleCompleted!(value!),
        ),
      ),
    );
  }
}
