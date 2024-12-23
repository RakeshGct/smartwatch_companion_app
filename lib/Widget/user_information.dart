import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_sync/Provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    final User? user = FirebaseAuth.instance.currentUser;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    Text('Welcome ! \n${profileProvider.name}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        Text(
          '${user?.email ?? 'Unknown'}',
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
