import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetMaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /**
             * (1) GetBuilder<Controller클래스> (
             *   builder: (_) =>
             * )
             *
             * 원래 Controller가 처음으로 쓰일때는 처음으로 쓰이는 GetBuilder에 init: Controller() 파라미터를 넣어야하지만
             * 그다음 GetBuilder부터는 init을 하면 안되는 등 불편해서
             * Get.put(Controller())로 미리 초기화 해놓고 쓰는게 편할듯
             * */
            GetBuilder<HomeController>(
              builder: (controller) => Text("${controller.count.value}"),
            ),
            ElevatedButton(
                onPressed: () {
                  controller.increment();
                },
                child: Text("+"))
          ],
        ),
      ),
    );
  }
}

class HomeController extends GetxController {
  final count = 0.obs;

  increment() {
    count.value++;
    update();
  }
}
