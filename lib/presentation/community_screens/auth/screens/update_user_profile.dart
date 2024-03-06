

import 'dart:io';

 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:tellesports/utils/loader.dart';
import 'package:tellesports/widgets/modals.dart';

import '../../../../common/utils/colors.dart';
import '../../../../common/utils/utils.dart';
import '../../provider/auth_provider.dart';

 

class UpdateUserProfileScreen extends ConsumerStatefulWidget {
  static const String routeName = '/update-profile';
  const UpdateUserProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UpdateUserProfileScreen> createState() => _UpdateUserProfileScreenState();
}

class _UpdateUserProfileScreenState extends ConsumerState<UpdateUserProfileScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  File? image;

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  var userData;

  void retrieveUserProfile() async{
      final authUser = provider.Provider.of<AuthProviders>(context, listen: false);
    
   // retrieveUserProfile(authUser);
    final user = await authUser.retrieveUserData();

    userData =  user;

    userNameController.text = userData.name;
    emailController.text = userData.email;
  }

  void updateUserProfile() async{
      final authUser = provider.Provider.of<AuthProviders>(context, listen: false);

      await authUser.updateUserProfile();

      Modals.showToast(authUser.message);

    final user = await authUser.retrieveUserData();

    userData =  user;

  }

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
    
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      retrieveUserProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      final authUser = provider.Provider.of<AuthProviders>(context, listen: true);

  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Info'),
      ),
      body: (authUser.dataStatus == AuthState.loading) ? const Loader():   Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                authUser.image == null
                    ?   CircleAvatar(
                        backgroundImage: NetworkImage(
                          userData.profilePic ?? 'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png',
                        ),
                        radius: 64,
                      )
                    : CircleAvatar(
                        backgroundImage: FileImage(
                          authUser.image!,
                        ),
                        radius: 64,
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: ()=> authUser.loadImage(context),
                    icon: const Icon(
                      Icons.add_a_photo,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: userNameController,
                readOnly: true,

                decoration: const InputDecoration(
                  hintText: 'Username',
                ),
              ),
            ),
           const  SizedBox(height: 20,),
             Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: emailController,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
            ),
            // Container(
            //   alignment: Alignment.topLeft,
            //   padding: const EdgeInsets.all(8),
            //   child: const Text(
            //     'Select Contacts',
            //     style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            // ),
            // const SelectContactsGroup(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Update', style: TextStyle(color: Colors.white),),
       onPressed: (){
          updateUserProfile();
        },
        backgroundColor: tabColor,
        icon: const Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
    );
  }
}
