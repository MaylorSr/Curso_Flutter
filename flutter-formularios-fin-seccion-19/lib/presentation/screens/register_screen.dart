import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:forms_app/presentation/screens/screens.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo usuario'),
      ),
      body: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const FlutterLogo(
                size: 100,
              ),
              BlocProvider(
                create: (context) => RegisterCubit(),
                child: const RegisterForm(),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String username = '';
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    final register = context.watch<RegisterCubit>();
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField(
              label: 'Nombre de usuario',
              onchange: (p0) {
                register.changeUsername(username: p0!);
                _formKey.currentState!.validate();
              },
              validator: (p0) {
                if (p0 == null || p0.isEmpty) return 'Campo requerido';

                if (p0.trim().isEmpty) return 'El campo no puede estar vacío';

                if (p0.trim().length < 6) {
                  return 'El campo debe ser mayor a 6 letras';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              label: 'Correo electrónico',
              onchange: (p1) {
                register.changeEmail(email: p1!);
                _formKey.currentState!.validate();
              },
              validator: (p0) {
                final emailRegExp = RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                );
                if (p0 == null || p0.isEmpty) return 'Campo requerido';

                if (p0.trim().isEmpty) return 'El campo no puede estar vacío';

                if (!emailRegExp.hasMatch(p0)) return 'No es un correo válido';
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              label: 'Contraseña',
              obscure: true,
              onchange: (p2) {
                register.changePassword(password: p2!);
                _formKey.currentState!.validate();
              },
              validator: (p0) {
                if (p0 == null || p0.isEmpty) return 'Campo requerido';

                if (p0.trim().isEmpty) return 'El campo no puede estar vacío';

                if (p0.trim().length > 6) {
                  return 'El campo debe ser mayor a 6 letras';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton.tonalIcon(
              onPressed: () {
                /* final validado = _formKey.currentState!.validate();

                if (!validado) return; */
                register.onSubmit();
              },
              icon: const Icon(
                Icons.save,
              ),
              label: const Text('Save'),
            ),
          ],
        ));
  }
}
