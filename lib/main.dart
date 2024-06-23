import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 32.0),
        ),
      ),
      routingCallback: (value) {
        debugPrint(value.toString());
      },
      home: Home(),
      getPages: [GetPage(name: '/params/:pathValue', page: () => ParamsPage())],
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Controller());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("홈 페이지 !"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Get.to(() => NextPage());
              },
              child: Text("Get.to(NextPage())"),
            ),
            TextButton(
              onPressed: () {
                Get.off(() => NextPage());
              },
              child: Text("Get.off(NextPage())"),
            ),
            TextButton(
              onPressed: () {
                Get.snackbar("this is SnackBar Title", "this is Message");
              },
              child: Text("Get.snackbar()"),
            ),
            TextButton(
              onPressed: () {
                Get.rawSnackbar(
                    title: "this is SnackBar Title",
                    message: "this is Message");
              },
              child: Text("Get.rawSnackbar()"),
            ),
            TextButton(
              onPressed: () {
                Get.dialog(MyDialog());
              },
              child: Text("Get.dialog(MyDialog())"),
            ),
            TextButton(
              onPressed: () {
                Get.defaultDialog(title: "title");
              },
              child: Text("Get.defaultDialog()"),
            ),
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("This is NextPage()"),
            Obx(
              () {
                if (Get.find<Controller>().routeReturnValue.value.isNotEmpty) {
                  return Text(
                      Get.find<Controller>().routeReturnValue.value["key"]);
                } else {
                  return Text("go to.ThirdPage and back!");
                }
              },
            ),
            ElevatedButton(
              onPressed: () async {
                Get.find<Controller>().routeReturnValue.value =
                    await Get.to(ThirdPage(), arguments: "arg1");
                debugPrint(
                    Get.find<Controller>().routeReturnValue.value.toString());
              },
              child: Text("Get.to(ThirdPage(), arguments: \"arg1\")"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.off(ThirdPage());
              },
              child: Text("Get.off(ThirdPage())"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.offAll(ThirdPage());
              },
              child: Text("Get.offAll(ThirdPage())"),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed("/params/test", parameters: {"param": "123"});
              },
              child: Text("Get.toNamed(\"/path/test\")"),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("This is ThirdPage"),
          if (Get.arguments != null) Text(Get.arguments),
          ElevatedButton(
            onPressed: () {
              Get.back<Map<String, dynamic>>(result: {"key": "Good"});
            },
            child: Text("Get.back(result)"),
          ),
        ],
      ),
    );
  }
}

class ParamsPage extends StatelessWidget {
  const ParamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(Get.parameters["pathValue"]!),
            if (Get.parameters["param"] != null) Text(Get.parameters["param"]!),
          ],
        ),
      ),
    );
  }
}

class MyDialog extends StatelessWidget {
  const MyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 50,
        color: Colors.black,
      ),
    );
  }
}

class Controller extends GetxController {
  final routeReturnValue = {}.obs;
}
