import '../services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/textfield.dart';




class LogIn extends StatefulWidget {
  LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _validateEmail = false;
  bool _validatePass = false;
  String _validatePassText = '';



  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context);
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom !=0 ;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            if (!keyboardOpen) Image.asset('assets/mate.png',scale: 2,),
            const SizedBox(height: 40,),
            SimpleTextField(
              Controller: emailController, 
              errorText: _validateEmail ? 'Please enter a valid email' : null,
              hintText: 'email',
              obscure: false,
            ),
            SimpleTextField(
              Controller: passwordController, 
              errorText: _validatePass ? _validatePassText : null,
              hintText: 'password',
              obscure: true,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                //TODO: Check for the types of errors and show error texts based on the error
                try {
                  await authservice.signInWithEmailAndPassword(emailController.text, passwordController.text);
                } catch (e) {
                  print(e.toString());
                  _validateEmail = false;
                  _validatePass = false;
                  if(e.toString().contains('address is badly formatted')){
                    setState(() {
                      _validateEmail = true;
                    });
                  }else if(e.toString().contains('no user record corresponding to this identifier. The user may have been deleted') || e.toString().contains('The password is invalid')){
                    setState(() {
                      _validatePass = true;
                      _validatePassText = 'Wrong email or password';
                    });
                  }
                }
              },
              icon:const  Icon(Icons.login), 
              label: const Text('login')
            ),
            TextButton(
              onPressed: (){
                Navigator.pushNamed(context, '/register');
              }, 
              child: const Text('Register'),
            ),
      
          ],
        ),
      ),
    );
  }
}
