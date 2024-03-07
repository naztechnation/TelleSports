import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tellesports/core/app_export.dart';

// ignore: must_be_immutable
class CommunityPageComponent extends StatelessWidget {
 final String groupName;
 final String lastMessage;
 final String groupPic;
 final String groupNumber;
 final DateTime date;
  CommunityPageComponent({
    Key? key,
    this.onTapCommunityPageComponent, required this.groupName, required this.lastMessage, required this.groupPic, required this.date, required this.groupNumber,
  }) : super(
          key: key,
        );

  VoidCallback? onTapCommunityPageComponent;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          onTapCommunityPageComponent!.call();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: groupPic,
              height: 60.adaptSize,
              width: 60.adaptSize,
              radius: BorderRadius.circular(
                30.h,
              ),
              margin: EdgeInsets.symmetric(vertical: 7.v),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10.h),
                padding: EdgeInsets.only(
                  top: 6.v,
                  bottom: 5.v,
                ),
                decoration: AppDecoration.outlineGray,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          groupName,
                          style: CustomTextStyles.titleMediumOnPrimary_1,
                        ),
                        SizedBox(height: 1.v),
                        Text(
                          lastMessage,
                          style: theme.textTheme.titleSmall,
                        ),
                        SizedBox(height: 1.v),
                        // Text(
                        //   "GIF",
                        //   style: CustomTextStyles.titleSmallGray600,
                        // ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 2.v,
                        bottom: 6.v,
                      ),
                      child: Column(
                        children: [
                          Text(
                           DateFormat('hh:mm a')
                                        .format(date),
                            style: CustomTextStyles.titleSmallGray600,
                          ),
                          SizedBox(height: 9.v),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 32.adaptSize,
                              height: 32.adaptSize,
                               
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFF3C91E5)),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Center(
                                  child: Text(
                                    "${groupNumber}",
                                    style: TextStyle(fontSize: 9, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
