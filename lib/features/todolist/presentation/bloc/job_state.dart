import '../../domain/entities/job_entity.dart';

sealed class JobState {
  const JobState();
}

class JobInit extends JobState {}

class JobLoading extends JobState {}

class JobSuccess extends JobState {
  final List<JobEntity> jobs;
  const JobSuccess({required this.jobs});
}

class JobIsEmpty extends JobState {}

class JobError extends JobState {
  final String message;
  const JobError({required this.message});
}

class JobMultiStatusSuccess extends JobState {
  final List<JobEntity> todoJobs;
  final List<JobEntity> inProgressJobs;
  final List<JobEntity> doneJobs;
  JobMultiStatusSuccess(
      {required this.todoJobs,
      required this.inProgressJobs,
      required this.doneJobs});
}
