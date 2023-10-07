import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blog_app/api/strapiAPI.dart';
import 'package:blog_app/model/blog.dart';
import 'package:blog_app/provider/blog_provider.dart';
import 'package:blog_app/widgets/common/common_snackbar.dart';
import 'package:blog_app/widgets/common/custom_loader.dart';
import 'package:blog_app/widgets/common/cutom_input_field_widget.dart';

class BlogForm extends StatefulWidget {
  // Receive blog data when we want to
  // update blog otherwise it will be null
  BlogModel? blog;

  BlogForm({super.key, this.blog});

  @override
  State<BlogForm> createState() => _BlogFormState();
}

class _BlogFormState extends State<BlogForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();

    // if we receive blog data then display it in Form
    if (widget.blog != null) {
      _titleController.text = widget.blog!.title!;
      _descriptionController.text = widget.blog!.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(199, 198, 229, 255),
        title: const Text(
          "Write Blog",
          style: TextStyle(
            fontSize: 24,
            color: Color.fromARGB(223, 41, 88, 127),
          ),
        ),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 163, 213, 254),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              setState(() {
                                loading = true;
                              });
                              BlogModel blogData = BlogModel(
                                title: _titleController.text,
                                description: _descriptionController.text,
                              );
                              String responseMsg = "";

                              // if we receive blog data then we must update it
                              // otherwise add it
                              if (widget.blog != null) {
                                responseMsg = await updateBlog(
                                    widget.blog!.id!, blogData);
                              } else {
                                responseMsg = await addBlog(blogData);
                              }

                              _titleController.clear();
                              _descriptionController.clear();
                              Provider.of<BlogUpdateModel>(context,
                                      listen: false)
                                  .notify();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  CommonSnackBar.buildSnackBar(
                                      context, responseMsg, "success"));
                              Navigator.of(context).pop();
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
                        child: const Text(
                          "Publish",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(223, 41, 88, 127),
                          ),
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
