import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blog_app/api/strapiAPI.dart';
import 'package:blog_app/model/blog.dart';
import 'package:blog_app/provider/blog_provider.dart';
import 'package:blog_app/utils/cutom_formatted_date.dart';
import 'package:blog_app/utils/permission.dart';
import 'package:blog_app/widgets/common/common_snackbar.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({
    super.key,
    required this.blog,
  });

  final BlogModel blog;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Color.fromARGB(117, 91, 154, 206),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.of(context).pushNamed("/readBlog", arguments: blog);
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  blog.title!,
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(223, 41, 88, 127),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            EMMMdyFormat(blog.updatedAt!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 1,
                              color: Colors.white.withOpacity(0.75),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            "by ${blog.authorName}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: Colors.white.withOpacity(0.75),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      blog.description!,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black26,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
          ),
          if (hasWriteAccess(blog.authorEmail!))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed("/blogForm", arguments: blog);
                    },
                    icon: Icon(Icons.edit_note_rounded),
                    iconSize: 34,
                    color: Color.fromARGB(223, 41, 88, 127),
                    tooltip: "Edit blog",
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () async {
                      try {
                        String responseMsg = await deleteBlog(blog.id!);

                        Provider.of<BlogUpdateModel>(context, listen: false)
                            .notify();

                        ScaffoldMessenger.of(context).showSnackBar(
                            CommonSnackBar.buildSnackBar(
                                context, responseMsg, "success"));
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CommonSnackBar.buildSnackBar(
                                context, error.toString(), "error"));
                      }
                    },
                    icon: Icon(Icons.delete_rounded),
                    iconSize: 30,
                    color: Color.fromARGB(255, 202, 45, 42),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
