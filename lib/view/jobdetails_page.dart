import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder/models/models.dart';
import 'package:url_launcher/url_launcher.dart';
import 'AichatPage.dart';

class JobdetailsPage extends StatefulWidget {
  const JobdetailsPage({super.key});

  @override
  _JobdetailsPageState createState() => _JobdetailsPageState();
}

class _JobdetailsPageState extends State<JobdetailsPage> {
  Job? job;

  @override
  void initState() {
    super.initState();
    job = Get.arguments as Job?;
  }

  void openjob(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse("https://www.linkedin.com/jobs"),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (job == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Job Details')),
        body: Center(child: Text('No job data available')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text(
          'Job Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 50),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 25),
            Container(
              height: 370,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job!.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      job!.company,
                      style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 8),
                    Text(
                      job!.location,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 16),
                    Text(job!.description, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: () => openjob(job!.url),
                child: Text(
                  'Apply Now',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.chat),
        onPressed: () => Get.to(() => ChatView(), arguments: job),
      ),
    );
  }
}
