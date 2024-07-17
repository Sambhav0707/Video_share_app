import'package:flutter/material.dart';

class CoustomButton extends StatelessWidget {
  const CoustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 30,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 250, 45, 108),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right:  10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 32, 211,234),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          Center(
            child: Container(
              height: double.infinity,
              width: 38,
              color: Colors.white,
              child: Icon(Icons.add,
                color: Colors.black,
              ),

            ),
          )
        ],
      ),
    );
  }
}
