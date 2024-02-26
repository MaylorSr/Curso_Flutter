import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSubmit() { }

  void changeUsername({required String username}) {
    emit(
      state.copyWith(username: username),
    );
  }

  void changeEmail({required String email}) {
    emit(
      state.copyWith(email: email),
    );
  }

  void changePassword({required String password}) {
    emit(
      state.copyWith(password: password),
    );
  }
}
