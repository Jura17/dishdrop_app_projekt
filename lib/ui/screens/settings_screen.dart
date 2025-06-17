// - Light/Dark mode
// - Checkbox: Sync data with cloud automatically (whenever changes occur)
// - Sync-Now button to manually trigger a sync
// - Logout button
import 'package:dishdrop_app_projekt/data/repositories/auth/auth_repository.dart';
import 'package:dishdrop_app_projekt/data/repositories/auth/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authRepo = Provider.of<AuthRepository>(context, listen: false);
    final userRepo = Provider.of<UserRepository>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "App Theme",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Row(
                      children: [
                        Text("Toggle theme"),
                        SizedBox(width: 10),
                        Switch.adaptive(value: false, onChanged: (newValue) {}),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      "Sign up",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text("Create an account to backup your data online."),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email Address",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          authRepo.registerWithEmailPassword(emailController.text, passwordController.text);
                        },
                        child: Text("Sign up"))
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Cloud Backup & Sync",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Row(
                      children: [
                        Text("Always sync changes"),
                        SizedBox(width: 10),
                        Switch.adaptive(value: true, onChanged: (newValue) {}),
                      ],
                    ),
                    ElevatedButton(onPressed: () {}, child: Text("Synchronize now")),
                    ElevatedButton(onPressed: () {}, child: Text("Delete account"))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
