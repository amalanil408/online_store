import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_store/controllers/auth_controller.dart';
import 'package:online_store/core/themes/colors.dart';
import 'package:online_store/core/widgets/authentication_screen_widget.dart';
import 'package:online_store/core/widgets/common_widget.dart';
import 'package:online_store/views/screens/authentication/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthController _authController = AuthController();

  late String email;

  late String fullName;

  late String password;

  bool  isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xF2FFFFFF),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create Your Account",
                      style: GoogleFonts.getFont(
                        'Lato',
                        color: baseFontColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                        fontSize: 23,
                      ),
                    ),
                    Text(
                      "To Explore the world exclusives",
                      style: GoogleFonts.getFont(
                        "Lato",
                        color: baseFontColor,
                        fontSize: 14,
                        letterSpacing: 0.2,
                      ),
                    ),
                    Image.asset(
                      "assets/images/Illustration.png",
                      width: 200,
                      height: 200,
                    ),
                
                    AlignWidget(text: "Email"),
                    TextFieldWidget(
                      onChanged: (value) {
                        email = value;
                      },
                      labelText: "enter your email",
                      prefixIcon: "assets/icons/email.png",
                    ),
                    customSizedBox(heigh: 20),
                    AlignWidget(text: "Full Name"),
                    TextFieldWidget(
                      onChanged: (value) {
                        fullName = value;
                      },
                      labelText: "enter your full name",
                      prefixIcon: "assets/icons/user.jpeg",
                    ),
                    customSizedBox(heigh: 20),
                    TextFieldWidget(
                      onChanged: (value) {
                        password = value;
                      },
                      labelText: "enter your password",
                      prefixIcon: "assets/icons/password.png",
                      suffixIcon: Icon(Icons.visibility),
                    ),
                    customSizedBox(heigh: 20),
                    InkWell(
                      onTap: () async{
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            isLoading = true;
                          });
                          await _authController.signUpUsers(context: context, email: email, fullName: fullName, password: password).whenComplete((){
                            _formKey.currentState!.reset();
                            setState(() {
                              isLoading = false;
                            });
                          });
                        }
                      },
                      child: AuthenticationButtonWidget(text: "Sign Up",isLoading: isLoading,)),
                    customSizedBox(heigh: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an Account?",style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1
                        ),),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
                          },
                          child: Text("Sign In",style: GoogleFonts.roboto(
                            color: Color(0xFF103De5),
                            fontWeight: FontWeight.bold
                          ),),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

