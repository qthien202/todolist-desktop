import 'package:equatable/equatable.dart';

enum JobPriority { low, medium, high }

enum JobStatus { todo, inProgress, done }

class JobEntity extends Equatable {
  final int? id;
  final String name;
  final String status;
  final String priority;

  const JobEntity(
      {required this.id,
      required this.name,
      this.status = "todo",
      this.priority = "low"});

  @override
  List get props => [id, name, status, priority];
}
