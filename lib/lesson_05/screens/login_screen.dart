import 'package:flutter/material.dart';
import 'package:flutter_with_bay/lesson_05/widgets_1/text_form_field_widget.dart';
import 'package:flutter_with_bay/lesson_05/core/app_images.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormFieldWidget_My(
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Please Enter Email";
                  } else if (!value.contains("@")) {
                    return "Please Enter Valid Email";
                  }
                  return null;
                },
                labelText: "Email",
                hintText: "Enter Your Email",
                prefixIcon: Icons.email_outlined,
              ),
              const SizedBox(height: 20),
              TextFormFieldWidget_My(
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Please Enter Password";
                  } else if (value.length < 6) {
                    return "Password cant be less than 6";
                  }
                  return null;
                },
                obscureText: _isObscure,
                labelText: "Password",
                hintText: "Enter Your Password",
                prefixIcon: Icons.lock,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: Icon(_isObscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                child: const Text("Login"),
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(logo),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(child: Text("Logo")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
