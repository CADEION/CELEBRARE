import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Image / Icon'),
        backgroundColor: Colors.white60,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.black87),
                shape: BoxShape.rectangle,
              ),
              child: Column(
                children: [
                  Text(
                    "Upload Image",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    onPressed: () => homeViewModel.pickCropAndMaskImage(context),
                    child: Text(
                      "Choose From Device",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            homeViewModel.image != null
                ? Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    child: Image.file(
                      File(homeViewModel.image!.path),
                      fit: BoxFit.fill,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
