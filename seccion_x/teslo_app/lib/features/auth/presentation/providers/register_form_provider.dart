import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/shared/shared.dart';

final registerFormStateNotifierProvider =
    StateNotifierProvider<RegisterFormStateNotifier, RegisterFormState>((ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;
  return RegisterFormStateNotifier(registerUserCallback: registerUserCallback);
});

class RegisterFormStateNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String) registerUserCallback;

  RegisterFormStateNotifier({required this.registerUserCallback})
      : super(RegisterFormState());

  onFullNameChange({required String fullName}) {
    state = state.copyWith(
      fullName: FullName.dirty(fullName),
      isValid: (Formz.validate(
        [state.fullName, state.email, state.password, state.confirmPassword],
      )),
    );
  }

  onEmailChange({required String email}) {
    final newEmail = Email.dirty(email);

    state = state.copyWith(
      email: newEmail,
      isValid: (Formz.validate(
        [state.fullName, newEmail, state.password, state.confirmPassword],
      )),
    );
  }

  onPasswordChange({required String password}) {
    final newPassword = Password.dirty(password);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate(
        [
          state.fullName,
          state.email,
          newPassword,
          state.confirmPassword,
        ],
      ),
    );
  }

  onConfirmPasswordChange({required String confirmPassword}) {
    final newConfirmPassword =
        ConfirmPassword.dirty(confirmPassword, state.password.value);
    state = state.copyWith(
      confirmPassword: newConfirmPassword,
      isValid: (Formz.validate(
        [state.email, state.password, state.fullName, newConfirmPassword],
      )),
    );
  }

  _touchEveryField() {
    final email = Email.dirty(state.email.value);

    final password = Password.dirty(state.password.value);

    final fullName = FullName.dirty(state.fullName.value);

    final confirmPassword =
        ConfirmPassword.dirty(state.confirmPassword.value, password.value);

    state = state.copyWith(
        isFormPosted: true,
        password: password,
        email: email,
        fullName: fullName,
        confirmPassword: confirmPassword,
        isValid: Formz.validate(
          [
            state.fullName,
            state.email,
            state.password,
            state.confirmPassword,
          ],
        ));
  }

  onSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;

    await registerUserCallback(
      state.fullName.value,
      state.email.value,
      state.password.value,
    );
  }
}

class RegisterFormState {
  final bool isValid;

  final bool isPosting;

  final bool isFormPosted;

  final FullName fullName;

  final Email email;

  final Password password;

  final ConfirmPassword confirmPassword;

  RegisterFormState({
    this.isValid = false,
    this.isPosting = false,
    this.isFormPosted = false,
    this.fullName = const FullName.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure('', ''),
  });

  @override
  String toString() {
    return '''
    RegisterFormState:
      isValid: $isValid
      isPosting: $isPosting
      isFormPosted: $isFormPosted
      fullName: $fullName
      email: $email
      password: $password
      confirmPassword: $confirmPassword
    ''';
  }

  copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    FullName? fullName,
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
  }) {
    return RegisterFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword);
  }
}
