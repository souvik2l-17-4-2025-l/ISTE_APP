import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'domainproject.dart';

class Domain {
  final int id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final bool isActive;
  final int memberCount;
  final List<DomainProject> projects;

  Domain({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.isActive,
    required this.memberCount,
    this.projects = const [],
  });
}