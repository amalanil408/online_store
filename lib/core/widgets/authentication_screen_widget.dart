import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_store/core/themes/colors.dart';

class AlignWidget extends StatelessWidget {
  final String text;
  const AlignWidget({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(text,style: GoogleFonts.getFont(
        "Nunito Sans",
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2
      ),),
    );
  }
}





class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final String prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  
  const TextFieldWidget({super.key, required this.labelText, required this.prefixIcon,this.suffixIcon,this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: (value) {
        if(value!.isEmpty){
          return labelText;
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        fillColor: whiteColor,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        labelText: labelText,
        labelStyle: GoogleFonts.getFont(
          "Nunito Sans",
          fontSize: 14,
          letterSpacing: 0.1,
        ),
        prefixIcon: SizedBox(
          width: 20,
          height: 20,
          child: Center(
            child: Image.asset(
              prefixIcon,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),
          ),
        ),
        suffixIcon: suffixIcon
      ),
    );
  }
}





class AuthenticationButtonWidget extends StatelessWidget {
  final String text;
  final bool isLoading;
  const AuthenticationButtonWidget({
    super.key,
    required this.text,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 319,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: const LinearGradient(
          colors: [Color(0xFF102DE1), Color(0xCC0D6EFF)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 278,
            top: 19,
            child: Opacity(
              opacity: 0.5,
              child: Container(
                width: 60,
                height: 60,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 12,
                    color: const Color(0xFF103DE5),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Positioned(
            left: 311,
            top: 36,
            child: Opacity(
              opacity: 0.3,
              child: Container(
                width: 5,
                height: 5,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
          Positioned(
            left: 281,
            top: -10,
            child: Opacity(
              opacity: 0.3,
              child: Container(
                width: 20,
                height: 20,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Center(
            child: isLoading ? const CircularProgressIndicator(
              color: whiteColor,
              strokeWidth: 2.5,
            ) : Text(
              text,
              style: GoogleFonts.getFont(
                'Lato',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
