import 'package:app_todolist_desktop/features/todolist/domain/entities/job_entity.dart';

sealed class JobEvent {
  JobEvent();
}

class AddJobEvent extends JobEvent {
  final JobEntity job;
  AddJobEvent({required this.job});
}

class GetJobsEvent extends JobEvent {
  GetJobsEvent();
}

class GetJobByStatusEvent extends JobEvent {
  final List<String> statuses;
  GetJobByStatusEvent({required this.statuses});
}

class GetJobByMultipleStatusEvent extends JobEvent {}

class UpdateJobEvent extends JobEvent {
  final int id;
  final JobEntity job;
  UpdateJobEvent({required this.id, required this.job});
}

class DeleteJobByIdEvent extends JobEvent {
  final int id;
  DeleteJobByIdEvent({required this.id});
}
