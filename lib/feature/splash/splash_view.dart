
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      context.push("/bottom");
    });
    
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor:
          const Color.fromARGB(255,20,190,190),
      body: Center(child: Padding(
        padding: EdgeInsets.only(left: 50.w),
        child: SizedBox(child: Image.asset('assets/png/splash.png')),
      )),
    );
  }
}

//sp texte göre boyutlandırma 
// w h paddinge göre.
// r 