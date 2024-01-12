import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_uni_services2/To-Do/data/data.dart';
import 'package:student_uni_services2/To-Do/providers/providers.dart';

final tasksProvider = StateNotifierProvider<TaskNotifier, TaskState>((ref) {
  final repository = ref.watch(taskRepositoryProvider);
  return TaskNotifier(repository);
});
