import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectmanagement/firebase_options.dart';
import 'package:projectmanagement/navigation/navigation_view.dart';
import 'package:projectmanagement/utils/providers.dart';
import 'package:projectmanagement/views/auth/sign_in/sign_in_page_view.dart';
import 'package:provider/provider.dart';

void main() async {
  //Uygulama başlatılırken Firebase'i başlatıyoruz
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Ekranın yönünü dikey olarak sabitliyoruz

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // Provider'ları kullanmak için MultiProvider'ı kullanıyoruz
  runApp(MultiProvider(
    providers: providers, //Providerları tutmak için ayrı bir liste olusturduk.
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //User? firebaseUser = FirebaseAuth.instance.currentUser;
    Widget firstWidget;

    //giriş yapmıs bir kullanıcı varsa direkt uygulamaya,
    //kullanıcı yoksa giriş yap ekranına yönlendiriyoruz.
    //SplashScreen --> HomePage veya SingInPage --> HomePage
    
    if (FirebaseAuth.instance.currentUser != null) {
      firstWidget = const NavigationPageView();
    } else {
      firstWidget = const SignInPage();
    }

    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          unselectedWidgetColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: firstWidget);
  }
}
