import 'package:flutter/material.dart';
import '../../core/models/profile_models/profile_details_screen_model.dart';
import '../../core/services/network/api_service.dart';
import 'edit_profile_page.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  final ApiService _apiService = ApiService();
  ProfileDetailsData? _profileData;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchProfileDetails();
  }

  Future<void> _fetchProfileDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final response = await _apiService.getProfileDetails();

    if (response.success && response.data?.data != null) {
      setState(() {
        _profileData = response.data!.data;
        _isLoading = false;
      });
    } else {
      setState(() {
        _errorMessage = response.message;
        _isLoading = false;
      });
    }
  }

  Future<void> _handleProfileUpdate(
      String name,
      String email,
      String phone,
      String dob,
      String gender,
      ) async {
    int? genderInt;
    if (gender == 'Male') {
      genderInt = 0;
    } else if (gender == 'Female') {
      genderInt = 1;
    } else if (gender == 'Other') {
      genderInt = 2;
    }

    final response = await _apiService.updateProfile(
      name: name,
      email: email,
      phone: phone,
      dob: dob.isNotEmpty ? dob : null,
      gender: genderInt,
    );

    if (response.success) {
      await _fetchProfileDetails();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  String _getGenderString(int? gender) {
    if (gender == 0) return 'Male';
    if (gender == 1) return 'Female';
    if (gender == 2) return 'Other';
    return '';
  }

  String _getGenderText(int? gender) {
    if (gender == 0) return "Male";
    if (gender == 1) return "Female";
    if (gender == 2) return "Other";
    return "Not specified";
  }

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return "";
    List<String> parts = name.trim().split(" ");
    if (parts.length > 1) {
      return "${parts[0][0]}${parts[1][0]}".toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "N/A";
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return "${date.day} ${months[date.month - 1]}, ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF6A11CB),
          ),
        ),
      );
    }

    if (_errorMessage != null || _profileData == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 60, color: Colors.red),
              SizedBox(height: 16),
              Text(
                _errorMessage ?? 'Failed to load profile',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _fetchProfileDetails,
                child: Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(_profileData!),
            const SizedBox(height: 60),
            _buildUserInfo(_profileData!),
            const SizedBox(height: 20),
            _buildDetailsCard(_profileData!),
            const SizedBox(height: 40),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (_) => EditProfilePage(
      //           currentName: _profileData?.name ?? '',
      //           currentEmail: _profileData?.email ?? '',
      //           currentPhone: _profileData?.phone ?? '',
      //           currentDob: _profileData!.dob != null
      //               ? "${_profileData!.dob!.year}-${_profileData!.dob!.month.toString().padLeft(2, '0')}-${_profileData!.dob!.day.toString().padLeft(2, '0')}"
      //               : '',
      //           currentGender: _getGenderString(_profileData?.gender),
      //           onImageSelected: (file) {},
      //           onSave: _handleProfileUpdate,
      //         ),
      //       ),
      //     );
      //   },
      //   backgroundColor: const Color(0xFF6A11CB),
      //   elevation: 6,
      //   icon: const Icon(Icons.edit, color: Colors.white),
      //   label: const Text(
      //     'Edit Profile',
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 16,
      //     ),
      //   ),
      // ),
    );
  }

  Widget _buildHeader(ProfileDetailsData user) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: 160,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        Positioned(
          bottom: -50,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: user.image != null ? NetworkImage(user.image!) : null,
              child: user.image == null
                  ? Text(
                _getInitials(user.name),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A11CB),
                ),
              )
                  : null,
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 16,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo(ProfileDetailsData user) {
    return Column(
      children: [
        Text(
          user.name ?? 'User',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        // if (user.bio != null && user.bio!.isNotEmpty)
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     child: Text(
        //       user.bio!,
        //       textAlign: TextAlign.center,
        //       style: TextStyle(
        //         fontSize: 14,
        //         color: Colors.grey.shade600,
        //       ),
        //     ),
        //   ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDetailsCard(ProfileDetailsData user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildSectionTitle("Contact Information"),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildListTile(
                  Icons.email_outlined,
                  "Email",
                  user.email ?? 'Not provided',
                ),
                const Divider(height: 1, indent: 60),
                _buildListTile(
                  Icons.phone_outlined,
                  "Phone",
                  user.phone ?? 'Not provided',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle("Personal Details"),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildListTile(
                  Icons.cake_outlined,
                  "Date of Birth",
                  _formatDate(user.dob),
                ),
                const Divider(height: 1, indent: 60),
                _buildListTile(
                  Icons.person_outline,
                  "Age",
                  "${_calculateAge(user.dob)} Years",
                ),
                const Divider(height: 1, indent: 60),
                _buildListTile(
                  Icons.transgender,
                  "Gender",
                  _getGenderText(user.gender),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _calculateAge(DateTime? dob) {
    if (dob == null) return 0;
    final today = DateTime.now();
    int age = today.year - dob.year;
    if (today.month < dob.month || (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age;
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 12),
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: const Color(0xFF6A11CB), size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}