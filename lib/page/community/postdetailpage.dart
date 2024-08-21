import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/api/%08api_comment_post.dart';
import 'package:mathgame/api/api_post_delete.dart';
import 'package:mathgame/api/api_post_patch.dart';
import 'package:mathgame/page/community/postlistpage.dart';
 
class PostDetailPage extends StatefulWidget {
  final Map<String, dynamic> post;

  const PostDetailPage({super.key, required this.post});

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  
  List<Map<String, dynamic>> comments = []; // 댓글 목록을 관리하는 상태 변수

  @override
  void initState() {
    super.initState();
    titleController.text = widget.post['title'];
    contentController.text = widget.post['content'];
    // 초기 댓글 목록을 서버에서 가져와 설정할 수 있습니다.
    // comments = 초기 댓글 목록;
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    commentController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('게시물 상세'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              String newTitle = titleController.text; 
              String newContent = contentController.text;
              bool success = await updatePost(widget.post['id'], newTitle, newContent);
              if (success) {
                Get.snackbar('성공', '게시물이 수정되었습니다.');
                Get.to(() => Postlistpage());
              } else {
                Get.snackbar('오류', '게시물 수정에 실패했습니다.');
              }
            },
            child: Text('수정'),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () async {
              bool success = await deletePost(widget.post['id']);
              if (success) {
                Get.snackbar('성공', '게시물이 삭제되었습니다.');
                Get.to(() => Postlistpage());
              } else {
                Get.snackbar('오류', '게시물 삭제에 실패했습니다.');
              }
            },
            child: Text('삭제'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, 
            ),
          ),
        ],
      ),
      body: 
      
      Stack(
        
        children: [
           Container(
            // 배경 이미지 설정
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'), // 배경 이미지 경로
                fit: BoxFit.cover, // 이미지 크기 조정 방식
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            labelText: '제목',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: contentController,
                          decoration: InputDecoration(
                            labelText: '내용',
                            border: InputBorder.none,
                          ),
                          maxLines: null,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '댓글',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      labelText: '댓글을 입력하세요...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () async {
                          String comment = commentController.text;
                          if (comment.isNotEmpty) {
                            bool success = await postComment(comment, widget.post['id']);
                            if (success) {
                              setState(() {
                                comments.add({'content': comment, 'username': '나'}); // 새로운 댓글 추가
                              });
                              commentController.clear();
                              Get.snackbar('성공', '댓글이 추가되었습니다.');
                            } else {
                              Get.snackbar('오류', '댓글 추가에 실패했습니다.');
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // 댓글 목록
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(comment['username'][0]), // 사용자 이니셜 또는 이미지
                        ),
                        title: Text(comment['username']),
                        subtitle: Text(comment['content']),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}