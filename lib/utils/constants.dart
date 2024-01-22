import 'package:flutter/material.dart';
import 'package:peerprep2/screens/profile/profile_screen.dart';

class Constants {
  static String appName = "PeerPrep";
  static String userImageDefault =
      'https://firebasestorage.googleapis.com/v0/b/peerprep-868cb.appspot.com/o/default%20pfp.png?alt=media&token=d7af3e9d-a3aa-473d-9b0e-7346ed6f15e2';
      
  static const pagePadding =
      EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0);

  static const webScreenSize = 600;

  static final List<Widget> homeScreenItems = [
    //const DiscoverScreen(),
    //const GoalsScreen(),
    const ProfileScreen(
      //profileId: FirebaseAuth.instance.currentUser!.uid,
    ),
  ];  
  static IconData getLockerIcon({required bool private}) {
    return private ? Icons.lock_outline_rounded : Icons.lock_open_outlined;
  }

  
}