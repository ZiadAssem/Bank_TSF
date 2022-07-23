import 'package:flutter/material.dart';
import '../../Database/sampledb.dart';
import '../../mixins/validation_mixins.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TransferScreenState();
  }
}

class TransferScreenState extends State<TransferScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  int fromId = 0;
  int toId = 0;
  int amount = 0;
  bool valid = false;
  final database = DatabaseHelper.instance;

  @override
  Widget build(context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              senderIdField(),
              receiverIdField(),
              amountField(),
              Container(margin: const EdgeInsets.only(top: 190.0)),
              validationMessage(valid),
              Container(margin: const EdgeInsets.only(top: 20.0)),
              Align(
                alignment: Alignment.bottomCenter,
                child: submitButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget senderIdField() {
    return TextFormField(
      onSaved: (String? value) {
        fromId = int.parse(value!);
      },
      keyboardType: TextInputType.number,
      validator: validateID,
      decoration: const InputDecoration(
        labelText: 'Enter sender id',
        hintText: 'Integer greater than 0',
      ),
    );
  }

  Widget receiverIdField() {
    return TextFormField(
      onSaved: (String? value) {
        toId = int.parse(value!);
      },
      keyboardType: TextInputType.number,
      validator: validateID,
      decoration: const InputDecoration(
        labelText: 'Enter receiver id',
        hintText: 'Integer greater than 0',
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
          database.updateBalance(fromId, -amount);
          database.updateBalance(toId, amount);
          setState(() {
            valid = true;
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
        'Amount transferred successfully',
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
