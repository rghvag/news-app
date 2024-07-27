// import 'package:flutter/material.dart';
class Article {
  final String title;
  final String? description;
  final String url;
  final String? imageUrl;

  Article(
      {required this.title,
     this.description,
      required this.url,
      this.imageUrl});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      description: json['description']??"",
      url: json['url'],
      imageUrl: json['urlToImage'] ?? "",
    );
  }
}
