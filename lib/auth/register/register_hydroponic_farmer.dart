import 'package:apehipo_app/auth/login/login.dart';
import 'package:apehipo_app/auth/roles/role.dart';
import 'package:flutter/material.dart';

class RegisterHydroponicFarmer extends StatefulWidget {
  static const String id = "register_hydroponic_farmer";

  const RegisterHydroponicFarmer({super.key});

  @override
  State<RegisterHydroponicFarmer> createState() => _RegisterHydroponicFarmer();
}

class _RegisterHydroponicFarmer extends State<RegisterHydroponicFarmer> {
  final GlobalKey<FormState> _signUpGlobalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRetryController = TextEditingController();
  bool passwordSee = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                // bottomLeft: Radius.circular(30), // Atur radius sudut kiri bawah
                // bottomRight: Radius.circular(30), // Atur radius sudut kanan bawah
                ),
          ),
          backgroundColor: Color(0xFFF53B175),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
            onPressed: () => 
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) {
                  return RolePage();
                },
              )),
          ),
          title: Text(
            'APEHIPO',
            style: TextStyle(
              fontFamily: 'PoppinsMedium',
            ),
          ),
          centerTitle: true,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _signUpGlobalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Row(
                  children: const [
                    const Text(
                      "Sign up as \nHydroponic Farmer",
                      style: TextStyle(
                        color: Color(0xFF404653),
                        letterSpacing: 0.5,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    // Name Input -------------------------------------
                    TextFormField(
                      controller: nameController,
                      // validator: AuthValidator.isNameValid,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                          hintText: "Full name",
                          ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      // validator: AuthValidator.isNameValid,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                          hintText: "Username",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          ),
                    ),
                    // Email Input -------------------------------------
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      // validator: AuthValidator.isEmailValid,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                          hintText: "E-mail",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          ),
                    ),
                    // Password Input -------------------------------------
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      obscureText: passwordSee,
                      // validator: AuthValidator.isPasswordValid,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        hintText: "Password",
                        // suffixIcon: GestureDetector(
                        //   onTap: () {
                        //     passwordSee = !passwordSee;
                        //     setState(() {});
                        //   },
                        //   child: Icon(
                        //     passwordSee
                        //         ? Icons.visibility_off_outlined
                        //         : Icons.visibility_outlined,
                        //   ),
                        // ),
                      ),
                    ),
                    // Retry Password Input -------------------------------------
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordRetryController,
                      obscureText: passwordSee,
                      // validator: AuthValidator.isPasswordValid,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                        hintText: "Confirm password",
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Sign Up for Button ----------------------------------
                    Container(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Color(0xFFF53B175),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () => {
                          Navigator.of(context)
                              .pushReplacement(new MaterialPageRoute(
                            builder: (BuildContext context) {
                              return LoginPage();
                            },
                          )),
                        },
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
  }

  // // when the button is pressed
  // void signUpButton() {
  //   if (_signUpGlobalKey.currentState!.validate()) {
  //     final message = authController.registration(
  //       nameController.text.trim(),
  //       emailController.text.trim(),
  //       passwordController.text.trim(),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(message["message"] as String),
  //         margin:
  //             EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .9),
  //         behavior: SnackBarBehavior.floating,
  //         duration: const Duration(seconds: 5),
  //         shape: const StadiumBorder(),
  //         dismissDirection: DismissDirection.horizontal,
  //         showCloseIcon: true,
  //       ),
  //     );
  //   }
  // }

  // textController exits when finished
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordRetryController.dispose();
    super.dispose();
  }
}
