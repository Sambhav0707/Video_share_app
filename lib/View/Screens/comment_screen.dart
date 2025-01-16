import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage('https://picsum.photos/200/300'),
                    backgroundColor: Colors.black,
                  ),
                  title: Row(
                    children: [
                      Text(
                        'Username',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),Text(
                        'comment description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        '1 Day ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),Text(
                        '50 likes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ) ,
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
