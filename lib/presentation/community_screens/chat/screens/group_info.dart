import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tellesports/handlers/secure_handler.dart';
import 'package:tellesports/widgets/modals.dart';
import 'package:uuid/uuid.dart';

import '../../provider/auth_provider.dart'  as pro;

// import '../../../provider/auth_provider.dart' as pro;

class GroupInfoScreen extends StatefulWidget {
  static const String routeName = '/group-info-screen';
  final String profilePic;
  final String name;

  GroupInfoScreen({super.key, required this.profilePic, required this.name});

  @override
  State<GroupInfoScreen> createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen> {
  bool _value = true;

   String userId = '';
  getUserId()async{

userId = await StorageHandler.getUserId() ?? '';
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    final groupInfo = Provider.of<pro.AuthProviders>(context, listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   
                 GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                   child: const Padding(
                      padding:   EdgeInsets.only(left: 14.0),
                      child:  Icon(Icons.arrow_back),
                    ),
                 ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.profilePic,
                    ),
                    radius: 70,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              widget.name,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Group . ${groupInfo.groupNumber} participants',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 30,
            ),
         if(groupInfo.groupMembers[0].uid ==  userId)   Column(children: [
               const Divider(
              color: Colors.blueGrey,
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Mute Group'),
                trailing: CupertinoSwitch(
                    value: groupInfo.isGroupLocked,
                    onChanged: (newValue) => setState(() {
                      groupInfo.updateGroupLockStatus(groupInfo.groupId, newValue);
                    } )),
              ),
            ),
            const Divider(
              color: Colors.blueGrey,
            ),
             Card(
              child: ListTile(
                leading:const Icon(Icons.link),
                title: SelectableText(groupInfo.groupLink, 
                style:const TextStyle(decoration: TextDecoration.underline,color: Colors.green, fontSize: 17),),
                trailing:GestureDetector(
                  onTap: (){
                    var groupLink = const Uuid().v4();
                    groupInfo.updateGroupLink(groupInfo.groupId, groupLink);
                  },
                  child: const Icon(Icons.restore_page)),
              ),
            ),
            const Divider(
              color: Colors.blueGrey,
            ),
            ],),
           
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${groupInfo.groupNumber} participants',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: groupInfo.groupMembers.length,
              itemBuilder: ( context, index){
             return  ListTile(leading:  CircleAvatar(
                          backgroundImage: NetworkImage(
                            groupInfo.groupMembers[index].profilePic,
                          ),
                          radius: 20,
                        ),
                        title: Text(groupInfo.groupMembers[index].name),
                        trailing: (index == 0) ? const Text('Group Admin', style: TextStyle(color: Colors.green),) : const SizedBox.shrink(),
                        );
            }),
            
                         const Divider(
              color: Colors.blueGrey,
            ),
           GestureDetector(
            onTap: (){
             if(groupInfo.groupMembers[0].uid ==  userId) {
              Modals.showToast('you are an admin and can\'t leave the group');
              }else{
              groupInfo.removeCurrentUserFromMembers(groupInfo.groupId, userId, context);

              }
            },
             child: const Card(
                child: ListTile(
                  leading:   Icon(Icons.exit_to_app, color: Colors.white),
                  title:   Text('Exit group', style: TextStyle(color: Colors.white),),
                  trailing: Icon(Icons.delete, color: Colors.red)
                ),
              ),
           ),
                 const Divider(
              color: Colors.blueGrey,
            ),
       if(groupInfo.groupMembers[0].uid ==  userId)    GestureDetector(
            onTap: (){
              if(groupInfo.groupMembers[0].uid ==  userId) {
                              groupInfo.deleteGroup(groupInfo.groupId, context);

              }else{

              }
            },
             child: const Card(
                child: ListTile(
                  leading:   Icon(Icons.close, color: Colors.white),
                  title:   Text('Delete group', style: TextStyle(color: Colors.white),),
                  trailing: Icon(Icons.delete, color: Colors.red)
                ),
              ),
           ),
     if(groupInfo.groupMembers[0].uid ==  userId)       const Divider(
              color: Colors.blueGrey,
            ),
          ],
        ),
      ),
    );
  }
}
