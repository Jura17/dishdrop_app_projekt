import 'package:dishdrop_app_projekt/core/theme/app_colors.dart';
import 'package:dishdrop_app_projekt/data/repositories/auth/auth_repository.dart';
import 'package:dishdrop_app_projekt/data/repositories/auth/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool showSignUp = false;
  bool isLoggedIn = false;
  late AuthRepository authRepo;
  late UserRepository userRepo;
  User? user;

  @override
  void initState() {
    authRepo = Provider.of<AuthRepository>(context, listen: false);
    userRepo = Provider.of<UserRepository>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            StreamBuilder<User?>(
              stream: authRepo.onAuthChanged() as Stream<User?>,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  user = snapshot.data!;
                  return Container(
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
                            "Account",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text("You're logged in as ${user!.email}."),
                          ElevatedButton(
                            onPressed: () {
                              authRepo.logOut();
                            },
                            child: Text("Logout"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Remove recipe?"),
                                    content: Text(
                                      "Are you sure you want to delete your account? Any data saved on your device won't be affected by this.",
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    actions: [
                                      TextButton(
                                        style: ButtonStyle(
                                          foregroundColor: WidgetStateColor.resolveWith(
                                            (states) => AppColors.dishDropBlack,
                                          ),
                                        ),
                                        onPressed: () async {
                                          await user!.delete();
                                        },
                                        child: Text("Yes"),
                                      ),
                                      TextButton(
                                        style: ButtonStyle(
                                          foregroundColor: WidgetStateColor.resolveWith(
                                            (states) => AppColors.dishDropBlack,
                                          ),
                                        ),
                                        onPressed: () => Navigator.of(context).pop(),
                                        child: Text("Cancel"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text("Delete account"),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return Container(
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
                          "Account",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text("${showSignUp ? "Sign up" : "Login"} to backup your data online."),
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
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Row(
                          children: [
                            showSignUp
                                ? ElevatedButton(
                                    onPressed: () {
                                      authRepo.registerWithEmailPassword(emailController.text, passwordController.text);
                                    },
                                    child: Text("Sign Up"),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      authRepo.signInWithEmailPassword(emailController.text, passwordController.text);
                                    },
                                    child: Text("Login"),
                                  ),
                            SizedBox(width: 20),
                            TextButton(
                              onPressed: () {
                                showSignUp = !showSignUp;
                                setState(() {});
                              },
                              child: Text(
                                showSignUp ? "Already signed up?\nTap here to login." : "No account yet? Sign up here.",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
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
