import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/firebase/firebase_service.dart';
import 'package:flutter_dashboard/firebase/loading.dart';
import 'package:flutter_dashboard/splesh_screen.dart';
import 'package:flutter_dashboard/utils/functions.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Image.asset('assets/icons/profile/logo@2x.png', scale: 2),
              const SizedBox(width: 16),
              const Expanded(
                child: Text('Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              IconButton(
                iconSize: 28,
                icon: Image.asset('assets/icons/tabbar/light/more_circle@2x.png', scale: 2),
                onPressed: () async {

                  

                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Stack(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: CachedNetworkImageProvider(
                globalAuthModel.logo   
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  child: Image.asset('assets/icons/profile/edit_square@2x.png', scale: 2),
                  onTap: () async {
                    File ? file = await pickFile();
                    if(file != null){
                      Loading<String?>(
                        context, 
                        process: uploadImageToFirebase(file,toAdmin: true),
                        onSucess: (data) {
                          if(data != null){

                            globalAuthModel.logo = data;
                            FirebaseService.service.updateProfile();

                          }
                        },
                      ).executeProcess();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(globalAuthModel.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        const SizedBox(height: 8),
        Text(globalAuthModel.mobile, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 20),
        Container(
          color: const Color(0xFFEEEEEE),
          height: 1,
          padding: const EdgeInsets.symmetric(horizontal: 24),
        )
      ],
    );
  }
}
