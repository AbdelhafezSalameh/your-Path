import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_uni_services2/To-Do/utils/utils.dart';

final categoryProvider = StateProvider.autoDispose<TaskCategory>((ref) {
  return TaskCategory.others;
});
