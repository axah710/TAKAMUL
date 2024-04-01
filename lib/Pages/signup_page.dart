// ignore_for_file: must_be_immutable, use_build_context_synchronously, unused_local_variable

import 'package:chat_app/Pages/login_page.dart';
import 'package:chat_app/cubits/signup_cubit/signup_cubit.dart';
import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/Components/custom_button.dart';
import 'package:chat_app/helper/showsnackbarmessage.dart';
import 'package:chat_app/Components/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static String id = "SignupPage";

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String? password, userName, email;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupLoadingState) {
          isLoading = true;
        } else if (state is SignupSucessState) {
          isLoading = false;
          showSnackBarMessage(context, state.sucessMessage);
          Navigator.pushNamed(context, LoginPage.id);
        } else if (state is SignupFailureState) {
          isLoading = false;
          showSnackBarMessage(context, state.errorMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    Image.asset(
                      kImage,
                      height: 120,
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
                          height: 120,
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          Text(
                            "Signup",
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
                      labelText: 'User Name',
                      myIcon: Icons.supervised_user_circle,
                      onChanged: (data) {
                        userName = data;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextFormField(
                      labelText: "Pssword",
                      obscureText: true,
                      myIcon: Icons.lock,
                      onChanged: (data) {
                        password = data;
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    CustomButton(
                      buttonName: "Signup",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<SignupCubit>(context)
                              .userSignupWithEmailAndPassword(
                            email: email!,
                            password: password!,
                          );
                          // Triggering The Cubit ...
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
                          "Have already account?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "  Login Now!",
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
        );
      },
    );
  }

//   Future<void> userSignupWithEmailAndPassword() async {
//     UserCredential user = await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: email!, password: password!);
//   }
}
