import 'package:flutter/material.dart';
import 'package:tiktok_clone/View/Widgets/input_form.dart';
import 'package:tiktok_clone/constraints.dart';

class LoginScreen extends StatelessWidget {


 LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('SAM-VI-TOKK',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: buttonColor,
              ),
            ),
            const SizedBox(height: 15,),
            const Text('Login',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.white60,
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
              onTap: ()=> authContoller.loginUser(
                _emailController.text,
                _passwordController.text,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width-40,
                height: 50,
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: const Center(
                  child: Text('Login',
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
                const Text("Don't have an account?  ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),),

                InkWell(
                  onTap: (){},
                  child: Text('Sign up',
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
    );
  }
}
