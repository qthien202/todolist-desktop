import 'package:app_todolist_desktop/features/todolist/domain/entities/job_entity.dart';

class JobModel extends JobEntity {
  const JobModel(
      {super.id,
      required super.name,
      super.status = "todo",
      super.priority = "low"});

  factory JobModel.fromJson(Map<String, dynamic> map) {
    return JobModel(
        id: map['id'] ?? 1,
        name: map['name'] ?? '',
        status: map['status'] ?? JobStatus.todo.name,
        priority: map['priority'] ?? JobPriority.low.name);
  }

  factory JobModel.fromEntity(JobEntity entity) {
    return JobModel(
        id: entity.id,
        name: entity.name,
        status: entity.status,
        priority: entity.priority);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['status'] = status;
    map['priority'] = priority;
    return map;
  }
}
