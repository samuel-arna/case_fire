import 'package:case_fire/modules/post/domain/entities/post_entity.dart';
import 'package:case_fire/modules/post/ui/functions/post_list_loader.dart';
import 'package:case_fire/modules/post/ui/widgets/post_item.dart';
import 'package:flutter/material.dart';

class ListPosts extends StatefulWidget {
  final List<PostEntity> posts;
  const ListPosts({super.key, required this.posts});

  @override
  State<ListPosts> createState() => _ListPostsState();
}

class _ListPostsState extends State<ListPosts> {
  final ScrollController _scrollController = ScrollController();
  int offset = 10;
  bool loading = false;
  List<PostEntity> displayedPosts = [];
  final PostListLoader _postListLoader = PostListLoader();

  @override
  void initState() {
    super.initState();
    displayedPosts = widget.posts.sublist(0, offset);
    _scrollController.addListener(() {
      if (_scrollController.offset ==
              _scrollController.position.maxScrollExtent &&
          offset < widget.posts.length) {
        setState(() {
          loading = true;
        });
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            displayedPosts = _postListLoader.loadMorePosts(
              widget.posts,
              offset,
              10,
            );
            offset = displayedPosts.length;
            loading = false;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: displayedPosts.length,
          itemBuilder: (context, i) => PostItem(post: displayedPosts[i]),
          controller: _scrollController,
        ),
        Positioned(
          child: Opacity(
            opacity: loading ? 1 : 0,
            child: Center(
              child: Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(75),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                    strokeWidth: 6,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
