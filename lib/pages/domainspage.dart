import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../models/domain.dart';
import '../models/domainproject.dart';

// User Role Enum
enum UserRole { board, mancom, worcom }

class domainspage extends StatefulWidget {
  final UserRole userRole; // board, mancom, or worcom

  const domainspage({
    Key? key,
    required this.userRole,
  }) : super(key: key);

  @override
  _domainspageState createState() => _domainspageState();
}

class _domainspageState extends State<domainspage> {
  // Temporary domain projects list - will be replaced with MySQL database fetch
  List<DomainProject> domainProjects = [
    DomainProject(
      id: 1,
      title: 'E-Commerce Mobile App',
      description: 'Building a full-stack e-commerce application with Flutter and Node.js',
      status: 'ongoing',
      startDate: DateTime(2025, 5, 15),
      technologies: ['Flutter', 'Node.js', 'MongoDB', 'Firebase'],
      domainId: 1,
      leadName: 'Arjun Sharma',
      teamSize: 6,
    ),
    DomainProject(
      id: 2,
      title: 'ISTE Website Redesign',
      description: 'Complete redesign of ISTE Manipal website with modern UI/UX',
      status: 'ongoing',
      startDate: DateTime(2025, 4, 20),
      endDate: DateTime(2025, 7, 30),
      technologies: ['React', 'Next.js', 'Tailwind CSS', 'Strapi'],
      domainId: 1,
      leadName: 'Priya Patel',
      teamSize: 4,
    ),
    DomainProject(
      id: 3,
      title: 'AI Chatbot for Student Support',
      description: 'Developing an intelligent chatbot to assist students with queries',
      status: 'planned',
      startDate: DateTime(2025, 7, 1),
      technologies: ['Python', 'TensorFlow', 'NLP', 'FastAPI'],
      domainId: 4,
      leadName: 'Rahul Kumar',
      teamSize: 5,
    ),
    DomainProject(
      id: 4,
      title: 'Campus Event Management System',
      description: 'Web platform for managing and organizing campus events',
      status: 'ongoing',
      startDate: DateTime(2025, 3, 10),
      technologies: ['Vue.js', 'Laravel', 'MySQL', 'Docker'],
      domainId: 1,
      leadName: 'Sneha Reddy',
      teamSize: 7,
    ),
    DomainProject(
      id: 5,
      title: 'Student Performance Analytics',
      description: 'Data analysis dashboard for tracking student academic performance',
      status: 'completed',
      startDate: DateTime(2025, 1, 15),
      endDate: DateTime(2025, 5, 30),
      technologies: ['Python', 'Pandas', 'Plotly', 'Streamlit'],
      domainId: 3,
      leadName: 'Vikram Singh',
      teamSize: 3,
    ),
    DomainProject(
      id: 6,
      title: 'IoT Smart Campus Solution',
      description: 'Implementing IoT sensors for smart campus management',
      status: 'ongoing',
      startDate: DateTime(2025, 2, 1),
      technologies: ['Arduino', 'Raspberry Pi', 'MQTT', 'InfluxDB'],
      domainId: 5,
      leadName: 'Ananya Gupta',
      teamSize: 8,
    ),
  ];

  // Temporary domains list
  List<Domain> domains = [
    Domain(
      id: 1,
      name: 'Web Development',
      description: 'Build modern web applications',
      icon: Icons.web,
      color: HexColor("6C5CE7"),
      isActive: true,
      memberCount: 45,
    ),
    Domain(
      id: 2,
      name: 'Mobile Development',
      description: 'Create innovative mobile apps',
      icon: Icons.phone_android,
      color: HexColor("00B894"),
      isActive: true,
      memberCount: 32,
    ),
    Domain(
      id: 3,
      name: 'Data Science',
      description: 'Analyze and visualize data',
      icon: Icons.analytics,
      color: HexColor("E17055"),
      isActive: true,
      memberCount: 28,
    ),
    Domain(
      id: 4,
      name: 'AI & Machine Learning',
      description: 'Build intelligent systems',
      icon: Icons.psychology,
      color: HexColor("FDCB6E"),
      isActive: true,
      memberCount: 38,
    ),
    Domain(
      id: 5,
      name: 'Cybersecurity & IoT',
      description: 'Secure digital infrastructure',
      icon: Icons.security,
      color: HexColor("E84393"),
      isActive: true,
      memberCount: 25,
    ),
  ];

  // Role-based access control helpers
  bool get isBoard => widget.userRole == UserRole.board;
  bool get isManCom => widget.userRole == UserRole.mancom;
  bool get isWorCom => widget.userRole == UserRole.worcom;

  // Combined permission for project management (ManCom + WorkCom)
  bool get canManageProjects => isManCom || isWorCom;

  // Only Board can manage domains
  bool get canManageDomains => isBoard;

  String selectedTab = 'domains'; // 'domains' or 'projects'

