import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/helper_methods/util_methods.dart';
import '../controllers/group_controller.dart';

class CreateGroupScreen extends ConsumerStatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  ConsumerState<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends ConsumerState<CreateGroupScreen> {
  late TextEditingController _groupNameController;
  Size? _size;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _groupNameController = TextEditingController();
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size ??= MediaQuery.of(context).size;

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFAB(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: Theme.of(context).iconTheme.copyWith(
            color: Colors.green,
          ),
      title: Text(
        'Create Group',
        style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
              color: Colors.grey,
              fontSize: 18.0,
            ),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: _size!.width * 0.90,
            height: _size!.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height:_size!.width * 0.03),
                _buildProfileImage(),
                SizedBox(height:_size!.width * 0.03),
                _buildNameTF(),
                SizedBox(height:_size!.width * 0.04),
                _buildSelectContactHeading(),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectContactHeading() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Select Contacts',
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: 18.0,
            ),
      ),
    );
  }

  Widget _buildNameTF() {
    return TextField(
      controller: _groupNameController,
      minLines: 1,
      maxLines: 1,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.group),
        hintText: 'Enter Group Name',
        hintStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Colors.grey,
              fontSize: _size!.width * 0.04,
              fontWeight: FontWeight.normal,
            ),
        isDense: true,
      ),
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: Colors.black,
            fontSize: _size!.width * 0.05,
          ),
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _imageFile != null
            ? CircleAvatar(
                backgroundImage: FileImage(_imageFile!),
                radius: _size!.width * 0.15,
                backgroundColor: Colors.white,
              )
            : CircleAvatar(
                backgroundImage:
                    const AssetImage('img_nav_profile_primary.png'),
                radius: _size!.width * 0.15,
                backgroundColor: Colors.white,
              ),
        Positioned(
          top: (_size!.width * 0.35) * 0.55,
          left: (_size!.width * 0.35) * 0.55,
          child: IconButton(
            onPressed: _selectImage,
            icon: Icon(
              Icons.add_a_photo,
              size: _size!.width * 0.075,
            ),
          ),
        ),
      ],
    );
  }

  void _selectImage() async {
    _imageFile = await pickImageFromGallery(context);
    setState(() {});
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: createGroup,
      child: const Icon(Icons.done),
    );
  }

  void createGroup() {
    if (_groupNameController.text.trim().isNotEmpty && _imageFile != null) {
      ref.read(groupControllerProvider).createGroup(
            context,
            mounted,
            groupName: _groupNameController.text.trim(),
            groupProfilePic: _imageFile!,
            
          );

      Navigator.pop(context);
    }
  }
}
