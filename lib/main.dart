import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /** (1) GetMaterialApp 적용
    *  Statement Management 나 dependency Management만 쓸거면 그냥 MaterialApp 써도 됨
    *  기본 MaterialApp을 child로 가지는 pre-configured 위젯임
    */
    return GetMaterialApp(
      home: Home(),
    );
  }
}

/**
 * (2) Business Logic을 담당하는 클래스 생성
 * - GetxController를 extends 한다.
 * - ".obs"로 모든 객체를 관찰하도록 할 수 있음
 *
 */
class Controller extends GetxController {
  var count = 0.obs;
  increase() => count++;
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    /**
     * (3) Get.put()으로 instanciate
     * (4) Controller를 통해 변수,함수를 사용 할 수 있다.
     */
    final Controller c = Get.put(Controller());

    return Scaffold(
      appBar: AppBar(
        // Obx(() => Widget) 으로 쓰이는 obs 변수가 바뀔때마다 업데이트된다.
        title: Obx(
          () => Text("${c.count}"),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Go to Other"),
          onPressed: () => Get.to(Other()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => c.increase(),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class Other extends StatelessWidget {
  const Other({super.key});

  @override
  Widget build(BuildContext context) {
    /**
     * (5) 다른 페이지에서 사용중인 컨트롤러도 Get.find()로 찾아서 사용 가능하다.
     */
    final Controller c = Get.find();
    return Scaffold(
      body: Center(
        child: Text("${c.count}"),
      ),
    );
  }
}
