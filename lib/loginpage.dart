import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'currency_converter.dart'; 
import 'signuppage.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _errorMessage = '';

  // void _login() {
  //   if (_formKey.currentState!.validate()) {
  //     // Perform login logic here (e.g., API call, authentication)
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => CurrencyConverter()),
  //     );
  //     // Clear the text fields after successful login
  //     _emailController.clear();
  //     _usernameController.clear();
  //     _passwordController.clear();
  //   }
  // }

   Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CurrencyConverter()),
        );
                _emailController.clear();
               _passwordController.clear();

      } on FirebaseAuthException catch (e) {
        setState(() {
          if (e.code == 'user-not-found') {
            _errorMessage = 'No user found for that email.';
          } else if (e.code == 'wrong-password') {
            _errorMessage = 'Wrong password provided.';
          } else {
            _errorMessage = 'An error occurred. Please try again.';
          }
                      print(_errorMessage);

        });
      } catch (e) {
        setState(() {
          _errorMessage = 'An error occurred. Please try again.';
        });
      }
    }
  }


  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 207, 245, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 49, 65, 243),
        title: Text('Login'),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(56.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(255, 255, 255, 1),
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(255, 255, 255, 1),
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 8) {
                    return 'Password should have a minimum of 8 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 49, 65, 243),
                  foregroundColor: Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                        _navigateToSignUp();
                        _emailController.clear();
                        _usernameController.clear();
                        _passwordController.clear();

                },
                child: Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(color: Color.fromARGB(255, 49, 65, 243)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
