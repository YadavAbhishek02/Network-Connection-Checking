import 'package:flutter/material.dart';
import '../Utils/ConnectivityUtil.dart';
import 'NetworkingCheck.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  late ConnectivityUtil _connectivityUtil;
  bool _loading = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      _connectivityUtil = ConnectivityUtil();
      _connectivityUtil.internetStatusStream.listen((isConnected) {
        if (isConnected) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const NetworkingCheck()),
          );
        }
      });
    });
  }
  void _onTryAgainPressed() {
    setState(() {
      _loading = true;
    });

    // Simulate an asynchronous operation (e.g., network request)
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _loading = false;
      });

      // Navigate or perform further actions after completing the operation
      // For now, we'll just print a message
      print("Try Again completed!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width*1,
            decoration:const  BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/image/no internet connection 1.png"),
              fit: BoxFit.cover),
              )
            ),

          Container(
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width*1,
            decoration: const BoxDecoration(
              color: Colors.transparent,
             image: DecorationImage(
                 image: AssetImage("assets/image/Rectangle 18973.png"),
               fit: BoxFit.fill,
            ),
            ),
            child: Padding(
                  padding: const EdgeInsets.only(bottom: 30,top: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        child: Column(
                          children: [
                            Center(
                              child: Text("No Internet Connection",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,)),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(30,10,30,10),
                              child: Center(
                                child:  Text(
                                    "Oops! Looks like your internet connection is not working properly. Please try again.",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width*0.8,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF76654C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed: _loading ? null : _onTryAgainPressed,
                          child:_loading
                              ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                              : const Text("Try Again", style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          ),
        ],
      ),
    );
  }
}



