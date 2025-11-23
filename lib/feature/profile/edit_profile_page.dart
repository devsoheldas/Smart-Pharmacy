import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final Function(File file) onImageSelected;
  final Function(String name, String email, String phone, String dob, String gender) onSave;
  final String currentName;
  final String currentEmail;
  final String currentPhone;
  final String currentDob;
  final String currentGender;

  const EditProfilePage({
    super.key,
    required this.onImageSelected,
    required this.onSave,
    required this.currentName,
    required this.currentEmail,
    this.currentPhone = '',
    this.currentDob = '',
    this.currentGender = '',
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  File? selectedImage;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController dobController;

  String? selectedGender;
  final List<String> genderOptions = ['Male', 'Female', 'Other'];

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentName);
    emailController = TextEditingController(text: widget.currentEmail);
    phoneController = TextEditingController(text: widget.currentPhone);
    dobController = TextEditingController(text: widget.currentDob);

    if (genderOptions.contains(widget.currentGender)) {
      selectedGender = widget.currentGender;
    }

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (picked != null) {
        setState(() => selectedImage = File(picked.path));
        widget.onImageSelected(File(picked.path));
      }
    } catch (e) {
      _showErrorSnackBar('Failed to pick image.');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600), // Date picker text size
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        dobController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Select Image Source',
                  style: TextStyle(
                    fontSize: 16, // Smaller title
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _ImageSourceButton(
                        icon: Icons.camera_alt_rounded,
                        label: 'Camera',
                        onTap: () {
                          Navigator.pop(context);
                          _pickImage(ImageSource.camera);
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _ImageSourceButton(
                        icon: Icons.photo_library_rounded,
                        label: 'Gallery',
                        onTap: () {
                          Navigator.pop(context);
                          _pickImage(ImageSource.gallery);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      widget.onSave(
        nameController.text.trim(),
        emailController.text.trim(),
        phoneController.text.trim(),
        dobController.text.trim(),
        selectedGender ?? '',
      );
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      _showErrorSnackBar('Failed to save profile.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontSize: 13)), // Small text
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required';
    if (value.trim().length < 2) return 'At least 2 characters';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) return 'Invalid email';
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone is required';
    if (value.trim().length < 10) return 'Invalid phone number';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16, // Adjusted to 16 for a cleaner look
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black87,
              size: 16, // Smaller icon
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade200),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 20, // Reduced padding slightly for small devices
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfileImageSection(),
                const SizedBox(height: 24), // Reduced spacing
                _buildFormFields(),
                const SizedBox(height: 32),
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImageSection() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 50, // Slightly smaller image (was 60)
                backgroundColor: Colors.grey.shade200,
                backgroundImage: selectedImage != null
                    ? FileImage(selectedImage!)
                    : const AssetImage('assets/images/profile_pic.png') as ImageProvider,
                child: selectedImage == null
                    ? Icon(Icons.person_rounded, size: 50, color: Colors.grey.shade400)
                    : null,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: _showImageSourceDialog,
                child: Container(
                  padding: const EdgeInsets.all(10), // Smaller touch target area
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 18),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Tap to change photo',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12, // Small helper text
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Full Name'),
        const SizedBox(height: 6),
        _buildTextField(
          controller: nameController,
          hintText: 'Your name',
          prefixIcon: Icons.person_outline_rounded,
          validator: _validateName,
        ),
        const SizedBox(height: 16),


        _buildLabel('Phone Number'),
        const SizedBox(height: 6),
        _buildTextField(
          controller: phoneController,
          hintText: '+8801 234 567 890',
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: _validatePhone,
        ),
        const SizedBox(height: 16),

        _buildLabel('Email Address'),
        const SizedBox(height: 6),
        _buildTextField(
          controller: emailController,
          hintText: 'email@address.com',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: _validateEmail,
        ),
        const SizedBox(height: 16),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Birth Date'),
                  const SizedBox(height: 6),
                  _buildDateField(),
                ],
              ),
            ),
            const SizedBox(width: 12), // Tighter spacing
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('Gender'),
                  const SizedBox(height: 6),
                  _buildGenderDropdown(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      // Text size 14 for input
      style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500),
      decoration: _commonInputDecoration(hintText, prefixIcon),
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      controller: dobController,
      readOnly: true,
      onTap: () => _selectDate(context),
      validator: (value) => value!.isEmpty ? 'Req' : null,
      style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500),
      decoration: _commonInputDecoration('YYYY-MM-DD', Icons.calendar_today_rounded),
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedGender,
      icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
      style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500),
      validator: (value) => value == null ? 'Req' : null,
      decoration: _commonInputDecoration('Select', Icons.wc_rounded),
      items: genderOptions.map((String gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender, style: const TextStyle(fontSize: 14)),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() => selectedGender = newValue);
      },
    );
  }

  InputDecoration _commonInputDecoration(String hintText, IconData prefixIcon) {
    return InputDecoration(
      hintText: hintText,
      // Small hint text
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
      prefixIcon: Icon(prefixIcon, color: Colors.grey.shade500, size: 20),
      filled: true,
      fillColor: Colors.white,
      isDense: true, // IMPORTANT: Makes field more compact
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14), // Slightly tighter radius
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      // Reduced content padding for "Small" look
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      errorStyle: const TextStyle(fontSize: 11), // Smaller error text
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13, // Small label
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade700, // Softer color
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 52, // Height reduced from 56
      child: ElevatedButton(
        onPressed: _isLoading ? null : _saveProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          disabledBackgroundColor: Colors.grey.shade300,
        ),
        child: _isLoading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : const Text(
          'Save Changes',
          style: TextStyle(
            fontSize: 15, // Button text reduced
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _ImageSourceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ImageSourceButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16), // Less padding
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Theme.of(context).primaryColor, size: 22),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13, // Smaller label
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}