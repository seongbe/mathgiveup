import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathgame/const/colors.dart';
import '../../api/api_model.dart';
import '../../api/api_user.dart';

class Postpage extends StatelessWidget {
  const Postpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color.alphaBlend(
        Colors.white.withOpacity(0.35),
        BACKGROUND_COLOR,
      ),
       appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Navigator.pop 대신 Get.back을 사용하여 뒤로가기
          },
        ),
        title: Text('친구목록'),
       ),
        body: FutureBuilder<List<User>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar),
                  ),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email),
                );
              },
            );
          } else {
            return Center(child: Text('No users found'));
          }
        },
      ),
    );
  }
}