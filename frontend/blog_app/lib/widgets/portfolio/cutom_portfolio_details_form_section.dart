import 'package:flutter/material.dart';

import 'package:blog_app/model/user.dart';
import 'package:blog_app/widgets/common/cutom_input_field_widget.dart';

class CustomPortfolioDetailsFormSection extends StatefulWidget {
  List<String>? sectionValueList;
  UserModel user;
  final String sectionName;
  final bool isReadOnly;

  CustomPortfolioDetailsFormSection({
    super.key,
    this.sectionValueList,
    required this.user,
    required this.sectionName,
    required this.isReadOnly,
  });

  @override
  State<CustomPortfolioDetailsFormSection> createState() =>
      _CustomPortfolioDetailsFormSectionState();
}

class _CustomPortfolioDetailsFormSectionState
    extends State<CustomPortfolioDetailsFormSection> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 14, bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${widget.sectionName[0].toUpperCase()}${widget.sectionName.substring(1).toLowerCase()}",
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(223, 41, 88, 127),
                    ),
                  ),
                ),
                if (!widget.isReadOnly)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(117, 91, 154, 206),
                    ),
                    child: IconButton(
                      color: const Color.fromARGB(223, 41, 88, 127),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: double.maxFinite,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    CustomInputFieldWidget(
                                      labelText: "Title",
                                      controller: _titleController,
                                      autofocus: true,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          90,
                                      height: 45,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 163, 213, 254),
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              widget.sectionValueList =
                                                  widget.sectionValueList ==
                                                          null
                                                      ? [_titleController.text]
                                                      : [
                                                          ...widget
                                                              .sectionValueList!,
                                                          _titleController.text
                                                        ];
                                            });
                                            updateActualUserData();
                                            _titleController.clear();
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: const Text(
                                          "Add",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                223, 41, 88, 127),
                                          ),
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
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          ListView.builder(
            physics:
                const NeverScrollableScrollPhysics(), // ListView is already in SingleChildScrollView
            shrinkWrap: true,
            itemCount: widget.sectionValueList?.length ?? 0,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: const Color.fromARGB(199, 198, 229, 255),
                child: ListTile(
                  title: Text(
                    widget.sectionValueList![index],
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(223, 41, 88, 127),
                    ),
                  ),
                  trailing: widget.isReadOnly
                      ? null
                      : IconButton(
                          color: Colors.red[400],
                          onPressed: () {
                            setState(() {
                              widget.sectionValueList =
                                  List.from(widget.sectionValueList!)
                                    ..removeAt(index);
                            });
                            updateActualUserData();
                          },
                          icon: const Icon(Icons.delete),
                          iconSize: 24,
                        ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void updateActualUserData() {
    switch (widget.sectionName) {
      case "projects":
        widget.user.projects = widget.sectionValueList;
        break;
      case "skills":
        widget.user.skills = widget.sectionValueList;
        break;
      case "achievements":
        widget.user.achievements = widget.sectionValueList;
        break;
    }
  }
}
