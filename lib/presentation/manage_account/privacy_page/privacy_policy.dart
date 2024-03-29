import 'dart:io';
 
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter/material.dart';
 
import '../../../res/app_strings.dart';
import 'custom_toogle.dart';

class TermsOfUsePage extends StatefulWidget {
  final bool isUserAcceptPage;
  const TermsOfUsePage({Key? key, this.isUserAcceptPage = false})
      : super(key: key);

  @override
  State<TermsOfUsePage> createState() => _TermsOfUsePageState();
}

class _TermsOfUsePageState extends State<TermsOfUsePage> {
  late PageController _controller;
  int initCount = 0;

  bool btnState = false;

  double scrollExtent = 0.0;

  @override
  void initState() {
    super.initState();


    _controller = PageController(
      initialPage: 0,
    );

  }

   

  

   

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      initCount = index;
    });
  }

  void onFilterSelected(int index) {
    setState(() {
      _controller.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Theme.of(context!).colorScheme.primary, 
        child: Icon(Icons.close, color: Colors.white, size: 29,),
      ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: CustomToggle(
                  height: 70,
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  selectedColor: Colors.white,
                  title: const [
                    'Privacy Policy',
                    'T&Cs',
                  ],
                  onSelected: onFilterSelected,
                ),
              ),
              Expanded(
                  child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                controller: _controller,
                onPageChanged: _onPageChanged,
                children: [
                  privacyPolicyContent(),
                  termsContent(),
                ],
              )),
            ],
          ),
        ),
       
        );
  }

  termsContent() {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(10.0),
      children: <Widget>[
        const SizedBox(
          height: 20.0,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'Last updated March 29, 2024',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context!).colorScheme.primary),
            )),
        const SizedBox(
          height: 20.0,
        ),
        _buildStep(
            leadingTitle: "-",
            context: context,
            title: "Tellasport Terms and Conditions".toUpperCase(),
            content: AppStrings.TERMS_SERVICE),
        
      ],
    );
  }

  privacyPolicyContent() {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification.metrics.atEdge) {
            if (notification.metrics.pixels == 0) {
              setState(() {
                btnState = false;
              });
            } else {
              setState(() {
                btnState = true;
              });
            }
          }
          return true;
        },
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  _buildStep(
                      leadingTitle: "-",
                      context: context,
                      title: "Tellasport Privacy Policy".toUpperCase(),
                      content: AppStrings.PRIVACY),
                ],
              ),
            ),
          ],
        ));
  }
}

normalText({String? title}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Text(title!,
        textAlign: TextAlign.justify,
        style: const TextStyle(
            height: 1.7,
            color: Colors.white60,
            fontSize: 16.0,
            fontWeight: FontWeight.w500)),
  );
}

Widget _buildStep(
    {String? leadingTitle,
    String? title,
    String? content,
    double padding = 5,
    BuildContext? context}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Material(
            color: Theme.of(context!).colorScheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Text(leadingTitle!,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Flexible(
            child: Text(title!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.black,
                )),
          )
        ],
      ),
      const SizedBox(
        height: 10.0,
      ),
      Visibility(
        visible: (content != ''),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(content!,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  height: 1.7,
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500)),
        ),
      ),
    ],
  );
}
