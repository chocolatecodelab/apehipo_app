import 'package:apehipo_app/auth/login/login.dart';
import 'package:apehipo_app/auth/register/register_consumer.dart';
import 'package:apehipo_app/auth/register/register_hydroponic_farmer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RolePage extends StatefulWidget {
  static const String id = "role_page";
  const RolePage({super.key});

  @override
  State<RolePage> createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
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
                return LoginPage();
              },
            )),
          ),
          title: Text(
            'APEHIPO',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          // Ubah warna latar belakang di bawah ini
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              width: 100,
              height: 50,
            ),
            Column(
              children: [
                Container(),
                const Text(
                  "Peran kamu sebagai apa, nih?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF404653),
                    letterSpacing: 0.5,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => {
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (BuildContext context) {
                        return RegisterHydroponicFarmer();
                      },
                    )),
                  },
                  child: Image.asset(
                    "assets/images/role_hydroponic_farmer.jpg",
                    width: 300,
                    height: 250,
                  ),
                ),
                const Text(
                  "Petani Hidroponik",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF404653),
                    letterSpacing: 0.5,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => {
                    Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (BuildContext context) {
                        return RegisterConsumer();
                      },
                    )),
                  },
                  child: Image.asset(
                    "assets/images/role_consumer.jpg",
                    width: 300,
                    height: 200,
                  ),
                ),
                const Text(
                  "Konsumen",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF404653),
                    letterSpacing: 0.5,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
