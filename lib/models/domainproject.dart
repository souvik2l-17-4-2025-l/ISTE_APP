class DomainProject {
  final int id;
  final String title;
  final String description;
  final String status; // 'ongoing', 'completed', 'planned'
  final DateTime startDate;
  final DateTime? endDate;
  final List<String> technologies;
  final int domainId;
  final String leadName;
  final int teamSize;

  DomainProject({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.startDate,
    this.endDate,
    required this.technologies,
    required this.domainId,
    required this.leadName,
    required this.teamSize,
  });
}