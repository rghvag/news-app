import 'package:flutter/material.dart';
import 'package:newsapplication/services/auth_service.dart';
import 'package:newsapplication/views/signupScreen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print('signup screen');
    final authService = Provider.of<AuthService>(context);

    // print('signup screen');

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
                      if (_formkey.currentState!.validate()) {
                        try {
                          await authService.signInWithEmail(
                            _emailController.text,
                            _passwordController.text,
                          );
                          // Navigate to home or other page after successful login
                          Navigator.pushNamed(context, '/home');
                        } catch (e) {
            
                          if (e.toString() ==
                              '[firebase_auth/invalid-credential]') {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Wrong password or username}'),
                            ));
                          } else
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Error: ${e.toString()}'),
                            ));
                          // Handle login error
                          print('Login Error: ${e.toString()}');
                        }
                      }
                    },
                    child: Text('Login'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen()),
                          );
                        },
                        child: const Text(
                          'Signup',
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  )
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
//                         if (_formkey.currentState!.validate()) {
//                           _formkey.currentState!.save();

//                           //signin
//                           try {
//                             await authService.signInWithEmail(
//                                 _emailController.text,
//                                 _passwordController.text);
//                             Navigator.of(context)
//                                 .push(MaterialPageRoute(builder: (builder) {
//                               return HomeScreen();
//                             }));
//                           } catch (e) {
//                             print(e);
//                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                               content: Text('Failed to login: $e'),
//                             ));