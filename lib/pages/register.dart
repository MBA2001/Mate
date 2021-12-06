import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/textfield.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _validate = false;
  bool _validateName = false;
  bool _validatePassword = false;
  bool _validateConfirmPass = false;
  String _passwordMessage = '';
  String emailMessage = '';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final ConfirmPassController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _signUpValidation(authService) async {
    if (passwordController.text.trim() == '' ||
        ConfirmPassController.text.trim() == '' ||
        usernameController.text.trim() == '' ||
        emailController.text.trim() == '') {
      setState(() {
        _passwordMessage = 'A field or more is empty, All fields are required';
        _validateConfirmPass = true;
        _validate = false;
        _validatePassword = false;
        _validateName = false;
      });
      return;
    } else if (passwordController.text != ConfirmPassController.text) {
      setState(() {
        _passwordMessage = 'confirm password must match password';
        _validateConfirmPass = true;
        _validate = false;
        _validatePassword = false;
        _validateName = false;
      });
      return;
    }
    try {
      QuerySnapshot<Map<String, dynamic>> database =
          await FirebaseFirestore.instance.collection('users').get();
      List<Map<String, dynamic>> data =
          database.docs.map((doc) => doc.data()).toList();
      for (var item in data) {
        if (item['username'] == usernameController.text) {
          setState(() {
            _validateName = true;
            _validateConfirmPass = false;
            _validate = false;
            _validatePassword = false;
          });
          return;
        }
      }
    } catch (e) {
      print(e);
      return;
    }
    setState(() {
      _validateConfirmPass = false;
    });

    try {
      await authService.createUserWithEmailAndPassword(emailController.text,
          passwordController.text, usernameController.text);
      Navigator.pop(context);
    } catch (e) {
      if (e.toString().contains('email address is already in use')) {
        setState(() {
          emailMessage = 'Email address is already in use';
          _validate = true;
          _validatePassword = false;
          _validateConfirmPass = false;
          _validateName = false;
        });
      } else if (e
          .toString()
          .contains('The email address is badly formatted')) {
        setState(() {
          emailMessage = 'Email address is badly formatted';
          _validate = true;
          _validatePassword = false;
          _validateConfirmPass = false;
          _validateName = false;
        });
      } else if (e
          .toString()
          .contains('Password should be at least 6 characters')) {
        setState(() {
          _validatePassword = true;
          _validate = false;
          _validateConfirmPass = false;
          _validateName = false;
        });
      }
    }
  }

  //TODO: Apply the functionallity to add the username to the user, check if passwords match

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (!keyboardOpen)
            Image.asset(
              'assets/mate.png',
              scale: 3,
            ),
          SizedBox(
            height: 10,
          ),
          SimpleTextField(
            Controller: usernameController,
            hintText: 'Username',
            errorText: _validateName ? 'Username already in use' : null,
            obscure: false,
          ),
          SimpleTextField(
            Controller: emailController,
            errorText: _validate ? emailMessage : null,
            hintText: 'Email',
            obscure: false,
          ),
          SimpleTextField(
            Controller: passwordController,
            errorText: _validatePassword
                ? 'Password should be at least 6 characters'
                : null,
            hintText: 'Password',
            obscure: true,
          ),
          SimpleTextField(
            Controller: ConfirmPassController,
            errorText: _validateConfirmPass ? _passwordMessage : null,
            hintText: 'Confirm Password',
            obscure: true,
          ),
          ElevatedButton.icon(
              onPressed: () async => (await _signUpValidation(authService)),
              icon: const Icon(Icons.app_registration),
              label: const Text('Register')),
        ],
      ),
    );
  }
}
