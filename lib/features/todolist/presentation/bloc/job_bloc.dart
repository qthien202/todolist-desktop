import 'dart:ui';

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
  JobBloc(
      {required this.addJobUsecase,
      required this.getJobsUsecase,
      required this.updateJobUsecase,
      required this.deleteJobUsecase,
      required this.getJobByStatusUseCase})
      : super(JobInit()) {
    on<AddJobEvent>((event, emit) => addJob(event, emit));
    on<GetJobsEvent>((event, emit) => getJobs(emit));
    on<UpdateJobEvent>((event, emit) => updateJob(event, emit));
    on<DeleteJobByIdEvent>((event, emit) => deleteJob(event.id, emit));
    on<GetJobByStatusEvent>(
        (event, emit) => getJobByStatus(event.status, emit));
  }

  Future<void> addJob(AddJobEvent event, Emitter<JobState> emit) async {
    emit(JobLoading());
    try {
      await addJobUsecase(event.job);
      emit(JobSuccess(jobs: await getJobsUsecase()));
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

  Future<void> getJobByStatus(String status, Emitter<JobState> emit) async {
    emit(JobLoading());
    try {
      final jobs = await getJobByStatusUseCase(status);

      if (jobs.isEmpty) {
        emit(JobIsEmpty());
        return;
      }
      emit(JobSuccess(jobs: jobs));
    } catch (e) {
      emit(JobError(message: e.toString()));
    }
  }

  Future<void> updateJob(UpdateJobEvent event, Emitter<JobState> emit) async {
    emit(JobLoading());
    try {
      await updateJobUsecase(event.id, event.job);
      emit(JobSuccess(jobs: await getJobsUsecase()));
    } catch (e) {
      emit(JobError(message: e.toString()));
    }
  }

  Future<void> deleteJob(int id, Emitter<JobState> emit) async {
    emit(JobLoading());
    try {
      await deleteJobUsecase(id);
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
}
