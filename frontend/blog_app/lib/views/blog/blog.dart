import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blog_app/api/strapiAPI.dart';
import 'package:blog_app/model/blog.dart';
import 'package:blog_app/provider/blog_provider.dart';
import 'package:blog_app/widgets/common/custom_loader.dart';
import 'package:blog_app/widgets/blog/blog_card.dart';
import 'package:blog_app/widgets/common/common_snackbar.dart';

class Blog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      child: Consumer<BlogUpdateModel>(
        builder: (context, value, child) => FutureBuilder(
            future: getAllBlogs(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                ScaffoldMessenger.of(context).showSnackBar(
                    CommonSnackBar.buildSnackBar(
                        context, snapshot.error.toString(), "error"));
              } else if (snapshot.hasData) {
                List<BlogModel> blogs = snapshot.data!;

                return blogs.isEmpty
                    ? Center(
                        child: Text(
                          "No Blogs",
                          style: TextStyle(
                            fontSize: 32,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: blogs.length,
                        itemBuilder: (context, index) {
                          BlogModel blog = blogs[index];

                          return BlogCard(blog: blog);
                        },
                      );
              }

              return Center(
                child: CustomLoader(),
              );
            }),
      ),
    );
  }
}