  String get roleDisplayName {
    switch (widget.userRole) {
      case UserRole.board:
        return 'BOARD';
      case UserRole.mancom:
        return 'MANCOM';
      case UserRole.worcom:
        return 'WORCOM';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkTheme
                ? [
              colorScheme.secondary, // #11112A
              colorScheme.surface,   // #0C0C21
            ]
                : [
              HexColor("6C5CE7"),
              HexColor("A29BFE"),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context, isDarkTheme, colorScheme),
              _buildTabSelector(context, isDarkTheme, colorScheme),
              Expanded(
                child: selectedTab == 'domains'
                    ? _buildDomainsView(context, isDarkTheme, colorScheme)
                    : _buildProjectsView(context, isDarkTheme, colorScheme),
              ),
             
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context, isDarkTheme, colorScheme),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isDarkTheme, ColorScheme colorScheme) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: isDarkTheme ? colorScheme.primary : Colors.white,
              size: 24,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'ISTE Domains',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? colorScheme.primary : Colors.white,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getRoleColor().withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _getRoleColor(), width: 1),
                  ),
                  child: Text(
                    '$roleDisplayName Dashboard',
                    style: TextStyle(
                      fontSize: 10,
                      color: _getRoleColor(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // Search functionality
            },
            icon: Icon(
              //padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
              Icons.search,
              color: isDarkTheme ? colorScheme.primary : Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRoleColor() {
    switch (widget.userRole) {
      case UserRole.board:
        return HexColor("FFD700"); // Gold for Board
      case UserRole.mancom:
        return HexColor("00B894"); // Green for ManCom
      case UserRole.worcom:
        return HexColor("6C5CE7"); // Purple for WorkCom
    }
  }

  Widget _buildTabSelector(BuildContext context, bool isDarkTheme, ColorScheme colorScheme) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isDarkTheme
            ? colorScheme.surface.withOpacity(0.5)
            : Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedTab = 'domains'),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: selectedTab == 'domains'
                      ? HexColor("6C5CE7")
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Domains',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selectedTab == 'domains'
                        ? Colors.white
                        : isDarkTheme
                        ? colorScheme.primary.withOpacity(0.7)
                        : Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedTab = 'projects'),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: selectedTab == 'projects'
                      ? HexColor("6C5CE7")
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Projects',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selectedTab == 'projects'
                        ? Colors.white
                        : isDarkTheme
                        ? colorScheme.primary.withOpacity(0.7)
                        : Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDomainsView(BuildContext context, bool isDarkTheme, ColorScheme colorScheme) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Active Domains',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkTheme ? colorScheme.primary : Colors.white,
                  ),
                ),
              ),
              if (canManageDomains)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: HexColor("FFD700").withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: HexColor("FFD700"), width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.admin_panel_settings, size: 12, color: HexColor("FFD700")),
                      SizedBox(width: 4),
                      Text(
                        'Domain Admin',
                        style: TextStyle(
                          fontSize: 10,
                          color: HexColor("FFD700"),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: domains.length,
            itemBuilder: (context, index) {
              return _buildDomainCard(context, isDarkTheme, colorScheme, domains[index]);
            },
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildProjectsView(BuildContext context, bool isDarkTheme, ColorScheme colorScheme) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Domain Projects',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkTheme ? colorScheme.primary : Colors.white,
                  ),
                ),
              ),
              if (canManageProjects)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getRoleColor().withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _getRoleColor(), width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit, size: 12, color: _getRoleColor()),
                      SizedBox(width: 4),
                      Text(
                        'Project Manager',
                        style: TextStyle(
                          fontSize: 10,
                          color: _getRoleColor(),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: domainProjects.length,
            itemBuilder: (context, index) {
              return _buildProjectCard(context, isDarkTheme, colorScheme, domainProjects[index]);
            },
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildDomainCard(BuildContext context, bool isDarkTheme, ColorScheme colorScheme, Domain domain) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkTheme
            ? colorScheme.surface.withOpacity(0.8)
            : Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: domain.color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: domain.color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              domain.icon,
              color: domain.color,
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        domain.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isDarkTheme ? colorScheme.primary : Colors.white,
                        ),
                      ),
                    ),
                    // Only Board members can manage domains
                    if (canManageDomains)
                      PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_vert,
                          color: isDarkTheme ? colorScheme.primary : Colors.white,
                        ),
                        onSelected: (value) {
                          if (value == 'edit') {
                            _showEditDomainDialog(context, domain);
                          } else if (value == 'delete') {
                            _showDeleteDomainDialog(context, domain);
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit, size: 16),
                                SizedBox(width: 8),
                                Text('Edit Domain'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, size: 16, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Remove Domain', style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  domain.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkTheme
                        ? colorScheme.primary.withOpacity(0.7)
                        : Colors.white.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.people,
                      size: 16,
                      color: isDarkTheme
                          ? colorScheme.primary.withOpacity(0.6)
                          : Colors.white.withOpacity(0.6),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${domain.memberCount} members',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDarkTheme
                            ? colorScheme.primary.withOpacity(0.6)
                            : Colors.white.withOpacity(0.6),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: domain.isActive ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        domain.isActive ? 'Active' : 'Inactive',
                        style: TextStyle(
                          fontSize: 10,
                          color: domain.isActive ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, bool isDarkTheme, ColorScheme colorScheme, DomainProject project) {
    Color statusColor = project.status == 'ongoing'
        ? HexColor("00B894")
        : project.status == 'completed'
        ? HexColor("6C5CE7")
        : HexColor("FDCB6E");

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkTheme
            ? colorScheme.surface.withOpacity(0.8)
            : Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: statusColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  project.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDarkTheme ? colorScheme.primary : Colors.white,
                  ),
                ),
              ),
              // Both ManCom and WorkCom can manage projects
              if (canManageProjects)
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: isDarkTheme ? colorScheme.primary : Colors.white,
                  ),
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showEditProjectDialog(context, project);
                    } else if (value == 'delete') {
                      _showDeleteProjectDialog(context, project);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 16),
                          SizedBox(width: 8),
                          Text('Edit Project'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 16, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete Project', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            project.description,
            style: TextStyle(
              fontSize: 14,
              color: isDarkTheme
                  ? colorScheme.primary.withOpacity(0.7)
                  : Colors.white.withOpacity(0.8),
              height: 1.4,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  project.status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              Icon(
                Icons.person,
                size: 14,
                color: isDarkTheme
                    ? colorScheme.primary.withOpacity(0.6)
                    : Colors.white.withOpacity(0.6),
              ),
              SizedBox(width: 4),
              Text(
                project.leadName,
                style: TextStyle(
                  fontSize: 12,
                  color: isDarkTheme
                      ? colorScheme.primary.withOpacity(0.6)
                      : Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.group,
                size: 14,
                color: isDarkTheme
                    ? colorScheme.primary.withOpacity(0.6)
                    : Colors.white.withOpacity(0.6),
              ),
              SizedBox(width: 4),
              Text(
                '${project.teamSize} members',
                style: TextStyle(
                  fontSize: 12,
                  color: isDarkTheme
                      ? colorScheme.primary.withOpacity(0.6)
                      : Colors.white.withOpacity(0.6),
                ),
              ),
              Spacer(),
              Icon(
                Icons.calendar_today,
                size: 14,
                color: isDarkTheme
                    ? colorScheme.primary.withOpacity(0.6)
                    : Colors.white.withOpacity(0.6),
              ),
              SizedBox(width: 4),
              Text(
                '${project.startDate.day}/${project.startDate.month}/${project.startDate.year}',
                style: TextStyle(
                  fontSize: 12,
                  color: isDarkTheme
                      ? colorScheme.primary.withOpacity(0.6)
                      : Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: project.technologies.take(3).map((tech) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: HexColor("6C5CE7").withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tech,
                  style: TextStyle(
                    fontSize: 10,
                    color: HexColor("6C5CE7"),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context, bool isDarkTheme, ColorScheme colorScheme) {
    // Show FAB based on current tab and permissions
    bool showFAB = false;
    if (selectedTab == 'domains' && canManageDomains) {
      showFAB = true;
    } else if (selectedTab == 'projects' && canManageProjects) {
      showFAB = true;
    }

    if (!showFAB) return SizedBox.shrink();

    return FloatingActionButton(
      onPressed: () {
        if (selectedTab == 'domains') {
          _showAddDomainDialog(context);
        } else {
          _showAddProjectDialog(context);
        }
      },
      backgroundColor: _getRoleColor(),
      child: Icon(Icons.add, color: Colors.white),
    );
  }


  // Role-based Dialog Functions
  void _showAddDomainDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.admin_panel_settings, color: HexColor("FFD700")),
            SizedBox(width: 8),
            Text('Add New Domain'),
          ],
        ),
        content: Text('Only Board members can add new domains.\n\nDomain creation form will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add domain logic
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: HexColor("FFD700")),
            child: Text('Add Domain'),
          ),
        ],
      ),
    );
  }

  void _showAddProjectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.edit, color: _getRoleColor()),
            SizedBox(width: 8),
            Text('Add New Project'),
          ],
        ),
        content: Text('${roleDisplayName} members can add new projects.\n\nProject creation form will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add project logic
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: _getRoleColor()),
            child: Text('Add Project'),
          ),
        ],
      ),
    );
  }

  void _showEditDomainDialog(BuildContext context, Domain domain) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${domain.name}'),
        content: Text('Board-only domain editing form will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Edit domain logic
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: HexColor("FFD700")),
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  void _showEditProjectDialog(BuildContext context, DomainProject project) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit ${project.title}'),
        content: Text('${roleDisplayName} project editing form will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Edit project logic
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: _getRoleColor()),
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDomainDialog(BuildContext context, Domain domain) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remove Domain'),
        content: Text('Are you sure you want to remove ${domain.name}?\n\nThis action can only be performed by Board members.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                domains.removeWhere((d) => d.id == domain.id);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _showDeleteProjectDialog(BuildContext context, DomainProject project) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Project'),
        content: Text('Are you sure you want to delete ${project.title}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                domainProjects.removeWhere((p) => p.id == project.id);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
