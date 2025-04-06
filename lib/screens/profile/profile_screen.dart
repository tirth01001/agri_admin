import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/auth/login/login.dart';
import 'package:flutter_dashboard/firebase/firebase_service.dart';
import 'package:flutter_dashboard/firebase/loading.dart';
import 'package:flutter_dashboard/firebase/shared_pref_service.dart';
import 'package:flutter_dashboard/model/auth_model.dart';
import 'package:flutter_dashboard/routes.dart';
import 'package:flutter_dashboard/screens/profile/header.dart';
import 'package:flutter_dashboard/screens/profile/setting/edit_address.dart';
import 'package:flutter_dashboard/screens/profile/setting/edit_profile.dart';
import 'package:flutter_dashboard/screens/profile/setting/notification_screen.dart';
import 'package:flutter_dashboard/screens/profile/setting/payment_setting.dart';
import 'package:flutter_dashboard/screens/profile/setting/privacy_setting.dart';
import 'package:flutter_dashboard/screens/profile/setting/reports_user.dart';
import 'package:flutter_dashboard/screens/profile/setting/security_setting.dart';
import 'package:flutter_dashboard/splesh_screen.dart';
import 'package:flutter_dashboard/widget/button.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

typedef ProfileOptionTap = void Function();

class ProfileOption {
  String title;
  String icon;
  Color? titleColor;
  ProfileOptionTap? onClick;
  Widget? trailing;

  ProfileOption({
    required this.title,
    required this.icon,
    this.onClick,
    this.titleColor,
    this.trailing,
  });

  ProfileOption.arrow({
    required this.title,
    required this.icon,
    this.onClick,
    this.titleColor = const Color(0xFF212121),
    this.trailing = const Image(image: AssetImage('assets/icons/profile/arrow_right@2x.png'), width: 24, height: 24),
  });
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static String route() => '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static _profileIcon(String last) => 'assets/icons/profile/$last';

  bool _isDark = false;

  get datas => <ProfileOption>[
        ProfileOption.arrow(
          title: 'Edit Profile', 
          icon: _profileIcon('user@2x.png'),
          onClick: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) => const EditProfileScreen()));
          }
        ),
        ProfileOption.arrow(
          title: 'Adress', 
          icon: _profileIcon('location@2x.png'),
          onClick: (){

            Navigator.push(context, MaterialPageRoute(builder: (context) => const EditLocationScreen()));
          }
        ),
        
        ProfileOption.arrow(
          title: 'Notification', 
          icon: _profileIcon('notification@2x.png'),
          onClick: (){

            Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminNotificationSettings()));
          }
        ),
        
        ProfileOption.arrow(
          title: 'Payment', 
          icon: _profileIcon('wallet@2x.png'),
          onClick: (){

            Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPaymentSettings()));
          }
        ),

        ProfileOption.arrow(
          title: 'Security', 
          icon: _profileIcon('shield_done@2x.png'),
          onClick: (){

            Navigator.push(context, MaterialPageRoute(builder: (context) => AdminSecuritySettings()));
          }
        ),
        // _languageOption(),
        // _darkModel(),
        ProfileOption.arrow(
          title: 'Analytics & Reports', 
          icon: _profileIcon('info_square@2x.png'),
          onClick: (){

            Navigator.push(context, MaterialPageRoute(builder: (context) => AdminAnalyticsReports()));
          }

        ),
        ProfileOption.arrow(
          title: 'Privacy Settings', 
          icon: _profileIcon('user@2x.png'),
          onClick: (){

            Navigator.push(context, MaterialPageRoute(builder: (context)=> PrivacyPolicyScreen()));
          }
        ),
        ProfileOption(
          onClick: () {

            
            showDialog(
              context: context, 
              builder: (context)=> AlertDialog(
                content: Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Are you sure to log out !"),
                      const SizedBox(height: 20,),
                      Button(
                        width: 120,
                        height: 40,
                        text: "Log out",
                        prefixIcon: const Icon(IconlyBold.logout,color: Colors.white,),
                        onTap: (){
                          SharedPrefService.service.saveUserLogData(AuthModel.empty());
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LoginScreen()), (routes)=>false);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
            // Loading(
            //   context, 
            //   process: FirebaseService.service.delay(),
            //   onSucess: (data) {
            //   },
            // ).executeProcess();

          },
          title: 'Logout',
          icon: _profileIcon('logout@2x.png'),
          titleColor: const Color(0xFFF75555),
        ),
      ];

  // _languageOption() => ProfileOption(
  //     title: 'Language',
  //     icon: _profileIcon('more_circle@2x.png'),
  //     trailing: SizedBox(
  //       width: 150,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         children: [
  //           const Text(
  //             'English (US)',
  //             style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Color(0xFF212121)),
  //           ),
  //           const SizedBox(width: 16),
  //           // CachedNetworkImage(
  //           //   imageUrl: globalAuthModel,
  //           // )
  //           Image.asset('assets/icons/profile/arrow_right@2x.png', scale: 2)
  //         ],
  //       ),
  //     ));

  // _darkModel() => ProfileOption(
  //     title: 'Dark Mode',
  //     icon: _profileIcon('show@2x.png'),
  //     trailing: Switch(
  //       value: _isDark,
  //       activeColor: const Color(0xFF212121),
  //       onChanged: (value) {
  //         setState(() {
  //           _isDark = !_isDark;
  //         });
  //       },
  //     ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverList(
            delegate: SliverChildListDelegate.fixed([
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: ProfileHeader(),
              ),
            ]),
          ),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 10.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final data = datas[index];
            return _buildOption(context, index, data);
          },
          childCount: datas.length,
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, int index, ProfileOption data) {
    return ListTile(
      leading: Image.asset(data.icon, scale: 2),
      title: Text(
        data.title,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: data.titleColor),
      ),
      trailing: data.trailing,
      onTap: data.onClick,
    );
  }
}
