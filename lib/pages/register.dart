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

  //TODO: Apply the functionallity to add the username to the user, check if passwords match

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom !=0 ;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Column(
        children: [
            if (!keyboardOpen) Image.asset('assets/mate.png',scale: 3,),
            SizedBox(height: 10,),
            SimpleTextField(
              Controller: usernameController, 
              hintText: 'Username',
              obscure: false,
            ),
            SimpleTextField(
              Controller: emailController, 
              errorText: _validate ? 'This email address' : null,
              hintText: 'Email',
              obscure: false,
            ),
            SimpleTextField(
              Controller: passwordController, 
              hintText: 'Password',
              obscure: true,
            ),
            SimpleTextField(
              Controller: ConfirmPassController, 
              hintText: 'Confirm Password',
              obscure: true,
            ),
          ElevatedButton.icon(
            onPressed: () async {
              try{
                await authService.createUserWithEmailAndPassword(emailController.text, passwordController.text);
                Navigator.pop(context);
              }catch(e){
                if(e.toString().contains('The email address is already in use.')){
                  setState(() {
                      _validate = true;
                    });
                }
              }
            },
            icon:const  Icon(Icons.app_registration), 
            label: const Text('Register')
          ),
        ],
      ),
    );
  }
}