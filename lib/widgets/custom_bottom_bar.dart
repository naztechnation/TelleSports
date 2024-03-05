import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/widgets/modals.dart';

import '../handlers/secure_handler.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(int)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgNavConvert,
      activeIcon: ImageConstant.imgNavConvert,
      title: "Convert",
      type: BottomBarEnum.Convert,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavCommunity,
      activeIcon: ImageConstant.imgNavCommunity,
      title: "Community",
      type: BottomBarEnum.Community,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavPredictions,
      activeIcon: ImageConstant.imgNavPredictions,
      title: "Predictions",
      type: BottomBarEnum.Predictions,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavProfile,
      activeIcon: ImageConstant.imgNavProfile,
      title: "Profile",
      type: BottomBarEnum.Profile,
    )
  ];

  String image = '';

  getUserPhoto()async{
    image =   await  StorageHandler.getUserPhoto() ?? '';

  }

  @override
  void initState() {
     getUserPhoto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96.v,
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[0].icon,
                  height: 40.adaptSize,
                  width: 40.adaptSize,
                  color: appTheme.gray50001,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.v),
                  child: Text(
                    bottomMenuList[0].title ?? "",
                    style: CustomTextStyles.labelLargeGray50001.copyWith(
                      color: appTheme.gray50001,
                    ),
                  ),
                ),
              ],
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[0].activeIcon,
                  height: 40.adaptSize,
                  width: 40.adaptSize,
                  color: theme.colorScheme.primary,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.v),
                  child: Text(
                    bottomMenuList[0].title ?? "",
                    style: CustomTextStyles.labelLargePrimary.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[1].icon,
                  height: 40.adaptSize,
                  width: 40.adaptSize,
                  color: appTheme.gray50001,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.v),
                  child: Text(
                    bottomMenuList[1].title ?? "",
                    style: CustomTextStyles.labelLargeGray50001.copyWith(
                      color: appTheme.gray50001,
                    ),
                  ),
                ),
              ],
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[1].activeIcon,
                  height: 40.adaptSize,
                  width: 40.adaptSize,
                  color: Colors.blue,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.v),
                  child: Text(
                    bottomMenuList[1].title ?? "",
                    style: CustomTextStyles.labelLargePrimary.copyWith(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[2].icon,
                  height: 40.adaptSize,
                  width: 40.adaptSize,
                  color: appTheme.gray50001,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.v),
                  child: Text(
                    bottomMenuList[2].title ?? "",
                    style: CustomTextStyles.labelLargeGray50001.copyWith(
                      color: appTheme.gray50001,
                    ),
                  ),
                ),
              ],
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[2].activeIcon,
                  height: 40.adaptSize,
                  width: 40.adaptSize,
                  color: theme.colorScheme.primary,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.v),
                  child: Text(
                    bottomMenuList[2].title ?? "",
                    style: CustomTextStyles.labelLargePrimary.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CustomImageView(
                    imagePath: (image == '' || image == 'null' || image == null) ? bottomMenuList[3].icon :  image,
                    height: 40.adaptSize,
                    width: 40.adaptSize,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.v),
                  child: Text(
                    bottomMenuList[3].title ?? "",
                    style: CustomTextStyles.labelLargeGray50001.copyWith(
                      color:  appTheme.gray50001,
                    ),
                  ),
                ),
              ],
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: theme.colorScheme.primary, width: 2, ), borderRadius: BorderRadius.circular(30)),
                    child: CustomImageView(
                      imagePath: (image == '' || image == 'null' || image == null) ? bottomMenuList[3].icon :  image,
                      height: 40.adaptSize,
                      width: 40.adaptSize,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.v),
                  child: Text(
                    bottomMenuList[3].title ?? "",
                    style: CustomTextStyles.labelLargePrimary.copyWith(
                      color:   theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            label: '',
          ),
        ],
        onTap: (index) {
          selectedIndex = index;
            widget.onChanged?.call(index);
          setState(() {});

        },
      ),
    );
  }
}

enum BottomBarEnum {
  Convert,
  Community,
  Predictions,
  Profile,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
  });

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}

class DefaultWidge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
