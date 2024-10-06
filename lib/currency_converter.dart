import 'loginpage.dart'; 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:string_validator/string_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'INR';
  double _result = 0.0;

  

  // Future<void> _convertCurrency() async {
  //   final response = await http.get(Uri.parse(
  //        'https://djunicode-flutter-task.onrender.com/convert'));

  //   if (response.statusCode == 200) {
  //     var data = json.decode(response.body);
  //     double rate = data['rates'][_toCurrency];
  //     setState(() {
  //       _result = rate * double.parse(_amountController.text);
  //     });
  //   } else {
  //     throw Exception('Failed to load exchange rate');
  //   }
  // }

   Future<void> _convertCurrency() async {
    final response = await http.post(
      Uri.parse('https://djunicode-flutter-task.onrender.com/convert'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'from': _fromCurrency,
        'to': _toCurrency,
        'amount': double.parse(_amountController.text),
      }),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        _result = data['convertedAmount'];
        // print(_result);
      });
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }


  //   void _logout() {
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => LoginPage()),
  //   );
  // }

   void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        leading: TextButton(
          child: Text('Sign Out',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
          onPressed: _logout,
          // onPressed: _navigateToLogin,

          
        ),
        backgroundColor: Color.fromARGB(255, 49, 65, 243),
        title: Text('Currency Converter'),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white),
        leadingWidth: 80,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
                    color: Color.fromARGB(255, 49, 65, 243),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 50, right: 50, top: 10, bottom: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            _result == 0.0 ? '' : '${_result.toStringAsFixed(2)} $_toCurrency',
                            
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'From',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  margin: EdgeInsets.only(top: 4, bottom: 38),
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white,
                                  ),
                                  child: DropdownButton<String>(
                                    value: _fromCurrency,
                                    style: TextStyle(color: Colors.black),
                                    underline: Container(),
                                    isExpanded: true,
                                    iconEnabledColor: Colors.black,
                                    onChanged: (value) {
                                      setState(() {
                                        _fromCurrency = value!;
                                      });
                                    },
                                    items: ["EUR", "USD", "INR", "JPY", "GBP", "AUD", "CAD", "CHF", "CNY", "SGD"]
                                        .map((String currency) {
                                      return DropdownMenuItem<String>(
                                        value: currency,
                                        child: Text(currency),
                                      );
                                    }).toList(),
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'To',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  margin: EdgeInsets.only(top: 4, bottom: 38),
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white,
                                  ),
                                  child: DropdownButton<String>(
                                    value: _toCurrency,
                                    style: TextStyle(color: Colors.black),
                                    underline: Container(),
                                    isExpanded: true,
                                    iconEnabledColor: Colors.black,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _toCurrency = newValue!;
                                      });
                                    },
                                    items: ["EUR", "USD", "INR", "JPY", "GBP", "AUD", "CAD", "CHF", "CNY", "SGD"]
                                        .map((String currency) {
                                      return DropdownMenuItem<String>(
                                        value: currency,
                                        child: Text(currency),
                                      );
                                    }).toList(),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            controller: _amountController,
                            expands: false,
                            decoration: InputDecoration(
                              filled: true,
                              labelText: 'Enter Amount',
                              labelStyle: TextStyle(color: Colors.black54),
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                color: Colors.blue,
                                icon: Icon(Icons.arrow_forward),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _convertCurrency();
                                  }
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an amount';
                              }
                              else if(value.isNumeric==false)
                              {
                                return'Please enter a number';
                              }
                              else
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            onEditingComplete: () {
                             _convertCurrency();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 30,right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                  'Exchange Rates',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _buildExchangeRateCard('USD/INR', '83.48', '+0.16'),
                      _buildExchangeRateCard('USD/EUR', '0.87', '-0.16'),
                      _buildExchangeRateCard('USD/INR', '83.48', ''),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Latest Finance News',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                _buildFinanceNewsCard(
                    'Pound To Dollar Rate Holds 1.28 On Labour Political Stability','images/money.jpeg'),
                _buildFinanceNewsCard(
                    'Rupee closes flat, logs weekly decline; US jobs data in focus','images/money2.jpeg'),
                _buildFinanceNewsCard(
                    'USD/INR strengthens ahead of US NFP data','images/rupee.jpeg'),


                    ],),
                    ),
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExchangeRateCard(String pair, String rate, String change) {
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10),
      width: 120,
      height: 88,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromRGBO(240, 240, 240, 0.605),
),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(pair),
            Text(
              rate,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (change.isNotEmpty)
              Text(
                change,
                style: TextStyle(
                  color: change.startsWith('-') ? Colors.red : Colors.green,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinanceNewsCard(String news,String path) {
    return Padding(padding: EdgeInsets.all(5),
    child: Container(
      height: 120,
      width: 400,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),color: Color.fromARGB(255, 233, 233, 233)
                  ),

      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(8)
      // ),
      child: Row(children:[Expanded(flex: 1,
        child: Container(
                          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(18),color: Colors.black),
                          child: Image.asset(path,
                          width: 90,
                          height: 90,),)),
        Expanded(flex: 1,
          child:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(news),
      )),
    ])));

        // return 
          
        //       Container(
        //         height: 156,
                
        //       margin: EdgeInsets.all(20),
        //             decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(8),color: Color.fromARGB(255, 185, 185, 185)
        //           ),
        //       child: 
        //       Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: [          
        //             // Image.asset(path,
        //             //       width: 50,
        //             //       height: 50,),
        //                   FittedBox(
        //                     fit: BoxFit.contain,
        //            child:  Text(news,softWrap: true,overflow:TextOverflow.ellipsis,)),

        //         ],
        //         )
        //       ),
        //     );

  }
}
