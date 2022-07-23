import 'package:bank_tsf/Database/sampledb.dart';
import 'package:bank_tsf/mixins/validation_mixins.dart';
import 'package:flutter/material.dart';
import '../User.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  final database = DatabaseHelper.instance;
  late String name;
  int amount = 0;
  bool valid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              nameField(),
              amountField(),
              Container(margin: const EdgeInsets.only(top: 250.0)),
              validationMessage(valid),
              Container(margin: const EdgeInsets.only(top: 20.0)),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget nameField() {
    return TextFormField(
      onSaved: (String? value) {
        name = value!;
      },
      validator: validateName,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Enter Name',
        hintText: 'John Doe',
      ),
    );
  }

  Widget amountField() {
    return TextFormField(
      onSaved: (String? value) {
        amount = int.parse(value!);
      },
      validator: validateBalance,
      decoration: const InputDecoration(
        labelText: 'Enter amount',
        hintText: 'e.g 1000',
      ),
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(15),
        shadowColor: MaterialStateProperty.all(Colors.blue),
        minimumSize: MaterialStateProperty.all(const Size(0, 40)),
      ),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState?.save();
          setState(() {
            valid = true;
            User a = User(name, amount);
            database.insert(a);
          });
        } else {
          setState(() {
            valid = false;
          });
        }
      },
      child: const Text(
        'submit',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget validationMessage(bool valid) {
    if (valid) {
      return const Text(
        'User created successfully',
        style: TextStyle(
          color: Colors.green,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    return const Text('');
  }
}
