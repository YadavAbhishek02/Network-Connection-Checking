import 'package:flutter/material.dart';
import '../Utils/ConnectivityUtil.dart';
import 'NoInternetViewController.dart';

class NetworkingCheck extends StatefulWidget {
  const NetworkingCheck({Key? key}) : super(key: key);

  @override
  State<NetworkingCheck> createState() => _NetworkingCheckState();
}

class _NetworkingCheckState extends State<NetworkingCheck> {
  late ConnectivityUtil _connectivityUtil;
  @override
  void initState() {
    super.initState();

    setState(() {
      _connectivityUtil = ConnectivityUtil();
      _connectivityUtil.internetStatusStream.listen((isConnected) {
        if (!isConnected) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const NoInternet()),
          );
        }
      });
    });

  }

  @override
  void dispose() {
    _connectivityUtil.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Networking'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: const Center(
          child: Text(
            'This is Home Page',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
