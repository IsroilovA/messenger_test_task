import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_test_task/home_screen/cubit/home_cubit.dart';
import 'package:messenger_test_task/home_screen/home_screen.dart';
import 'package:messenger_test_task/service/locator.dart';
import 'package:messenger_test_task/service/messenger_repository.dart';

// Theme for the light mode
final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(
        255, 5, 138, 87), // Primary color for the light theme
    brightness: Brightness.light, // Brightness setting for the light theme
  ),
  textTheme:
      GoogleFonts.poppinsTextTheme(), // Using Poppins font for the light theme
);

// Theme for the dark mode
final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(
        230, 0, 156, 31), // Primary color for the dark theme
    brightness: Brightness.dark, // Brightness setting for the dark theme
  ),
  textTheme:
      GoogleFonts.poppinsTextTheme(), // Using Poppins font for the dark theme
);

class GoogleFonts {
  static poppinsTextTheme() {}
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialiseLocator();
  runApp(const App());
}

// Root widget of the application
class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme, // Applying the light theme
      darkTheme: darkTheme, // Applying the dark theme
      //provide global bloc
      home: BlocProvider(
        create: (context) => HomeCubit(
          messengerRepository: locator<MessengerRepository>(),
        ),
        child: const HomeScreen(),
      ),
    );
  }
}
