import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Developer extends StatefulWidget {
  const Developer({super.key});

  @override
  State<Developer> createState() => _DeveloperState();
}

class _DeveloperState extends State<Developer> {
  final String githubURL = 'https://github.com/ishashankmittal';
  final String linkedInURL = 'https://linkedin.com/in/shashankmittal27';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Developer Info'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            // Display your developer info
            Text(
              'Shashank Mittal',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Mechanical Engg. (22135114)',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            // Add any additional developer information or links
            GestureDetector(
              onTap: () {
                launch(githubURL); // Launch the GitHub URL
              },
              child: Text(
                'GitHub: @ishashankmittal', // Replace with your GitHub username
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline, // Add underline
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                launch(linkedInURL); // Launch the LinkedIn URL
              },
              child: Text(
                'LinkedIn: linkedin.com/in/shashankmittal27/', // Replace with your LinkedIn profile URL
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline, // Add underline
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
