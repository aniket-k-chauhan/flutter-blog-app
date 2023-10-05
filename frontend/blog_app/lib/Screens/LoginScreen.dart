import "package:blog_app/auth/auth.dart";
import "package:blog_app/widgets/common/common_snackbar.dart";
import "package:blog_app/widgets/common/custom_loader.dart";
import "package:blog_app/widgets/common/cutom_input_field_widget.dart";
import "package:flutter/material.dart";

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              _LoginForm(),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New user?",
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("/register");
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({super.key});

  @override
  State<_LoginForm> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomInputFieldWidget(
            labelText: "Email",
            obscureText: false,
            controller: emailController,
            maxLine: 1,
          ),
          CustomInputFieldWidget(
            labelText: "Password",
            obscureText: true,
            controller: pwdController,
            maxLine: 1,
          ),
          loading
              ? CustomLoader()
              : Container(
                  width: MediaQuery.of(context).size.width - 90,
                  height: 45,
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          setState(() {
                            loading = true;
                          });
                          // login
                          await Auth.login(
                              emailController.text, pwdController.text);

                          // navigate to home page
                          Navigator.of(context).pushReplacementNamed("/home");
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              CommonSnackBar.buildSnackBar(
                                  context, error.toString()));
                        } finally {
                          setState(() {
                            loading = false;
                          });
                        }
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
