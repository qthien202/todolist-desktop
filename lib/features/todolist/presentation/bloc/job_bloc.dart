import 'dart:convert';
import 'dart:ui';

import 'package:app_todolist_desktop/extensions/swap.dart';
import 'package:app_todolist_desktop/features/todolist/domain/entities/job_entity.dart';
import 'package:app_todolist_desktop/features/todolist/domain/usecases/delete_job_by_status_usecase.dart';
import 'package:app_todolist_desktop/features/todolist/domain/usecases/get_job_by_status_usecase.dart';
import 'package:app_todolist_desktop/features/todolist/domain/usecases/job_usecases.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/bloc/job_event.dart';
import 'package:app_todolist_desktop/features/todolist/presentation/bloc/job_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final AddJobUsecase addJobUsecase;
  final GetJobsUsecase getJobsUsecase;
  final UpdateJobByIdUsecase updateJobUsecase;
  final DeleteJobByIdUsecase deleteJobUsecase;
  final GetJobByStatusUseCase getJobByStatusUseCase;
  final DeleteJobByStatusUseCase deleteJobByStatusUseCase;
  JobBloc(
      {required this.addJobUsecase,
      required this.getJobsUsecase,
      required this.updateJobUsecase,
      required this.deleteJobUsecase,
      required this.getJobByStatusUseCase,
      required this.deleteJobByStatusUseCase})
      : super(JobInit()) {
    on<AddJobEvent>((event, emit) => addJob(event, emit));
    on<GetJobsEvent>((event, emit) => getJobs(emit));
    on<UpdateJobEvent>((event, emit) => updateJob(event, emit));
    on<DeleteJobByIdEvent>((event, emit) => deleteJob(event.id, emit));
    on<GetJobByMultipleStatusEvent>(
        (event, emit) => getMultipleJobByStatus(emit));
    on<UpdateJobPositionEvent>((event, emit) => updateJobPosition(event, emit));
    on<DeleteJobByStatusEvent>(
        (event, emit) => deleteJobByStatus(event.status, emit));
  }

  Future<void> addJob(AddJobEvent event, Emitter<JobState> emit) async {
    emit(JobLoading());
    try {
      await addJobUsecase(event.job);
      await getMultipleJobByStatus(emit);
    } catch (e) {
      emit(JobError(message: e.toString()));
    }
  }

  Future<void> getJobs(Emitter<JobState> emit) async {
    emit(JobLoading());
    try {
      final jobs = await getJobsUsecase();

      if (jobs.isEmpty) {
        emit(JobIsEmpty());
        return;
      }
      emit(JobSuccess(jobs: jobs));
    } catch (e) {
      emit(JobError(message: e.toString()));
    }
  }

  // Future<void> getJobByStatus(
  //     List<String> status, Emitter<JobState> emit) async {
  //   emit(JobLoading());
  //   try {
  //     final jobs = await getJobByStatusUseCase(status);

  //     if (jobs.isEmpty) {
  //       emit(JobIsEmpty());
  //       return;
  //     }
  //     emit(JobSuccess(jobs: jobs));
  //   } catch (e) {
  //     emit(JobError(message: e.toString()));
  //   }
  // }

  Future<void> updateJob(UpdateJobEvent event, Emitter<JobState> emit) async {
    emit(JobLoading());
    try {
      await updateJobUsecase(event.id, event.job);
      await getMultipleJobByStatus(emit);
    } catch (e) {
      emit(JobError(message: e.toString()));
    }
  }

  Future<void> deleteJob(int id, Emitter<JobState> emit) async {
    emit(JobLoading());
    try {
      await deleteJobUsecase(id);
      await getMultipleJobByStatus(emit);
    } catch (e) {
      emit(JobError(message: e.toString()));
    }
  }

  Future<void> getMultipleJobByStatus(Emitter<JobState> emit) async {
    emit(JobLoading());
    try {
      final todoJobs = await getJobByStatusUseCase('todo');
      final inProgressJobs = await getJobByStatusUseCase('inProgress');
      final doneJobs = await getJobByStatusUseCase('done');
      emit(JobMultiStatusSuccess(
          todoJobs: todoJobs,
          inProgressJobs: inProgressJobs,
          doneJobs: doneJobs));
    } catch (e) {
      emit(JobError(message: e.toString()));
    }
  }

  Future<void> updateJobPosition(
      UpdateJobPositionEvent event, Emitter<JobState> emit) async {
    final todoJobs = await getJobByStatusUseCase('todo');
    final inProgressJobs = await getJobByStatusUseCase('inProgress');
    final doneJobs = await getJobByStatusUseCase('done');

    List<JobEntity> targets;
    switch (event.status) {
      case "todo":
        targets = todoJobs;
        break;
      case "inProgress":
        targets = inProgressJobs;
        break;
      case "done":
        targets = doneJobs;
        break;
      default:
        return;
    }
    if (event.oldIndex < 0 ||
        event.newIndex < 0 ||
        event.oldIndex >= targets.length ||
        event.newIndex >= targets.length) {
      return;
    }
    targets.swap(event.oldIndex, event.newIndex);
    print(">>>>>>targets: $targets");
    emit(JobMultiStatusSuccess(
        todoJobs: todoJobs,
        inProgressJobs: inProgressJobs,
        doneJobs: doneJobs));
  }

  Future<void> deleteJobByStatus(String status, Emitter<JobState> emit) async {
    emit(JobLoading());
    try {
      await deleteJobByStatusUseCase(status);
      await getMultipleJobByStatus(emit);
    } catch (e) {
      emit(JobError(message: e.toString()));
    }
  }
}
