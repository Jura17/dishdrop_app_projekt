import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dishdrop_app_projekt/core/theme/app_theme.dart';

import 'package:dishdrop_app_projekt/data/provider/recipe_notifier.dart';
import 'package:dishdrop_app_projekt/data/provider/shopping_list_notifier.dart';
import 'package:dishdrop_app_projekt/data/repositories/auth/auth_repository.dart';
import 'package:dishdrop_app_projekt/data/repositories/auth/firebase_auth_repository.dart';
import 'package:dishdrop_app_projekt/data/repositories/auth/firestore_user_repository.dart';
import 'package:dishdrop_app_projekt/data/repositories/auth/user_repository.dart';

import 'package:dishdrop_app_projekt/data/repositories/objectbox.dart';
import 'package:dishdrop_app_projekt/data/repositories/objectbox_database.dart';

import 'package:dishdrop_app_projekt/firebase_options.dart';

import 'package:dishdrop_app_projekt/main_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final AuthRepository authRepository = FirebaseAuthRepository(auth);
  final UserRepository userRepository = FirestoreUserRepository(firestore);

  final objectbox = await ObjectBox.create();
  final db = ObjectboxDatabase(objectbox.store);

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthRepository>.value(value: authRepository),
        Provider<UserRepository>.value(value: userRepository),
        ChangeNotifierProvider(create: (_) => RecipeNotifier(db)),
        ChangeNotifierProvider(create: (_) => ShoppingListNotifier(db)),
      ],
      child: MainApp(),
    ),
  );
}
