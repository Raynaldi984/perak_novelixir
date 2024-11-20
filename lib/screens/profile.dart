import 'dart:io';
import 'package:perak_novelixir/models/api_response.dart';
import 'package:perak_novelixir/models/user.dart';
import 'package:perak_novelixir/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user;
  bool loading = true;
  File? _imageFile;
  final _picker = ImagePicker();
  final TextEditingController txtNameController = TextEditingController();
  final TextEditingController txtDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> getUser() async {
    ApiResponse response = await getUserDetail();
    if (response.error == null) {
      setState(() {
        user = response.data as User;
        loading = false;
        txtNameController.text = user?.name ?? '';
        txtDescriptionController.text =
            user?.description ?? 'Add your description here...';
      });
    } else {
      handleError(response.error);
    }
  }

  void handleError(String? error) {
    if (error == 'unauthorized') {
      logout().then((value) => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login()),
            (route) => false,
          ));
    } else {
      showSnackBar(error ?? 'An unknown error occurred.');
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> updateProfile() async {
    if (user == null) return;

    setState(() {
      loading = true;
    });

    ApiResponse response = await updateUser(
      txtNameController.text,
      getStringImage(_imageFile),
      description: txtDescriptionController.text,
    );
    setState(() {
      loading = false;
    });

    if (response.error == null) {
      showSnackBar('Profile updated successfully.');
    } else {
      handleError(response.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: getImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!)
                            : user?.image != null
                                ? NetworkImage(user!.image!)
                                : const AssetImage('assets/default_profile.png')
                                    as ImageProvider,
                        backgroundColor: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: txtNameController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Your Name',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: txtDescriptionController,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add a description about yourself...',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatColumn('Stories', '12'),
                        _buildStatColumn('Following', '256'),
                        _buildStatColumn('Followers', '1.2K'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: updateProfile,
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: const Text('Edit Profile'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(color: Colors.grey),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.orange),
                      title: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () => logout().then((_) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Login()),
                          (route) => false,
                        );
                      }),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
