import 'package:flutter/material.dart';
import 'package:prueba/utils/images.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.loginWallpaper),
              fit: BoxFit.cover,
            ),
          ),
          child: _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Spacer(),
          _form(myFormKey, usernameController, passwordController, context),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          )
        ],
      ),
    );
  }

  Widget _form(
      GlobalKey<FormState> myFormKey,
      TextEditingController usernameController,
      TextEditingController passwordController,
      BuildContext context) {
    return Form(
      key: myFormKey,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              controller: usernameController,
              // enableSuggestions: false,
              style: const TextStyle(
                color: Colors.cyan,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field is required';
                } else if (value.length < 3) {
                  return 'Username must be at least 3 characters';
                }
                return null;
              },
              cursorColor: Colors.cyan,
              // textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: Colors.cyan),
                hintText: 'Enter your username',
                hintStyle: TextStyle(color: Colors.cyan, fontSize: 14),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              // enableSuggestions: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
              style: const TextStyle(
                color: Colors.cyan,
              ),
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.cyan),
                hintText: 'Enter your password',
                hintStyle: TextStyle(color: Colors.cyan, fontSize: 14),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
              ),
            ),
          ),
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.cyan),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: () {
              if (!myFormKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill all the fields'),
                    dismissDirection: DismissDirection.vertical,
                  ),
                );
                return;
              }
              Navigator.pushReplacementNamed(context, '/home',
                  arguments: usernameController.text);
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
