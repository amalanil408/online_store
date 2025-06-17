import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_store/controllers/auth_controller.dart';
import 'package:online_store/core/themes/colors.dart';
import 'package:online_store/core/widgets/common_widget.dart';
import 'package:online_store/provider/user_provider.dart';

class ShippingAddressScreen extends ConsumerStatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends ConsumerState<ShippingAddressScreen> {
  final AuthController _authController = AuthController();
  final GlobalKey<FormState>  _formKey = GlobalKey<FormState>();
  late TextEditingController _stateController;
  late TextEditingController _cityController;
  late TextEditingController _localityController;


  @override
  void initState() {
    super.initState();
    final user= ref.read(userProvider);
    _stateController = TextEditingController(text: user?.state??"");
    _cityController = TextEditingController(text: user?.city??"");
    _localityController = TextEditingController(text: user?.locality??"");
  }
  
  void _showDialog(){
    showDialog(
      context: context, 
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          child: Padding(padding: EdgeInsets.all(15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              customSizedBox(width: 20),
              Text("Updating....",style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,

              ),)
            ],
          ),
          ),
        );
      },
      );
  }


  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);
    final updateUser = ref.read(userProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.96),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        elevation: 0,
        title: Text("Delivery"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "Where will your order\n be shipped",style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.7,
                  ),),
                  TextFormField(
                    controller: _stateController,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Please Enter state";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "State",
                    ),
                  ),
                  customSizedBox(heigh: 15),
                  TextFormField(
                    controller: _cityController,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Please Enter City";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "City",
                    ),
                  ),
                  customSizedBox(heigh: 15),
                  TextFormField(
                    controller: _localityController,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Please Enter Loaclity";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Locality",
                    ),
                  ),
                  customSizedBox(heigh: 15),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async{
            if(_formKey.currentState!.validate()) {
              _showDialog();
              await _authController.updateUserLocaltion(
                context: context, 
                id: user!.id, 
                state: _stateController.text, 
                city: _cityController.text, 
                locality: _localityController.text
                ).whenComplete((){
                  updateUser.recreateUserState(state: _stateController.text, city: _cityController.text, locality: _localityController.text);
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
            } else {
              print("not valid");
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFF3854EE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Text("Save",style: GoogleFonts.montserrat(
              color: whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),),),
          ),
        ),
      ),
    );
  }
}