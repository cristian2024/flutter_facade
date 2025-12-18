import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final String id;

  const UserModel({
    required this.name,
    required this.id,
  });

  @override
  List<Object?> get props => [name, id];
}
