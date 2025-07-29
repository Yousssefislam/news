import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/auth_cubit.dart';
import 'cubits/auth_state.dart';
import 'models/user_model.dart';
import 'utils/validation_utils.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => AuthCubit(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen(user: state.user)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AuthError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().login(
                          emailController.text,
                          passwordController.text,
                        );
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final UserModel user;

  const HomeScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome ${user.firstName}')),
      body: Center(
        child: Text('You are logged in!'),
      ),
    );
  }
}
