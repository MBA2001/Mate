import 'package:flutter/material.dart';

class Accountsettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Account settings'),
      ),
      body: customform(),
    );
  }
}

class customform extends StatefulWidget {
  const customform({Key? key}) : super(key: key);

  @override
  _customformState createState() => _customformState();
}

class _customformState extends State<customform> {
  final _formkey = GlobalKey<FormState>();
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final mycontroller3 = TextEditingController();

  @override
  void dispose() {
    myController1.dispose();
    myController2.dispose();
    mycontroller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          TextFormField(
            controller: myController1,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your username'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter text.';
              }

              return null;
            },
          ),
          TextFormField(
              controller: myController2,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your new number'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'enter number';
                }
              }),
          TextFormField(
              controller: mycontroller3,
              obscureText: true,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your new password'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'enter password';
                }
              }),
          ElevatedButton(
            onPressed: () {
              if (_formkey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
              print('user name : ${myController1.text}');
              print('Phone number : ${myController2.text}');
              print('password : ${mycontroller3.text}');
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
