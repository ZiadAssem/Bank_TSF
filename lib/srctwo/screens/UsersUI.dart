import 'package:flutter/material.dart';
import '../../Database/sampledb.dart';
import '../User.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final database = DatabaseHelper.instance;
  int counter = 10;
  List users = [];

  List<Widget> userTiles = [];
  Future<int?> getUserCount() async {
    Future<int?> userCount = (await database.queryRowCount()) as Future<int?>;

    return userCount;
  }

  getAllUsers() async {
    users = await database.queryAllRows();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          if (counter < users.length - 4) {
            setState(
              () {
                counter += 5;
              },
            );
          } else {
            int increment = users.length - counter;
            setState(
              () {
                counter += increment;
              },
            );
          }
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getAllUsers(),
              builder: (context, snapshot) {
                if (users.length < 10) {
                  counter = users.length;
                } else {
                  counter = 10;
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: counter,
                    itemBuilder: (context, index) {
                      int userBalance = User.fromMap(users[index]).balance;
                      int userId = index + 1;
                      return UserTile(userId, userBalance, index);
                    },
                  );
                }
                return _progress();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget UserTile(userId, userBalance, index) {
    return Card(
      elevation: 15,
      semanticContainer: true,
      child: ListTile(
        title: Text(
          User.fromMap(users[index]).name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/images/userPic.jpg'),
        ),
        trailing: const Icon(Icons.account_balance),
        subtitle: Text(
          "ID: $userId                Balance = $userBalance",
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _progress() {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
