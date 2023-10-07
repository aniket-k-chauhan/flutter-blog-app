import "package:flutter/material.dart";

import "package:blog_app/api/firestoreAPI.dart";
import "package:blog_app/auth/auth.dart";
import "package:blog_app/model/user.dart";
import "package:blog_app/widgets/common/common_snackbar.dart";
import "package:blog_app/widgets/common/custom_loader.dart";
import "package:blog_app/widgets/common/cutom_input_field_widget.dart";

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                "Register",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(223, 41, 88, 127),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              _RegisterForm(),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already a user?",
                    style: TextStyle(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("/login");
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(223, 41, 88, 127),
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

class _RegisterForm extends StatefulWidget {
  @override
  State<_RegisterForm> createState() {
    return _RegisterFormState();
  }
}

class _RegisterFormState extends State<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
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
            labelText: "Name",
            obscureText: false,
            controller: nameController,
            maxLine: 1,
          ),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 163, 213, 254),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          setState(() {
                            loading = true;
                          });
                          // register
                          final userCredential = await Auth.register(
                              emailController.text, pwdController.text);
                          final user = UserModel(
                            name: nameController.text,
                            email: userCredential.user!.email,
                          );

                          // add user
                          await addUser(user);

                          // navigate to home page
                          Navigator.of(context).pushReplacementNamed("/home");
                          ScaffoldMessenger.of(context).showSnackBar(
                              CommonSnackBar.buildSnackBar(context,
                                  "Successfully Registered", "success"));
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              CommonSnackBar.buildSnackBar(
                                  context, error.toString(), "error"));
                        } finally {
                          setState(() {
                            loading = false;
                          });
                        }
                      }
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(223, 41, 88, 127),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Container inputField(BuildContext context, String labelText, bool obscureText,
      TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter ${labelText.toLowerCase()}";
          }

          return null;
        },
        obscureText: obscureText,
        style: TextStyle(fontSize: 17),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 17,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.red[200]!,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.red[200]!,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
