import 'package:apehipo_app/modules/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifikasi",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
              Navigator.of(context).pop();
          },
        ),
      ),
      body: ListViewMethod(),
    );
  }

  Widget ListViewMethod() {
    return ListView.separated(
      itemCount: 15,
      separatorBuilder: (context, index) {
        return ListViewItem(index);
      },
      itemBuilder: (context, index) {
        return Divider(
          height: 0,
        );
      },
    );
  }

  Widget ListViewItem(int index) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          prefixIcon(),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message(index),
                  timeAndDate(index),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget prefixIcon() {
    return Container(
      height: 50,
      width: 50,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
      ),
      child: Icon(
        Icons.notifications_outlined,
        size: 25,
        color: Colors.black,
      ),
    );
  }

  Widget message(int index) {
    double textSize = 14;
    return Container(
      child: RichText(
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
              text: "Pesanan #183729 sudah sampai, nih!",
              style: TextStyle(
                fontSize: textSize,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                    text: "\nSegera konfirmasi pesananmu melalui menu transaksi, ya!",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ))
              ])),
    );
  }

  Widget timeAndDate(int index) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '23-01-2023',
            style: TextStyle(
              fontSize: 10,
            ),
          ),
          Text(
            '07:00 AM',
            style: TextStyle(
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
