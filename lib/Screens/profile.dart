import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_sync/Provider/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  final String userId = 'sampleUserId'; // Replace with authenticated user's ID

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    // Load profile when the screen is built
    profileProvider.loadProfile(userId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("User Details", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue),)),
            TextField(
              controller: _nameController..text = profileProvider.name,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController..text = profileProvider.age.toString(),
              decoration: InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            Row(
              spacing: 30,
              children: [
                Text("Gender : "),
                DropdownButton<String>(
                  value: profileProvider.gender.isEmpty
                      ? null
                      : profileProvider.gender,
                  hint: Text('Select Gender'),
                  items: ['Male', 'Female', 'Other']
                      .map((gender) => DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      profileProvider.saveProfile(
                          userId,
                          _nameController.text,
                          int.tryParse(_ageController.text) ?? 0,
                          value);
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  profileProvider.saveProfile(
                    userId,
                    _nameController.text,
                    int.tryParse(_ageController.text) ?? 0,
                    profileProvider.gender,
                  );
                },
                child: Text('Save Profile'),
              ),
            ),
            /*SizedBox(height: 20),
            Text(
              'Profile Details:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text('Name: ${profileProvider.name}'),
            Text('Age: ${profileProvider.age}'),
            Text('Gender: ${profileProvider.gender}'),

             */
          ],
        ),
      ),
    );
  }
}
