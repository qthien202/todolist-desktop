import 'package:app_todolist_desktop/features/todolist/domain/entities/job_entity.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/bloc/job_bloc.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/bloc/job_state.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/pages/add_job_dialog.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/widgets/job_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            title: Text("Ứng dụng TodoList"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blue),
                    ),
                    onPressed: () async =>
                        await showAddJobDialog(context: context),
                    child: Text(
                      "Thêm công việc",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: BlocConsumer<JobBloc, JobState>(
              listener: (context, state) {
                if (kDebugMode) {
                  print(">>>>>>>>state1: $state");
                }
                if (state is JobError) {
                  if (kDebugMode) {
                    print(">>>>>>>>error: ${state.message}");
                  }
                }
              },
              builder: (context, state) {
                if (kDebugMode) {
                  print(">>>>>>>>state2: $state");
                }
                List<JobEntity> jobs = [];
                if (state is JobLoading) {
                  return CircularProgressIndicator();
                }

                if (state is JobIsEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Không có công việc nào",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  );
                }
                jobs = state is JobSuccess ? state.jobs : [];
                return GridView.builder(
                  padding: EdgeInsets.all(8),
                  shrinkWrap: true,
                  itemCount: jobs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 10 / 4,
                      crossAxisSpacing: 10,
                      // mainAxisExtent: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 5),
                  itemBuilder: (context, index) {
                    return jobWidget(jobs[index], context);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
