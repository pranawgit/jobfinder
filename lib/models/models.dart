// Job model example
class Job {
  final String title;
  final String company;
  final String location;
  final String companyLogoUrl;
  final String description;
  final String url;

  // Constructor
  Job({
    required this.title,
    required this.company,
    required this.location,
    required this.companyLogoUrl,
    required this.description,
    required this.url,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      title: json['title'],
      company: json['company_name'],
      location: json['category'],
      companyLogoUrl: json['company_logo'],
      description: json['description'],
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'company_name': company,
      'category': location,
      'company_logo': companyLogoUrl,
      'description': description,
      'url': url,
    };
  }
}
