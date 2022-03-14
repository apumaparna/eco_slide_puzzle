// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'firebase_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:eco_slide_puzzle/app/app.dart';
import 'package:eco_slide_puzzle/bootstrap.dart';
// import 'package:eco_slide_puzzle/image preprocessing/splitImage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (error) {
    print(error);
  }

  bootstrap(() => const App());
}

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   splitImage('assets/images/gorilla.jpg', 4);
// }
