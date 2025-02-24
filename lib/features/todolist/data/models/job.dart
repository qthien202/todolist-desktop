import 'package:app_todolist_desktop/features/todolist/domain/entities/job_entity.dart';

class JobModel extends JobEntity {
  const JobModel(
      {required super.id,
      required super.name,
      super.isDone = false,
      super.priority = JobPriority.low});

  factory JobModel.fromJson(Map<String, dynamic> map) {
    return JobModel(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        isDone: map['isDone'] ?? false,
        priority: map['priority'] ?? JobPriority.low);
  }

  factory JobModel.fromEntity(JobEntity entity) {
    return JobModel(
        id: entity.id,
        name: entity.name,
        isDone: entity.isDone,
        priority: entity.priority);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['isDone'] = isDone;
    map['priority'] = priority;
    return map;
  }
}
