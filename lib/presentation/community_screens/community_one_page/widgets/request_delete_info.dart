import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart' as provider;
import 'package:tellesports/core/app_export.dart';
import 'package:tellesports/utils/loader.dart';

import '../../../../widgets/modal_content.dart';
import '../../../../widgets/modals.dart';
import '../../provider/auth_provider.dart' as pro;

// ignore: must_be_immutable
class RequestDeleteInfo extends StatefulWidget {
  final String name;
  final String image;
  final String bio;
  final int index;
  final String userId;
  final bool isDelete;
  const RequestDeleteInfo(
      {Key? key,
      required this.name,
      required this.bio,
      required this.index,
      required this.image,
      required this.isDelete,
      required this.userId})
      : super(
          key: key,
        );

  @override
  State<RequestDeleteInfo> createState() => _RequestDeleteInfoState();
}

class _RequestDeleteInfoState extends State<RequestDeleteInfo> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final groupInfo =
        provider.Provider.of<pro.AuthProviders>(context, listen: true);

    return (isLoading)
        ? Loader()
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.image != null ||
                  widget.image != "null" ||
                  widget.image != "") ...[
                CustomImageView(
                  imagePath: ImageConstant.imgAvatar,
                  height: 50.adaptSize,
                  width: 50.adaptSize,
                  radius: BorderRadius.circular(
                    18.h,
                  ),
                  margin: EdgeInsets.symmetric(vertical: 4.v),
                ),
              ] else ...[
                CustomImageView(
                  imagePath: widget.image,
                  placeHolder: ImageConstant.imgAvatar,
                  height: 50.adaptSize,
                  width: 50.adaptSize,
                  radius: BorderRadius.circular(
                    18.h,
                  ),
                  margin: EdgeInsets.symmetric(vertical: 4.v),
                ),
              ],
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10.h),
                  padding: EdgeInsets.only(
                    top: 14.v,
                    bottom: 14.v,
                  ),
                  decoration: AppDecoration.outlineGray,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                
                                color: appTheme.gray900,
                                fontSize: 14.fSize,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 2.v),
                            Text(
                              widget.bio,
                               maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: appTheme.gray600,
                                fontSize: 12.fSize,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (widget.isDelete) ...[
                        GestureDetector(
                          onTap: () {
                            Modals.showDialogModal(context,
                                page: ModalContentScreen(
                                    title: 'Unblock This User',
                                    body: Text(
                                                                                      'N.B: Are you sure you want to Unblock this user?',





                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: appTheme.gray900,
                  fontSize: 14.fSize,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
                                    btnText: 'Proceed',
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await groupInfo
                                          .removeCurrentUserFromBlockedMembers(
                                              groupInfo.groupId,
                                              widget.userId,
                                              context);

                                      setState(() {
                                        isLoading = true;
                                      });
                                    },
                                    headerColorOne:
                                        Color.fromARGB(255, 208, 151, 151),
                                    headerColorTwo:
                                        Color.fromARGB(255, 234, 132, 132)));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),

                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20)),
                            height: 40,
                            child: Align(
                                child: Text(
                              'Accept',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        )
                      ] else ...[
                        GestureDetector(
                          onTap: () {
                            Modals.showDialogModal(context,
                                page: ModalContentScreen(
                                    title: 'Accept Request',
                                    body: Text(
                                                                                                                             'N.B: Are you sure you want to Accept this users request',






                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: appTheme.gray900,
                  fontSize: 14.fSize,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
                                    btnText: 'Proceed',
                                    onPressed: () async {
                                      Navigator.pop(context);

                                      for (var userIds
                                          in groupInfo.requestedMembers) {
                                        if (userIds == widget.userId) {
                                          Modals.showToast(
                                              'User is already in your commiunity.');
                                          break;
                                        } else {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await groupInfo
                                              .removeCurrentUserFromRequestsMembers(
                                                  groupInfo.groupId,
                                                  widget.userId,
                                                  context);

                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      }
                                    },
                                    headerColorOne: Colors.blue.shade300,
                                    headerColorTwo: Colors.blue));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20)),
                            height: 40,
                            child: Align(
                                child: Text(
                              'Accept',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        )
                      ]
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
