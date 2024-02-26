part of 'register_cubit.dart';

enum FormStatus {
  invalid,
  valid,
  validating,
  posting,
}

class RegisterFormState extends Equatable {
  final String username, email, password;

  final FormStatus formStatus;

  const RegisterFormState({
    this.username = '',
    this.email = '',
    this.password = '',
    this.formStatus = FormStatus.invalid,
  });

  @override
  List<Object> get props => [formStatus, username, email, password];

  copyWith({String? username, email, password, FormStatus? formStatus}) {
    return RegisterFormState(
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}

class RegisterInitial extends RegisterFormState {}
