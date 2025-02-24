import 'package:app_todolist_desktop/features/todolist/domain/entities/job_entity.dart';

class JobModel extends JobEntity {
  const JobModel(
      {required super.id, required super.name, super.isDone = false});

  factory JobModel.fromJson(Map<String, dynamic> map) {
    return JobModel(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        isDone: map['isDone'] ?? false);
  }

  factory JobModel.fromEntity(JobEntity entity) {
    return JobModel(id: entity.id, name: entity.name, isDone: entity.isDone);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['isDone'] = isDone;
    return map;
  }
}
