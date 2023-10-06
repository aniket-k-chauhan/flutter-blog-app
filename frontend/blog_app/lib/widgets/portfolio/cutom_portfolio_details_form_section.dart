import 'package:blog_app/model/user.dart';
import 'package:blog_app/widgets/common/cutom_input_field_widget.dart';
import 'package:flutter/material.dart';

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
              if (!widget.isReadOnly)
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
                        return Container(
                          height: double.maxFinite,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 8),
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
                                  width: MediaQuery.of(context).size.width - 90,
                                  height: 45,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          widget.sectionValueList =
                                              widget.sectionValueList == null
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
            physics:
                const NeverScrollableScrollPhysics(), // ListView is already in SingleChildScrollView
            shrinkWrap: true,
            itemCount: widget.sectionValueList?.length ?? 0,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Color.fromARGB(117, 91, 154, 206),
                child: ListTile(
                  title: Text(widget.sectionValueList![index]),
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
                          icon: Icon(Icons.delete),
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
