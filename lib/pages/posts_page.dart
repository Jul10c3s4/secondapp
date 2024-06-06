import 'package:flutter/material.dart';
import 'package:secondapp/models/json_placeholder_model.dart';
import 'package:secondapp/pages/comments_page.dart';
import 'package:secondapp/repositories/posts/impl/json_placeholder_dio_repository.dart';
import 'package:secondapp/repositories/posts/impl/json_placeholder_repository.dart';
import 'package:secondapp/repositories/posts/posts_repository.dart';
import 'package:secondapp/shared/drawer.dart';
import 'package:secondapp/shared/textComponent.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  var posts = <JsonPlaceholderModel>[];
  late PostsRepository jsonPlaceholderRepository;

  @override
  void initState() {
    // TODO: implement initState
    jsonPlaceholderRepository = JsonPlaceholderDioRepository();
    super.initState();
    getData();
  }

  getData() async {
    posts = await jsonPlaceholderRepository.getPosts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomTitle.buildMainTitle(context, "PostsPage"),
        ),
        drawer: const DrawerComponent(),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            JsonPlaceholderModel post = posts[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CommentsPage(jsonPlaceholderModel: post)));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        CustomTitle.buildTitle(context, post.title.toString()),
                        const SizedBox(
                          height: 4,
                        ),
                        CustomTitle.buildSubTitle(context, post.body.toString())
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
