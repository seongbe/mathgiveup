import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/api/api_post_delete.dart';
import 'package:mathgame/api/api_post_patch.dart';
import 'package:mathgame/controller/PostDetailController.dart';
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

  final PostDetailController controller = Get.put(PostDetailController());

  @override
  void initState() {
    super.initState();
    titleController.text = widget.post['title'];
    contentController.text = widget.post['content'];
    controller.fetchComments(widget.post['id']); // 댓글 목록 불러오기
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
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
                            await controller.addComment(widget.post['id'], comment);
                            commentController.clear();
                            Get.snackbar('성공', '댓글이 추가되었습니다.');
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                   
                 Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (controller.comments.isEmpty) {
                      return Text('댓글이 없습니다.');
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.comments.length,
                        itemBuilder: (context, index) {
                          final comment = controller.comments[index];
                          return ListTile(
                            subtitle: Bubble(
                            margin: BubbleEdges.all(8),
                            color: Colors.white, // 말풍선 배경색을 흰색으로 설정
                            nip: BubbleNip.leftBottom, // 말풍선의 꼬리 방향을 설정
                            elevation: 3, // 그림자 효과를 위해 elevation을 사용
                            padding: BubbleEdges.all(16.0), // 내부 여백 설정
                            child: Text(
                              comment['content'], // 댓글 내용만 표시
                              style: TextStyle(
                                  color: Colors.black), // 텍스트 색상을 검정색으로 설정
                            ),
                          ) // 댓글 내용만 표시
                          );
                        },
                      );
                    }
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
