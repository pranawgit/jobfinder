import 'package:flutter/material.dart';
import 'package:job_finder/models/models.dart';
import 'package:job_finder/view/jobdetails_page.dart';
import 'package:get/get.dart';
import 'package:job_finder/controllers/controllers.dart';
import 'package:job_finder/view/savedjobs_view.dart';
import 'package:job_finder/view/theme_controller.dart';

class JobHomeView extends StatefulWidget {
  const JobHomeView({super.key});

  @override
  State<JobHomeView> createState() => _JobHomeViewState();
}

class _JobHomeViewState extends State<JobHomeView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Jobcontroller());

    // Initialize your controller here
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'JOBIFY',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(SavedJobsView());
            },
            icon: Icon(Icons.bookmark, size: 30, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SearchBar(
              hintText: 'Search for jobs',
              onChanged: (value) {
                controller.searchJobs(value);
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.jobs.isEmpty) {
                return const Center(child: Text('No jobs found'));
              }

              return ListView.builder(
                itemCount: controller.filteredJobs.length,
                itemBuilder: (context, index) {
                  final job = controller.filteredJobs[index];
                  return JobCard(job, controller);
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ThemeController().toggleTheme();
        },
        child: Icon(Icons.brightness_6),
      ),
    );
  }
}

Widget SearchBar({
  required String hintText,
  required ValueChanged<String> onChanged,
}) {
  return TextField(
    onChanged: onChanged,
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(Icons.search),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.grey[200],
    ),
  );
}

Widget JobCard(Job job, Jobcontroller controller) {
  return InkWell(
    onTap: () {
      Get.to(JobdetailsPage(), arguments: job);
    },
    child: Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(Icons.person)),
        title: Text(job.title),
        subtitle: Text(job.company),
        trailing: IconButton(
          icon: Icon(
            controller.savedJobs.any((j) => j.title == job.title)
                ? Icons.favorite
                : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () {
            controller.toggleSaveJob(job);
          },
        ),
      ),
    ),
  );
}
