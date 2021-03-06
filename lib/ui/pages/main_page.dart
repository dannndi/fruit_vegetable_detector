import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruit_vegetable_detector/core/base/constant_variable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruit_vegetable_detector/core/provider/classify_provider.dart';
import 'package:fruit_vegetable_detector/ui/widgets/pick_image.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MainPage extends StatelessWidget {
  //* variable
  File _image;
  @override
  Widget build(BuildContext context) {
    //* tool bar UI
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Row(
            children: [
              Container(
                child: Text(
                  'Fruit',
                  style: Const.styleHeader.copyWith(color: Colors.white),
                ),
              ),
              SizedBox(width: 3),
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Detector',
                  style: Const.styleHeader.copyWith(
                    color: Const.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info, color: Colors.white),
            onPressed: () {},
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Const.primaryColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 30),
          color: Colors.transparent,
          child: Consumer<ClassifyProvider>(
            builder: (context, classifyProvider, _) {
              if (classifyProvider.state == ClassifyState.Idle) {
                return _idle(context);
              } else if (classifyProvider.state == ClassifyState.Scanning) {
                return _scanning(context);
              } else if (classifyProvider.state == ClassifyState.Complete) {
                return _result(
                  context: context,
                  image: _image,
                  result: classifyProvider.result,
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Consumer<ClassifyProvider>(
        builder: (context, classifyProvider, _) {
          if (classifyProvider.state == ClassifyState.Idle) {
            return _buttonScan(context);
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget _buttonScan(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pickImage(context);
      },
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'SCAN NOW',
            style: Const.styleHeader.copyWith(
              color: Const.primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _idle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 200,
          child: SvgPicture.asset('assets/images/detective.svg'),
        ),
        Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cara menggunakan aplikasi :',
                style: Const.styleHeader.copyWith(color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                "1. Tekan tombol 'Scan Now'\n2. Pilih lokasi gambar \n3. Enjoy.. ",
                style: Const.styleSubTitle.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _scanning(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 200,
          child: SvgPicture.asset('assets/images/scanning.svg'),
        ),
        Container(
          margin: EdgeInsets.only(top: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Const.blackColor.withOpacity(0.1),
                child: Text(
                  'Scanning...',
                  style: Const.styleTitle.copyWith(
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _result({BuildContext context, File image, String result}) {
    return Container(
      height: Const.screenHeight(context) * 0.6,
      width: Const.screenWidth(context) - 60,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Result',
            style: Const.styleHeader,
          ),
          Divider(),
          Container(
            height: 160,
            margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Const.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image(
              fit: BoxFit.cover,
              image: FileImage(image),
            ),
          ),
          Text(
            result ?? 'Tidak di ketahui',
            style: Const.styleTitle.copyWith(
              color: Const.primaryColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            result != null
                ? 'Detective mengatakan ini adalah $result, cari tau kembali jika di rasa kurang tepat.'
                : 'Detective tidak mengetahui jenis buah ini, cari tau kembali dengan gambar yang lain.',
            style: Const.styleSubTitle.copyWith(
              color: Const.grayColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 60),
          SizedBox(
            height: 50,
            width: 200,
            child: FlatButton(
              color: Const.primaryColor,
              child: Text(
                'SCAN AGAIN',
                style: Const.styleTitle.copyWith(color: Colors.white),
              ),
              onPressed: () {
                _pickImage(context);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _pickImage(BuildContext context) async {
    final classifyProvider = Provider.of<ClassifyProvider>(
      context,
      listen: false,
    );

    print('kesisni');

    await pickImage(
      context: context,
      image: (image) {
        _image = image;

        if (_image != null) {
          print('scanning');
          classifyProvider.scanOnImage(_image);
        }
      },
    );
  }
}
