import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fruit_vegetable_detector/core/base/constant_variable.dart';
import 'package:fruit_vegetable_detector/core/services/base_services.dart';

Future<void> pickImage({
  @required BuildContext context,
  @required void Function(File image) image,
}) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Image Location",
                style: Const.styleTitle,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    child: Column(
                      children: [
                        IconButton(
                          iconSize: 50,
                          icon: Icon(
                            Icons.camera,
                            color: Const.primaryColor,
                          ),
                          onPressed: () async {
                            image(
                              await BaseServices.pickImage(PickType.Camera),
                            );
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          'Camera',
                          style: Const.styleTitle,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    child: Column(
                      children: [
                        IconButton(
                          iconSize: 50,
                          icon: Icon(
                            Icons.photo,
                            color: Const.primaryColor,
                          ),
                          onPressed: () async {
                            image(
                              await BaseServices.pickImage(PickType.Galerry),
                            );
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          'Galerry',
                          style: Const.styleTitle,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
