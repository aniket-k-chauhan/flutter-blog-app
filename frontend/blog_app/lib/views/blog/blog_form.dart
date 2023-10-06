import 'package:blog_app/api/strapiAPI.dart';
import 'package:blog_app/auth/auth.dart';
import 'package:blog_app/model/blog.dart';
import 'package:blog_app/widgets/common/common_snackbar.dart';
import 'package:blog_app/widgets/common/custom_loader.dart';
import 'package:blog_app/widgets/common/cutom_input_field_widget.dart';
import 'package:flutter/material.dart';

class BlogForm extends StatefulWidget {
  @override
  State<BlogForm> createState() => _BlogFormState();
}

class _BlogFormState extends State<BlogForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Write Blog"),
      ),
      body: SingleChildScrollView(
          child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomInputFieldWidget(
                labelText: "Title",
                controller: _titleController,
              ),
              CustomInputFieldWidget(
                labelText: "Description",
                controller: _descriptionController,
                maxLine: null,
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
                              BlogModel blogData = BlogModel(
                                title: _titleController.text,
                                description: _descriptionController.text,
                                author: Auth.getLoggedInUser()!.email,
                              );
                              await addBlog(blogData);
                              _titleController.clear();
                              _descriptionController.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  CommonSnackBar.buildSnackBar(
                                      context, "Blog Published Successfully"));
                              Navigator.of(context).pop();
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
                          "Publish",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      )),
    );
  }
}
