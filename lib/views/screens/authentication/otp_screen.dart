import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_store/controllers/auth_controller.dart';
import 'package:online_store/core/themes/colors.dart';
import 'package:online_store/core/widgets/common_widget.dart';
import 'package:online_store/services/manage_http_response.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<String> otpDigits = List.filled(6, ''); 
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  void verifyOtp() async {
    // if(otpDigits.contains('')){
    //   showSnackBar(context, "Please fill in all OTP fields", Colors.red);
    // } else {
    //   return;
    // }

    setState(() {
      isLoading = true;
    });
    final otp = otpDigits.join();

    await _authController.verifyOtp(context: context, email: widget.email, otp: otp).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Widget buildOtpField(int index) {
    return SizedBox(
      width:45,
      height: 55,
      child: TextFormField(
        validator: (value) {
          if(value!.isEmpty){
            return "Enter OTP";
          } else {
            return null;
          }
        },
        onChanged: (value) {
          if(value.isNotEmpty && value.length == 1){
            otpDigits[index] = value;

            if(index < 5){
              FocusScope.of(context).nextFocus();
            } 
            // else {
            //   otpDigits[index] = '';
            // }
          }
        },
        onFieldSubmitted: (value) {
          if(index == 5 && _formKey.currentState!.validate()){
            verifyOtp();
          }
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
        ),
        style: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.bold,

        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("Verify your Account",style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                    color: Color(0xFF0d120E)
                  ),),
                  customSizedBox(heigh: 10),
                  Text("Enter the OTP send to ${widget.email}",style: GoogleFonts.lato(
                    color: Color(0xFF0d120E),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),),
                  customSizedBox(heigh: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, buildOtpField)
                  ),
                  customSizedBox(heigh: 30),
                  InkWell(
                    onTap: () {
                      verifyOtp();
                    },
                    child: Container(
                      width: 319,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF103DE5),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: isLoading ? CircularProgressIndicator() :  Text("Verify",style: GoogleFonts.montserrat(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}