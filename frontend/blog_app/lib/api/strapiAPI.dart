/// contains all CRUD method for strapi

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:blog_app/api/firestoreAPI.dart';
import 'package:blog_app/auth/auth.dart';
import 'package:blog_app/model/blog.dart';

const String BASEURL = "http://192.168.245.64:1337";

Future<String> addBlog(BlogModel blogData) async {
  try {
    // Add Author Details to Blog
    blogData.authorEmail = Auth.getLoggedInUser()!.email;
    blogData.authorName = await getUserDetailsByEmail(blogData.authorEmail!)
        .then((user) => user.name);

    Map data = {"data": blogData.toJson()};

    //encode Map to JSON
    final body = jsonEncode(data);
    final response = await http.post(
      Uri.parse("$BASEURL/api/blogs"),
      headers: <String, String>{
        'content-type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    final responseData = jsonDecode(response.body);

    if (responseData["data"] == null) {
      throw Exception("Blog Not Added Successfully");
    }
    return "Blog Added Successfully";
  } catch (error) {
    throw Exception(error);
  }
}

Future<List<BlogModel>> getAllBlogs() async {
  List<BlogModel> blogs = [];
  try {
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
        authorName: blog["attributes"]["authorName"],
        authorEmail: blog["attributes"]["authorEmail"],
        updatedAt: blog["attributes"]["updatedAt"],
      ));
    }

    return blogs;
  } catch (error) {
    throw Exception(error);
  }
}

Future<String> deleteBlog(int id) async {
  final response = await http.delete(Uri.parse("$BASEURL/api/blogs/$id"));

  final responseData = jsonDecode(response.body);

  if (responseData["data"] == null) {
    return "Blog Not Deleted Successfully";
  }

  return "Blog Deleted Successfully";
}

Future<String> updateBlog(int id, BlogModel blogData) async {
  try {
    // Add Author Details to Blog
    blogData.authorEmail = Auth.getLoggedInUser()!.email;
    blogData.authorName = await getUserDetailsByEmail(blogData.authorEmail!)
        .then((user) => user.name);

    Map data = {"data": blogData.toJson()};

    //encode Map to JSON
    final body = jsonEncode(data);
    final response = await http.put(
      Uri.parse("$BASEURL/api/blogs/$id"),
      headers: <String, String>{
        'content-type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    final responseData = jsonDecode(response.body);

    if (responseData["data"] == null) {
      return "Blog Not Updated Successfully";
    }
    return "Blog Updated Successfully";
  } catch (error) {
    throw Exception(error);
  }
}
