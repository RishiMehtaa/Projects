import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
import 'firebase_options.dart';

// import 'package:string_validator/string_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'currency_converter.dart'; 
import 'loginpage.dart'; // Import the LoginPage screen


// void main() {
//   runApp(MyApp());
// }


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      // home: CurrencyConverter(),

    );
  }
}

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _usernameController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // void _login() {
//   //   if (_formKey.currentState!.validate()) {
//   //     // Perform login logic here (e.g., API call, authentication)
//   //     Navigator.pushReplacement(
//   //       context,
//   //       MaterialPageRoute(builder: (context) => CurrencyConverter()),
//   //     );
//   //     // Clear the text fields after successful login
//   //     _emailController.clear();
//   //     _usernameController.clear();
//   //     _passwordController.clear();
//   //   }
//   // }

//   void _login() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//           email: _emailController.text,
//           password: _passwordController.text,
//         );
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => CurrencyConverter()),
//         );
//         _emailController.clear();
//         _passwordController.clear();
//       } catch (e) {
//         print('Failed to sign in: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to sign in: $e')),
//         );
//       }
//     }
//   }

//   void _navigateToSignUp() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => SignUpPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 207, 245, 255),
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 49, 65, 243),
//         title: Text('Login'),
//         centerTitle: true,
//         titleTextStyle: TextStyle(color: Colors.white),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(56.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Color.fromRGBO(255, 255, 255, 1),
//                   labelText: 'Email',
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide.none,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                     return 'Please enter a valid email';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               // TextFormField(
//               //   controller: _usernameController,
//               //   decoration: InputDecoration(
//               //     filled: true,
//               //     fillColor: Color.fromRGBO(255, 255, 255, 1),
//               //     labelText: 'Username',
//               //     border: OutlineInputBorder(
//               //       borderSide: BorderSide.none,
//               //       borderRadius: BorderRadius.circular(16),
//               //     ),
//               //   ),
//               //   validator: (value) {
//               //     if (value == null || value.isEmpty) {
//               //       return 'Please enter your username';
//               //     }
//               //     return null;
//               //   },
//               // ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Color.fromRGBO(255, 255, 255, 1),
//                   labelText: 'Password',
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide.none,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   if (value.length < 8) {
//                     return 'Password should have a minimum of 8 characters';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _login,
//                 child: Text('Login'),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color.fromARGB(255, 49, 65, 243),
//                   foregroundColor: Color.fromARGB(255, 255, 255, 255),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),
//               TextButton(
//                 onPressed: () {
//                         _navigateToSignUp();
//                         _emailController.clear();
//                         _usernameController.clear();
//                         _passwordController.clear();

//                 },
//                 child: Text(
//                   'Don\'t have an account? Sign Up',
//                   style: TextStyle(color: Color.fromARGB(255, 49, 65, 243)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SignUpPage extends StatefulWidget {
//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _usernameController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _confirmPasswordController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // void _signUp() {
//   //   if (_formKey.currentState!.validate()) {
//   //     // Perform sign-up logic here (e.g., API call, registration)
//   //     Navigator.pop(context);  // Go back to the login page after successful sign-up
//   //   }
//   // }

//    void _signUp() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//           email: _emailController.text,
//           password: _passwordController.text,
//         );
//         Navigator.pop(context);
//       } catch (e) {
//         print('Failed to sign up: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to sign up: $e')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 207, 245, 255),
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 49, 65, 243),
//         title: Text('Sign Up'),
//         centerTitle: true,
//         titleTextStyle: TextStyle(color: Colors.white),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Color.fromRGBO(255, 255, 255, 1),
//                   labelText: 'Email',
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide.none,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                     return 'Please enter a valid email';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Color.fromRGBO(255, 255, 255, 1),
//                   labelText: 'Username',
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide.none,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your username';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Color.fromRGBO(255, 255, 255, 1),
//                   labelText: 'Password',
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide.none,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   if (value.length < 8) {
//                     return 'Password should have a minimum of 8 characters';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _confirmPasswordController,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Color.fromRGBO(255, 255, 255, 1),
//                   labelText: 'Confirm Password',
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide.none,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please confirm your password';
//                   }
//                   if (value != _passwordController.text) {
//                     return 'Passwords do not match';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _signUp,
//                 child: Text('Sign Up',),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color.fromARGB(255, 49, 65, 243),
//                   foregroundColor: Color.fromARGB(255, 255, 255, 255),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CurrencyConverter extends StatefulWidget {
//   @override
//   _CurrencyConverterState createState() => _CurrencyConverterState();
// }

// class _CurrencyConverterState extends State<CurrencyConverter> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _amountController = TextEditingController();
//   String _fromCurrency = 'USD';
//   String _toCurrency = 'INR';
//   double _result = 0.0;

  

//   // Future<void> _convertCurrency() async {
//   //   final response = await http.get(Uri.parse(
//   //       'https://api.exchangerate-api.com/v4/latest/$_fromCurrency'));
//   //       // 'https://djunicode-flutter-task.onrender.com/convert'));

//   //   if (response.statusCode == 200) {
//   //     var data = json.decode(response.body);
//   //     double rate = data['rates'][_toCurrency];
//   //     setState(() {
//   //       _result = rate * double.parse(_amountController.text);
//   //     });
//   //   } else {
//   //     throw Exception('Failed to load exchange rate');
//   //   }
//   // }

//    Future<void> _convertCurrency() async {
//     final response = await http.post(
//       Uri.parse('https://djunicode-flutter-task.onrender.com/convert'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'from': _fromCurrency,
//         'to': _toCurrency,
//         'amount': double.parse(_amountController.text),
//       }),
//     );

//     if (response.statusCode == 200) {
//       var data = json.decode(response.body);
//       setState(() {
//         _result = data['convertedAmount'];
//         // print(_result);
//       });
//     } else {
//       throw Exception('Failed to load exchange rate');
//     }
//   }


//   //   void _navigateToLogin() {
//   //   Navigator.pushReplacement(
//   //     context,
//   //     MaterialPageRoute(builder: (context) => LoginPage()),
//   //   );
//   // }

//    void _logout() async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => LoginPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//       appBar: AppBar(
//         leading: TextButton(
//           child: Text('Sign Out',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
//           onPressed: _logout,
//           // onPressed: _navigateToLogin,

          
//         ),
//         backgroundColor: Color.fromARGB(255, 49, 65, 243),
//         title: Text('Currency Converter'),
//         centerTitle: true,
//         titleTextStyle: TextStyle(color: Colors.white),
//         leadingWidth: 80,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(0.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(50),
//                         bottomRight: Radius.circular(50)),
//                     color: Color.fromARGB(255, 49, 65, 243),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 50, right: 50, top: 10, bottom: 50),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Center(
//                           child: Text(
//                             _result == 0.0 ? '' : '${_result.toStringAsFixed(2)} $_toCurrency',
                            
//                             style: TextStyle(
//                               fontSize: 32,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'From',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.symmetric(horizontal: 8),
//                                   margin: EdgeInsets.only(top: 4, bottom: 38),
//                                   width: 150,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(14),
//                                     color: Colors.white,
//                                   ),
//                                   child: DropdownButton<String>(
//                                     value: _fromCurrency,
//                                     style: TextStyle(color: Colors.black),
//                                     underline: Container(),
//                                     isExpanded: true,
//                                     iconEnabledColor: Colors.black,
//                                     onChanged: (value) {
//                                       setState(() {
//                                         _fromCurrency = value!;
//                                       });
//                                     },
//                                     items: ["EUR", "USD", "INR", "JPY", "GBP", "AUD", "CAD", "CHF", "CNY", "SGD"]
//                                         .map((String currency) {
//                                       return DropdownMenuItem<String>(
//                                         value: currency,
//                                         child: Text(currency),
//                                       );
//                                     }).toList(),
//                                     borderRadius: BorderRadius.all(Radius.circular(15)),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'To',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 Container(
//                                   padding: EdgeInsets.symmetric(horizontal: 8),
//                                   margin: EdgeInsets.only(top: 4, bottom: 38),
//                                   width: 150,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(14),
//                                     color: Colors.white,
//                                   ),
//                                   child: DropdownButton<String>(
//                                     value: _toCurrency,
//                                     style: TextStyle(color: Colors.black),
//                                     underline: Container(),
//                                     isExpanded: true,
//                                     iconEnabledColor: Colors.black,
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         _toCurrency = newValue!;
//                                       });
//                                     },
//                                     items: ["EUR", "USD", "INR", "JPY", "GBP", "AUD", "CAD", "CHF", "CNY", "SGD"]
//                                         .map((String currency) {
//                                       return DropdownMenuItem<String>(
//                                         value: currency,
//                                         child: Text(currency),
//                                       );
//                                     }).toList(),
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Container(
//                           padding: EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(25),
//                             color: Colors.white,
//                           ),
//                           child: TextFormField(
//                             controller: _amountController,
//                             expands: false,
//                             decoration: InputDecoration(
//                               filled: true,
//                               labelText: 'Enter Amount',
//                               labelStyle: TextStyle(color: Colors.black54),
//                               fillColor: Colors.white,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(16),
//                                 borderSide: BorderSide.none,
//                               ),
//                               suffixIcon: IconButton(
//                                 color: Colors.blue,
//                                 icon: Icon(Icons.arrow_forward),
//                                 onPressed: () {
//                                   if (_formKey.currentState!.validate()) {
//                                     _convertCurrency();
//                                   }
//                                 },
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter an amount';
//                               }
//                               else if(value.isNumeric==false)
//                               {
//                                 return'Please enter a number';
//                               }
//                               else
//                               return null;
//                             },
//                             keyboardType: TextInputType.number,
//                             onEditingComplete: () {
//                              _convertCurrency();
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Container(
//                   padding: EdgeInsets.only(left: 30,right: 30),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                   'Exchange Rates',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   physics: AlwaysScrollableScrollPhysics(),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       _buildExchangeRateCard('USD/INR', '83.48', '+0.16'),
//                       _buildExchangeRateCard('USD/EUR', '0.87', '-0.16'),
//                       _buildExchangeRateCard('USD/INR', '83.48', ''),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Latest Finance News',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 _buildFinanceNewsCard(
//                     'Pound To Dollar Rate Holds 1.28 On Labour Political Stability'),
//                 _buildFinanceNewsCard(
//                     'Rupee closes flat, logs weekly decline; US jobs data in focus'),
//                 _buildFinanceNewsCard(
//                     'USD/INR strengthens ahead of US NFP data'),


//                     ],
//                     ),
//                     )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildExchangeRateCard(String pair, String rate, String change) {
//     return Container(
//       // shape: RoundedRectangleBorder(
//       //   borderRadius: BorderRadius.circular(8),
//       // ),
//       margin: EdgeInsets.only(left: 10,right: 10),
//       width: 150,
//       height: 88,
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromRGBO(240, 240, 240, 0.605),
// ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Text(pair),
//             Text(
//               rate,
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             if (change.isNotEmpty)
//               Text(
//                 change,
//                 style: TextStyle(
//                   color: change.startsWith('-') ? Colors.red : Colors.green,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFinanceNewsCard(String news) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(news),
//       ),
//     );
//   }
// }
