import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_uni_services2/To-Do/config/config.dart';
import 'package:student_uni_services2/To-Do/data/data.dart';
import 'package:student_uni_services2/To-Do/providers/providers.dart';
import 'package:student_uni_services2/To-Do/utils/utils.dart';
import 'package:student_uni_services2/To-Do/widgets/widgets.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:student_uni_services2/size_config.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  static CreateTaskScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const CreateTaskScreen();
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable, prefer_const_declarations
    final colors = const Color(0xFF297C74);

    return Scaffold(
      //appBar: AppBar(
      //   backgroundColor: Color(0xFF297C74),
      //   title: Text(
      //     "Add New Task",
      //     style: TextStyle(fontFamily: "Mulli", fontSize: 15),
      //   )),

      appBar: AppBar(
          backgroundColor: const Color(0xFF297C74),
          title: const Text(
            "Add New Task",
            style: TextStyle(fontFamily: "Mulli", fontSize: 15),
          )),
      // PreferredSize(
      //     preferredSize: Size.fromHeight(30.0), // here the desired height
      //     child: AppBar(
      //         leading: BackButton(
      //           color: Colors.black,
      //         ),
      //        ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(20), horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CommonTextField(
                hintText: 'Task Title',
                title: 'Task Title',
                controller: _titleController,
              ),
              Gap(getProportionateScreenHeight(20)),
              const CategoriesSelection(),
              Gap(getProportionateScreenHeight(20)),
              const SelectDateTime(),
              Gap(getProportionateScreenHeight(30)),
              CommonTextField(
                hintText: 'Notes',
                title: 'Notes',
                maxLines: 3,
                controller: _noteController,
              ),
              const Gap(20),
              ElevatedButton(
                onPressed: _createTask,
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF30D7BB),
                  backgroundColor: const Color(0xFF297C74),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: DisplayWhiteText(
                    text: 'Save',
                  ),
                ),
              ),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }

  void _createTask() async {
    final title = _titleController.text.trim();
    final note = _noteController.text.trim();
    final time = ref.watch(timeProvider);
    final date = ref.watch(dateProvider);
    final category = ref.watch(categoryProvider);
    if (title.isNotEmpty) {
      final task = Task(
        title: title,
        category: category,
        time: Helpers.timeToString(time),
        date: DateFormat.yMMMd().format(date),
        note: note,
        isCompleted: false,
      );

      await ref.read(tasksProvider.notifier).createTask(task).then((value) {
        AppAlerts.displaySnackbar(context, 'Task create successfully');
        context.go(RouteLocation.home);
      });
    } else {
      AppAlerts.displaySnackbar(context, 'Title cannot be empty');
    }
  }
}
