import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/screens/profile/profile_screen.dart';
import 'package:flutter_dashboard/splesh_screen.dart';

class HomeAppBar extends StatelessWidget {

  final String balance;
  const HomeAppBar({super.key,this.balance=""});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            onTap: () => Navigator.pushNamed(context, ProfileScreen.route()),
            child: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                globalAuthModel.logo
              ),
              radius: 24,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Good Morning 👋',
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    globalAuthModel.name,
                    style: const TextStyle(
                      color: Color(0xFF212121),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
          Text("Rs. $balance",style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),),
          // IconButton(
          //   iconSize: 28,
          //   icon: Image.asset('$kIconPath/notification.png'),
          //   onPressed: () {

          //     Loading(
          //       context, 
          //       process: insertFakeSummary()
          //     ).executeProcess();

          //   },
          // ),
          // const SizedBox(width: 16),
          // IconButton(
          //   iconSize: 28,
          //   icon: Image.asset('$kIconPath/light/heart@2x.png'),
          //   onPressed: () {},
          // ),
        ],
      ),
    );
  }
}
