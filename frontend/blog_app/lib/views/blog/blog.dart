import 'dart:developer';

import 'package:blog_app/api/firestoreAPI.dart';
import 'package:blog_app/api/strapiAPI.dart';
import 'package:blog_app/model/blog.dart';
import 'package:blog_app/widgets/common/custom_loader.dart';
import 'package:flutter/material.dart';

class Blog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllBlogs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<BlogModel> blogs = snapshot.data!;

            return ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                BlogModel blog = blogs[index];

                return Card(
                  color: Color.fromARGB(117, 91, 154, 206),
                  child: ListTile(
                    title: Text(
                      blog.title!,
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "by ${blog.author}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16, letterSpacing: 0.2),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          blog.description!,
                          style: TextStyle(fontSize: 18),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return Center(
            child: CustomLoader(),
          );
        });
  }
}
