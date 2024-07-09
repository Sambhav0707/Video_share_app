import 'package:flutter/material.dart';
import 'package:tiktok_clone/View/Widgets/input_form.dart';
import 'package:tiktok_clone/constraints.dart';

class SignUpScreen extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
   SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            const Text('Sign-Up',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.white60,
              ),
            ),
            const SizedBox(height: 7,),

            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  child: Image.asset('images/user_profile.png'),
                  backgroundColor: buttonColor,
                ),
                Positioned(
                  top: 90,
                  bottom: 10,
                  left: 80,
                  child: IconButton(
                    color: Colors.white,
                    onPressed: ()=> authContoller.pickImage(),
                      icon: Icon(Icons.add_a_photo)),
                )
              ],

            ),
            const SizedBox(height: 15,),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: InputForms(
                controller: _usernameController,
                icon: Icons.account_circle,
                isObscure: false,
                labelText: 'Username',

              ),
            ),
            const SizedBox(height: 15,),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: InputForms(
                controller: _emailController,
                icon: Icons.mail,
                isObscure: false,
                labelText: 'Email',

              ),
            ),
            const SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: InputForms(
                controller: _passwordController,
                icon: Icons.lock,
                isObscure: true,
                labelText: 'Password',

              ),
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: ()=> authContoller.signUpUser(
                _usernameController.text,
                _emailController.text,
                _passwordController.text,
                authContoller.profilePhoto,

              ),
              child: Container(
                width: MediaQuery.of(context).size.width-40,
                height: 50,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: const Center(
                  child: Text('Sign-Up',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?  ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),),

                InkWell(
                  onTap: (){},
                  child: Text('Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: buttonColor,

                    ),

                  ),
                )

              ],
            )




          ],
        ),
      ),
    ) ;
  }
}
