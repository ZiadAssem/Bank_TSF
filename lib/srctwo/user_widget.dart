import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  String name = '';
  int balance = 0;
  int id = 0;

  UserItem(this.id, this.name, this.balance);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 5,
          color: Colors.blueGrey,
        ),
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 20.0,
          color: Colors.blueAccent,
        ),
        child: Column(
          children: [
            Text('User is $name'),
            Row(
              children: [
                Expanded(
                  child: Text('id  $id'),
                ),
                Expanded(child: Text('balance = $balance')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
