import 'package:flutter/material.dart';

class HeaderWidgets extends StatelessWidget {
  const HeaderWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      child: ClipRRect(
        child: Stack(
          children: [
            Image.asset('assets/icons/searchBanner.jpeg',width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
              Positioned(
              left: 23,
              top: 63,
              child: SizedBox(
                width: 250,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Text",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF7F7F7F)
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10,),
                    prefixIcon: Image.asset('assets/icons/searc1.png',),
                    suffixIcon: Image.asset('assets/icons/cam.png'),
                    fillColor: Colors.grey.shade200,
                    focusColor: Colors.black,
                    filled: true
                  ),
                ),
              )
              ),
              Positioned(
                left: 275,
                top: 78,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {
                      
                    },
                    child: Ink(
                      width: 31,
                      height: 31,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/icons/bell.png')
                          )
                      ),
                    ),
                  ),
                )
                ),
                Positioned(
                  left: 314,
                  top: 78,
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () {
                        
                      },
                      child: Ink(
                        width: 31,
                        height: 31,
                        decoration:const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/icons/message.png')
                            )
                        ),
                      ),
                    ),
                  )
                  )
          ],
        ),
      ),
    );
  }
}