// ignore_for_file: use_build_context_synchronously, must_be_immutable, avoid_print, unused_local_variable
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/Pages/chat_page.dart';
import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/Components/custom_button.dart';
import 'package:chat_app/helper/showsnackbarmessage.dart';
import 'package:chat_app/Components/custom_text_form_field.dart';
import 'package:chat_app/Pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static String id = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? password, userName, email;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  // Future<void> userSigninWithEmailAndPassword() async {
  //   UserCredential user = await FirebaseAuth.instance
  //       .signInWithEmailAndPassword(email: email!, password: password!);
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          isLoading = true;
        } else if (state is LoginSucessState) {
          isLoading = false;
          BlocProvider.of<ChatCubit>(context).getMessage();
          // Why did we trigger getMessage here?
          //because in this case we need while navigatinng to the chat
          //the messages need to be loaded successfully...
          Navigator.pushNamed(context, ChatPage.id,                          arguments: email,
);
        } else if (state is LoginFailureState) {
          isLoading = false;
          showSnackBarMessage(context, state.errorMessage);
        }
      },
      builder: (context, state) => ModalProgressHUD(
        // Changed From Listner To Builder To Show Loading State ...
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 23,
                  ),
                  Image.asset(
                    kImage,
                    height: 123,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Takamul",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Pacifico",
                          fontSize: 38,
                        ),
                      ),
                      SizedBox(
                        height: 123,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 64,
                        ),
                        Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextFormField(
                    labelText: 'Email',
                    myIcon: Icons.email,
                    onChanged: (data) {
                      email = data;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextFormField(
                    obscureText: true,
                    labelText: "Pssword",
                    myIcon: Icons.lock,
                    onChanged: (data) {
                      password = data;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    buttonName: "Login",
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context)
                            .userSigninWithEmailAndPassword(
                          email: email!,
                          password: password!,
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have any account?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            SignupPage.id,
                          );
                        },
                        child: const Text(
                          "  Signup Now!",
                          style: TextStyle(
                            color: Color.fromRGBO(2, 209, 182, 0.808),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
