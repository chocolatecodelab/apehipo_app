import 'package:apehipo_app/auth/roles/role.dart';
import 'package:apehipo_app/modules/dashboard/dashboard_screen.dart';
import 'package:apehipo_app/splash/welcome_screen.dart';
import 'package:apehipo_app/widgets/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String id = "login_page";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _signInGlobalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
              onPressed: () =>
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) {
                  return WelcomeScreen();
                },
              )),
            ),
            title: Text(
              'APEHIPO',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
            centerTitle: true,
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          // Menggunakan SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset(
                  "assets/images/welcome.png",
                  width: 250,
                  height: 250,
                ),
                const Center(
                  child: Text(
                    "Selamat Datang!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                const Center(
                  child: Text(
                    "You've been missed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 25,
                          height: 25,
                          child: Image.asset("../assets/images/ic_google.png"),
                        ), // Tambahkan jarak horizontal antara ikon dan teks
                        Text(
                          '  Masuk dengan Google',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () => {},
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'atau',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 0),
                Form(
                  key: _signInGlobalKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        // validator: AuthValidator.isEmailValid,
                        decoration: const InputDecoration(
                          hintText: "Username",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        obscureText: passwordSee,
                        // validator: AuthValidator.isPasswordValid,
                        decoration: InputDecoration(
                          hintText: "Password",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () => {
                      Navigator.of(context)
                          .pushReplacement(new MaterialPageRoute(
                        builder: (BuildContext context) {
                          return DashboardScreen();
                        },
                      )),
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Text.rich(
                  TextSpan(
                    text: "Nggak punya akun? ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: "Daftar yuk!",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.of(context)
                                  .pushReplacement(new MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return RolePage();
                                },
                              )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ));
  }

  // void signIn() {
  //   if (_signInGlobalKey.currentState!.validate()) {
  //     final message = authController.login(
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
  //     if (message["next"] == "next") {
  //       AppWidget.isLogin = true;
  //       AppWidget.loggedUser["email"] = emailController.text.trim();
  //       AppWidget.loggedUser["password"] = passwordController.text.trim();
  //       Navigator.pushNamed(context, AdminPage.id);
  //     }
  //   }
  // }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
