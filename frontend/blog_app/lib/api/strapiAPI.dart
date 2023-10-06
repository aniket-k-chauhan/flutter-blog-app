import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:blog_app/model/blog.dart';

const String BASEURL = "http://10.1.86.169:1337";

Future<void> addBlog(BlogModel blogData) async {
  try {
    final Map data = {"data": blogData.toJson()};
    log(data.toString());

    //encode Map to JSON
    final body = jsonEncode(data);
    final response = await http.post(
      Uri.parse("$BASEURL/api/blogs"),
      headers: <String, String>{
        'content-type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    log(response.toString());
  } catch (error) {
    log(error.toString());
    throw Exception(error);
  }
}

Future<List<BlogModel>> getAllBlogs() async {
  List<BlogModel> blogs = [];
  final response = await http.get(Uri.parse("$BASEURL/api/blogs"));
  if (response.statusCode == 200) {
    blogs.clear();
  }

  final decodedData = jsonDecode(response.body);

  for (var blog in decodedData["data"]) {
    blogs.add(BlogModel(
      id: blog["id"],
      title: blog["attributes"]["title"],
      description: blog["attributes"]["description"],
      author: blog["attributes"]["author"],
    ));
  }

  return blogs;
}
