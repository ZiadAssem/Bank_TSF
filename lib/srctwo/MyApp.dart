import 'package:flutter/material.dart';
import 'screens/TransferUI.dart';
import 'screens/UsersUI.dart';
import 'screens/AddUsersUI.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController _tcontroller;
  final List<String> titleList = ['Add User', 'Users Page', 'Transaction Page'];
  late String currentTitle;

  @override
  void initState() {
    currentTitle = titleList[0];
    _tcontroller = TabController(length: 3, vsync: this);
    _tcontroller.addListener(changeTitle);
    super.initState();
  }

  void changeTitle() {
    setState(() {
      currentTitle = titleList[_tcontroller.index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              currentTitle,
              style: const TextStyle(fontSize: 22),
            ),
            bottom: TabBar(
              tabs: const [
                Icon(Icons.add),
                Icon(Icons.accessibility_new_rounded),
                Icon(Icons.monetization_on_rounded),
              ],
              controller: _tcontroller,
              indicatorColor: Colors.white,
              unselectedLabelColor: Colors.white60,
            ),
          ),
          body: TabBarView(
            controller: _tcontroller,
            children: const [
              CreateUser(),
              UserPage(),
              TransferScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
