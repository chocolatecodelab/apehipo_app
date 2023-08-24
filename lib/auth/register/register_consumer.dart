import 'package:apehipo_app/auth/auth_controller.dart';
import 'package:apehipo_app/auth/login/login.dart';
import 'package:apehipo_app/auth/roles/role.dart';
import 'package:apehipo_app/widgets/success_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:ui_one/features/auth/presentation/components/buttons.dart';
// import 'package:ui_one/features/auth/presentation/validator/auth_validator.dart';
// import 'package:ui_one/service._locator.dart';

class RegisterConsumer extends StatefulWidget {
  static const String id = "register_consumer";

  const RegisterConsumer({super.key});

  @override
  State<RegisterConsumer> createState() => _RegisterConsumerState();
}

class _RegisterConsumerState extends State<RegisterConsumer> {
  final GlobalKey<FormState> _signUpGlobalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRetryController = TextEditingController();
  bool passwordSee = true;
  var controller = Get.put(AuthController());

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
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
            onPressed: () =>
                Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) {
                return RolePage();
              },
            )),
          ),
          title: Text(
            'APEHIPO',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
                      "Daftar sebagai Konsumen",
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
                      controller: controller.nama,
                      // validator: AuthValidator.isNameValid,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                        hintText: "Nama",
                        // hintStyle: TextStyle(fontFamily: "PoppinsRegular")
                      ),
                    ),
                    const SizedBox(height: 20),
                    // No Telpon Input -------------------------------------
                    TextFormField(
                      controller: controller.noTelpon,
                      keyboardType: TextInputType.phone,
                      // validator: AuthValidator.isNameValid,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                        hintText: "No Telpon",
                        // hintStyle: TextStyle(fontFamily: "PoppinsRegular")
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Username Input -------------------------------
                    TextFormField(
                      controller: controller.username,
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
                        // hintStyle: TextStyle(fontFamily: "PoppinsRegular")
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Alamat Input -------------------------------
                    TextFormField(
                      controller: controller.alamat,
                      // validator: AuthValidator.isNameValid,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                        hintText: "Alamat",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        // hintStyle: TextStyle(fontFamily: "PoppinsRegular")
                      ),
                    ),
                    // Email Input -------------------------------------
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.email,
                      keyboardType: TextInputType.emailAddress,
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
                        // hintStyle: TextStyle(fontFamily: "PoppinsRegular")
                      ),
                    ),
                    // Password Input -------------------------------------
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.password,
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
                        suffixIcon: GestureDetector(
                          onTap: () {
                            passwordSee = !passwordSee;
                            setState(() {});
                          },
                          child: Icon(
                            passwordSee
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                        hintStyle: TextStyle(fontFamily: "PoppinsRegular"),
                      ),
                    ),
                    // Retry Password Input -------------------------------------
                    const SizedBox(height: 20),
                    // TextFormField(
                    //   controller: passwordRetryController,
                    //   obscureText: passwordSee,
                    //   // validator: AuthValidator.isPasswordValid,
                    //   decoration: const InputDecoration(
                    //     enabledBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.grey),
                    //     ),
                    //     focusedBorder: UnderlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.green),
                    //     ),
                    //     contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                    //     hintText: "Konfirmasi Password",

                    //     // hintStyle: TextStyle(fontFamily: "PoppinsRegular"),
                    //   ),
                    // ),
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
                              borderRadius: BorderRadius.circular(15),
                            )),
                        child: const Text(
                          'Daftar',
                          style: TextStyle(
                            // fontFamily: "PoppinsRegular",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          String? regisResult =
                              await controller.createAccount();
                          if (regisResult == "sukses") {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SuccessConfirmationDialog(
                                  message: "Anda berhasil mendaftar",
                                  icon: Icons.check_circle_outline,
                                );
                              },
                            );
                            Get.offAll(
                                LoginPage()); // Pindah ke DashboardScreen setelah dialog sukses login
                          } else if (regisResult == "gagal") {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SuccessConfirmationDialog(
                                  message: "Anda gagal mendaftar",
                                  icon: Icons.close_rounded,
                                );
                              },
                            );
                          } else {
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SuccessConfirmationDialog(
                                  message: regisResult,
                                  icon: Icons.close_rounded,
                                );
                              },
                            );
                          }
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

  // when the button is pressed
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
