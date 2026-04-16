import 'package:flutter/material.dart';
import 'package:job_finder/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:job_finder/view/job_home_view.dart';

class SavedJobsView extends StatelessWidget {
  const SavedJobsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Jobcontroller());
    controller.loadSavedJobs();

    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(title: Text('Saved Jobs')),
      body: Obx(() {
        if (controller.savedJobs.isEmpty) {
          return Center(child: Text('No saved jobs'));
        }

        return ListView.builder(
          itemCount: controller.savedJobs.length,
          itemBuilder: (context, index) {
            final job = controller.savedJobs[index];
            return JobCard(job, controller);
          },
        );
      }),
    );
  }
}
