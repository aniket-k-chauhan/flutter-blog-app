import 'package:flutter/material.dart';

import 'package:blog_app/model/blog.dart';
import 'package:blog_app/utils/cutom_formatted_date.dart';

class BlogRead extends StatelessWidget {
  final BlogModel blog;

  const BlogRead({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.title!,
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    EMMMdyFormat(blog.updatedAt!),
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "- ${blog.authorName}",
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 0.3,
                      wordSpacing: 1,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Color.fromARGB(255, 163, 213, 254),
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color.fromARGB(199, 198, 229, 255),
                    borderRadius: BorderRadius.circular(16)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Text(
                  blog.description!,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
