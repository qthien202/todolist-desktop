import 'package:equatable/equatable.dart';

enum JobPriority { low, medium, high }

class JobEntity extends Equatable {
  final String id;
  final String name;
  final bool isDone;
  final JobPriority priority;

  const JobEntity(
      {required this.id,
      required this.name,
      this.isDone = false,
      this.priority = JobPriority.low});

  @override
  List get props => [id, name];
}
