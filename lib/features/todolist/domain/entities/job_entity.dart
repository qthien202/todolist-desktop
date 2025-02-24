import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  final String id;
  final String name;
  const JobEntity({required this.id, required this.name});

  @override
  List get props => [id, name];
}
