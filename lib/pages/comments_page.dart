import 'package:flutter/material.dart';
import 'package:secondapp/models/comment_model.dart';
import 'package:secondapp/models/json_placeholder_model.dart';
import 'package:secondapp/repositories/comments/comments_repository.dart';
import 'package:secondapp/repositories/comments/impl/comments__dio_repository.dart';
import 'package:secondapp/repositories/comments/impl/comments_repository.dart';
import 'package:secondapp/shared/textComponent.dart';

class CommentsPage extends StatefulWidget {
  JsonPlaceholderModel jsonPlaceholderModel;
  CommentsPage({super.key, required this.jsonPlaceholderModel});
  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  List<CommentModel> comments = [];
  late CommentsRepository commentsRepository;
  bool load = false;

  @override
  void initState() {
    // TODO: implement initState
    commentsRepository = CommentsDioRepository();
    super.initState();
    getData();
  }

  getData() async {
    load = true;
    setState(() {});
    comments =
        await commentsRepository.getComments(widget.jsonPlaceholderModel.id!);
    load = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: CustomTitle.buildMainTitle(
              context, widget.jsonPlaceholderModel.title.toString()),
        ),
        body: load
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  var comment = comments[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTitle.buildTitle(
                                context, "Nome: ${comment.name.toString()}"),
                            const SizedBox(
                              height: 4,
                            ),
                            CustomTitle.buildSubTitle(
                                context, "Email: ${comment.email.toString()}"),
                            const SizedBox(
                              height: 4,
                            ),
                            CustomTitle.buildSubTitle(context,
                                "Descrição: ${comment.body.toString()}")
                          ],
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
