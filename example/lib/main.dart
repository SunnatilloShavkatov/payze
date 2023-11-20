import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:payze/payze.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _payzePlugin = Payze();

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> pay() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _payzePlugin.pay(
            card: PayCard(
              cardNumber: '4111111111111111',
              cardHolderName: 'John Doe',
              cvv: '123',
              expiryDate: '12/27',
              transactionId: '1234567890',
            ),
          ) ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: ElevatedButton(
            onPressed: pay,
            child: Text('Running on: $_platformVersion\n'),
          ),
        ),
      ),
    );
  }
}
