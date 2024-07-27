import 'package:flutter/material.dart';
import 'package:newsapplication/views/loginScreen.dart';
import 'package:newsapplication/services/auth_service.dart';
import 'package:provider/provider.dart';

//
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print('signup screen');
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyNews',
          style: TextStyle(color: Colors.blue.shade900),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Name cannot be empty' : null,
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Name',
                    ),
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        value!.isEmpty ? 'Email cannot be empty' : null,
                    decoration: const InputDecoration(hintText: 'Email'),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(hintText: 'Password'),
                    validator: (value) =>
                        value!.length < 6 ? 'Password too short' : null,
                  ),
                ],
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () async {
                      // signup

                      print('submit');
                      if (_formkey.currentState!.validate()) {
                        try {
                          await authService.signUpWithEmail(
                              _emailController.text,
                              _passwordController.text,
                              _nameController.text);
                          // Navigate to home or other page after successful signup
                          Navigator.pushNamed(context, '/login');
                        } catch (e) {
                          // Handle signup error
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Error: ${e.toString()}'),
                          ));
                          print('Signup Error: $e');
                        }
                      }
                    },
                    child: Text('Signup'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// () async {
                      //   if (_formkey.currentState!.validate()) {
                      //     _formkey.currentState!.save();
                      //     // Navigator.pushReplacementNamed(context, '/login');

                      //     try {
                      //       await authService.signInWithEmail(
                      //           _emailController.text,
                      //           _passwordController.text);
                      //       Navigator.of(context)
                      //           .push(MaterialPageRoute(builder: (builder) {
                      //         return LoginScreen();
                      //       }));
                      //     } catch (e) {
                      //       print(e);
                      //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //         content: Text('Failed to login: $e'),
                      //       ));
                      //     }
                      //   }
                      // };