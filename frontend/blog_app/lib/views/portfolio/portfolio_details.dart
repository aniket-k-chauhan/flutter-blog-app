import 'dart:developer';

import 'package:blog_app/api/firestoreAPI.dart';
import 'package:blog_app/model/user.dart';
import 'package:blog_app/widgets/common/common_snackbar.dart';
import 'package:blog_app/widgets/common/custom_loader.dart';
import 'package:blog_app/widgets/common/cutom_input_field_widget.dart';
import 'package:flutter/material.dart';

class PortfolioDetails extends StatelessWidget {
  final String email;
  const PortfolioDetails({super.key, required this.email});

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
          ),
        ),
      ),
    );
  }
}

class _PortfolioDetailsForm extends StatefulWidget {
  final String email;

  const _PortfolioDetailsForm({required this.email});

  @override
  State<_PortfolioDetailsForm> createState() => _PortfolioDetailsFormState();
}

class _PortfolioDetailsFormState extends State<_PortfolioDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;

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
                ),
                CustomInputFieldWidget(
                  labelText: "Email",
                  controller: _emailController,
                  readOnly: true,
                ),
                CustomPortfolioDetailsFormSection(
                  projects: user.projects,
                  user: user,
                  sectionName: "project",
                ),
                CustomPortfolioDetailsFormSection(
                  projects: user.skills,
                  user: user,
                  sectionName: "skills",
                ),
                CustomPortfolioDetailsFormSection(
                  projects: user.achievements,
                  user: user,
                  sectionName: "achievements",
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 90,
                  height: 45,
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    onPressed: () async {
                      await updateUser(user, user.email!);
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                // Container(
                //   width: MediaQuery.of(context).size.width - 70,
                //   margin: const EdgeInsets.symmetric(vertical: 8),
                //   child: Column(
                //     children: [
                //       Row(
                //         children: [
                //           Expanded(
                //             child: Text(
                //               "Projects",
                //               style: TextStyle(
                //                 fontSize: 34,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           ),
                //           IconButton(
                //             onPressed: () {
                //               showModalBottomSheet(
                //                   context: context,
                //                   shape: RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.only(
                //                       topLeft: Radius.circular(10),
                //                       topRight: Radius.circular(10),
                //                     ),
                //                   ),
                //                   builder: (BuildContext context) {
                //                     return SizedBox(
                //                       height:
                //                           MediaQuery.of(context).size.height,
                //                       child: Form(
                //                         child: Column(
                //                           children: [
                //                             CustomInputFieldWidget(
                //                               labelText: "Project title",
                //                               controller:
                //                                   TextEditingController(),
                //                             ),
                //                             Container(
                //                               width: MediaQuery.of(context)
                //                                       .size
                //                                       .width -
                //                                   90,
                //                               height: 45,
                //                               margin:
                //                                   const EdgeInsets.symmetric(
                //                                       vertical: 16),
                //                               child: ElevatedButton(
                //                                 onPressed: () {
                //                                   user.projects != null
                //                                       ? user.projects!
                //                                           .add("value")
                //                                       : user.projects = [
                //                                           "value"
                //                                         ];
                //                                   log(user.projects.toString());
                //                                   setState(() {});
                //                                   Navigator.of(context).pop();
                //                                 },
                //                                 child: Text(
                //                                   "Add",
                //                                   style:
                //                                       TextStyle(fontSize: 20),
                //                                 ),
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                     );
                //                   });
                //             },
                //             iconSize: 34,
                //             icon: Icon(
                //               Icons.add,
                //             ),
                //           ),
                //         ],
                //       ),
                //       ListView.builder(
                //         shrinkWrap: true,
                //         itemCount: user.projects?.length ?? 0,
                //         itemBuilder: (context, index) {
                //           log(index.toString());
                //           return ListTile(
                //             title: Text(user.projects![index]),
                //           );
                //         },
                //       )
                //     ],
                //   ),
                // )
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

class CustomPortfolioDetailsFormSection extends StatefulWidget {
  List<String>? projects;
  UserModel user;
  final String sectionName;

  CustomPortfolioDetailsFormSection({
    super.key,
    this.projects,
    required this.user,
    required this.sectionName,
  });

  @override
  State<CustomPortfolioDetailsFormSection> createState() =>
      _CustomPortfolioDetailsFormSectionState();
}

class _CustomPortfolioDetailsFormSectionState
    extends State<CustomPortfolioDetailsFormSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${widget.sectionName[0].toUpperCase()}${widget.sectionName.substring(1).toLowerCase()}",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Form(
                          child: Column(
                            children: [
                              CustomInputFieldWidget(
                                labelText: "Project title",
                                controller: TextEditingController(),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 90,
                                height: 45,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // widget.projects != null
                                    //     ? widget.projects!.add("value")
                                    //     : widget.projects = ["value"];
                                    setState(() {
                                      widget.projects = widget.projects == null
                                          ? ["value"]
                                          : [...widget.projects!, "value"];
                                    });
                                    // will change
                                    widget.user.projects = widget.projects;
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Add",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                iconSize: 34,
                icon: Icon(
                  Icons.add,
                ),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.projects?.length ?? 0,
            itemBuilder: (context, index) {
              log(index.toString());
              return ListTile(
                title: Text(widget.projects![index]),
              );
            },
          )
        ],
      ),
    );
  }
}
