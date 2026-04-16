import 'package:get/get.dart';
import '../models/models.dart';
import '../service/service.dart';
import 'package:get_storage/get_storage.dart';

class Jobcontroller extends GetxController {
  var jobs = <Job>[].obs;
  var isLoading = false.obs;
  var filteredJobs = <Job>[].obs;
  final box = GetStorage();
  var savedJobs = <Job>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSavedJobs();
    fetchJobs();
    toggleSaveJob(jobs.first);
  }

  void fetchJobs() async {
    try {
      isLoading.value = true;
      JobService jobService = JobService();
      final data = await jobService.fetchJobs();
      jobs.value = data['jobs'];
      filteredJobs.value = data['jobs'];
    } catch (e) {
      print('Error fetching jobs: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void searchJobs(String query) {
    if (query.isEmpty) {
      filteredJobs.value = jobs;
    } else {
      filteredJobs.value = jobs.where((job) {
        return job.title.toLowerCase().contains(query.toLowerCase()) ||
            job.company.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void loadSavedJobs() {
    final data = box.read('savedJobs') ?? [];
    savedJobs.value = List<Map<String, dynamic>>.from(
      data,
    ).map((e) => Job.fromJson(e)).toList();
  }

  void toggleSaveJob(Job job) {
    final exists = savedJobs.any((j) => j.title == job.title);

    if (exists) {
      savedJobs.removeWhere((j) => j.title == job.title);
    } else {
      savedJobs.add(job);
    }

    box.write('savedJobs', savedJobs.map((e) => e.toJson()).toList());
  }
}
