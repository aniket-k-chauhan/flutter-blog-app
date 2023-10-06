import 'package:blog_app/api/firestoreAPI.dart';
import 'package:blog_app/model/user.dart';
import 'package:blog_app/widgets/common/common_snackbar.dart';
import 'package:blog_app/widgets/common/custom_loader.dart';
import 'package:blog_app/widgets/common/cutom_input_field_widget.dart';
import 'package:blog_app/widgets/portfolio/cutom_portfolio_details_form_section.dart';
import 'package:flutter/material.dart';

class PortfolioDetailsArgumets {
  final String email;
  final bool isReadOnly;

  PortfolioDetailsArgumets(this.email, {this.isReadOnly = false});
}

class PortfolioDetails extends StatelessWidget {
  final String email;
  final bool isReadOnly;
  const PortfolioDetails(
      {super.key, required this.email, required this.isReadOnly});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Portfolio"),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          child: _PortfolioDetailsForm(
            email: email,
            isReadOnly: isReadOnly,
          ),
        ),
      ),
    );
  }
}

class _PortfolioDetailsForm extends StatefulWidget {
  final String email;
  final bool isReadOnly;

  const _PortfolioDetailsForm({required this.email, required this.isReadOnly});

  @override
  State<_PortfolioDetailsForm> createState() => _PortfolioDetailsFormState();
}

class _PortfolioDetailsFormState extends State<_PortfolioDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: getUserDetailsByEmail(widget.email),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserModel user = snapshot.data!;
          _nameController = TextEditingController(text: user.name);
          _emailController = TextEditingController(text: user.email);

          return Form(
            key: _formKey,
            child: Column(
              children: [
                CustomInputFieldWidget(
                  labelText: "Name",
                  controller: _nameController,
                  readOnly: widget.isReadOnly,
                ),
                CustomInputFieldWidget(
                  labelText: "Email",
                  controller: _emailController,
                  readOnly: true,
                ),
                CustomPortfolioDetailsFormSection(
                  sectionValueList: user.projects,
                  user: user,
                  sectionName: "projects",
                  isReadOnly: widget.isReadOnly,
                ),
                CustomPortfolioDetailsFormSection(
                  sectionValueList: user.skills,
                  user: user,
                  sectionName: "skills",
                  isReadOnly: widget.isReadOnly,
                ),
                CustomPortfolioDetailsFormSection(
                  sectionValueList: user.achievements,
                  user: user,
                  sectionName: "achievements",
                  isReadOnly: widget.isReadOnly,
                ),
                if (!widget.isReadOnly)
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
                                  await updateUser(user, user.email!);
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
                              "Save",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
              CommonSnackBar.buildSnackBar(context, snapshot.error.toString()));
        }
        return Center(
          child: CustomLoader(),
        );
      },
    );
  }
}
