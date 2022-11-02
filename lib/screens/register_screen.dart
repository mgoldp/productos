import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/services/auth_service.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            CardContainer(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Crear nueva cuenta.',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: const _LoginForm(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              style: ButtonStyle(
                overlayColor:
                    MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                shape: MaterialStateProperty.all(const StadiumBorder()),
              ),
              child: const Text(
                '¿Ya tienes una cuenta?',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      )),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: loginForm.formKey,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'john.doe@gmail.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_rounded,
              ),
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Por favor ingrese un correo válido.';
              },
              onChanged: (value) {
                loginForm.email = value;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                hintText: '********',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline,
              ),
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe tener al menos 6 caracteres';
              },
              onChanged: (value) {
                loginForm.password = value;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;

                      final String? errorMessage = await authService.createUser(
                          loginForm.email, loginForm.password);

                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'homescreen');
                      } else {
                        // TODO: Mostrar error por pantalla
                        print(errorMessage);
                      }

                      loginForm.isLoading = false;
                    },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading ? 'Espere...' : 'Ingresar',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
