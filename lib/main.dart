import 'package:flutter/material.dart';
import 'package:super_app/views/recipes_home.dart';
import 'package:super_app/views/plant_doctor_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Super App'),
      routes: {
        '/recipes': (context) => RecipesHome(),
        '/doctor': (context) => PlantDoctorHome(),
        '/bmi': (context) => BMIPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomCard(
              title: 'Recipes',
              onTap: () {
                // Navigate to the RecipesPage when the card is tapped
                Navigator.of(context).pushNamed('/recipes');
              },
            ),
            CustomCard(
              title: 'Plant Doctor',
              onTap: () {
                Navigator.pushNamed(context, '/doctor');
              },
            ),
            CustomCard(
              title: 'BMI Calculator',
              onTap: () {
                Navigator.pushNamed(context, '/bmi');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CustomCard({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(16.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
      ),
    );
  }
}


class BMIPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator Page'),
      ),
      body: Center(
        child: Text('BMI Calculator Content Goes Here'),
      ),
    );
  }
}