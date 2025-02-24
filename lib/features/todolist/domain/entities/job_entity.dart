import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  final String id;
  final String name;
  final bool isDone;
  const JobEntity({required this.id, required this.name,this.isDone = false});

  @override
  List get props => [id, name];
}
