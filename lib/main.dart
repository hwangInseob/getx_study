import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => Text(
              controller.count.toString(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.increment();
            },
            child: Text("+"),
          ),
        ],
      )),
    );
  }
}

class HomeController extends GetxController {
  final count = 0.obs;

  increment() {
    count.value++;
  }
}
