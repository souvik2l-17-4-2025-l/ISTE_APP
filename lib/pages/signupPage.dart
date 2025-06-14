import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iste_app/pages/loginPage.dart';

// User Role Enum
enum UserRole { board, mancom, worcom }

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  UserRole? _selectedRole;

  final List<DropdownMenuItem<UserRole>> _roleItems = [
    DropdownMenuItem(
      value: UserRole.board,
      child: Row(
        children: [
          Icon(Icons.admin_panel_settings, color: HexColor("FFD700"), size: 20),
          SizedBox(width: 8),
          Text('Board Member'),
        ],
      ),
    ),
    DropdownMenuItem(
      value: UserRole.mancom,
      child: Row(
        children: [
          Icon(Icons.manage_accounts, color: HexColor("00B894"), size: 20),
          SizedBox(width: 8),
          Text('ManCom'),
        ],
      ),
    ),
    DropdownMenuItem(
      value: UserRole.worcom,
      child: Row(
        children: [
          Icon(Icons.work, color: HexColor("6C5CE7"), size: 20),
          SizedBox(width: 8),
          Text('WorkCom'),
        ],
      ),
    ),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
              Color(0xFF2D1B69),
              Color(0xFF1A0F3A),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                SizedBox(height: 40),
                _buildHeader(isDarkTheme, colorScheme),
                SizedBox(height: 40),
                _buildSignUpForm(isDarkTheme, colorScheme),
                SizedBox(height: 30),
                _buildSignUpButton(isDarkTheme, colorScheme),
                SizedBox(height: 20),
                _buildDivider(isDarkTheme, colorScheme),
                SizedBox(height: 20),
                _buildSocialSignUp(isDarkTheme, colorScheme),
                SizedBox(height: 30),
                _buildLoginLink(isDarkTheme, colorScheme),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDarkTheme, ColorScheme colorScheme) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 12,
                offset: Offset(0, 6),
                spreadRadius: 1,
              ),
            ],
          ),
          child: CircleAvatar(
            backgroundColor: isDarkTheme ? colorScheme.surface : Colors.white,
            radius: 62,
            child: Container(
              padding: EdgeInsets.all(8),
              child: ClipOval(
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF2D1B69),
                            Color(0xFF4A3B8C),
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.school_rounded,
                        size: 45,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
        Text(
          'Join the Legacy!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: isDarkTheme ? colorScheme.primary : Colors.white,
            letterSpacing: 0.5,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Create your account and become part of the ISTE community',
            style: TextStyle(
              fontSize: 17,
              color: isDarkTheme
                  ? colorScheme.primary.withOpacity(0.85)
                  : Colors.white.withOpacity(0.85),
              fontWeight: FontWeight.w400,
              height: 1.4,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpForm(bool isDarkTheme, ColorScheme colorScheme) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name Field
          _buildFieldLabel('Full Name', isDarkTheme, colorScheme),
          SizedBox(height: 8),
          _buildTextField(
            controller: _nameController,
            hintText: 'Enter your full name',
            prefixIcon: Icons.person,
            isDarkTheme: isDarkTheme,
            colorScheme: colorScheme,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              if (value.length < 2) {
                return 'Name must be at least 2 characters';
              }
              return null;
            },
          ),
          SizedBox(height: 20),

          // Email Field
          _buildFieldLabel('Learner Email Address', isDarkTheme, colorScheme),
          SizedBox(height: 8),
          _buildTextField(
            controller: _emailController,
            hintText: 'nameitmp120x@learner.manipal.edu',
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            isDarkTheme: isDarkTheme,
            colorScheme: colorScheme,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@learner.manipal.edu')) {
                return 'Please use your learner email address';
              }
              return null;
            },
          ),
          SizedBox(height: 20),

          // Role Dropdown
          _buildFieldLabel('Select Your Role', isDarkTheme, colorScheme),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: isDarkTheme
                  ? colorScheme.surface.withOpacity(0.3)
                  : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDarkTheme
                    ? colorScheme.primary.withOpacity(0.3)
                    : Colors.white.withOpacity(0.3),
              ),
            ),
            child: DropdownButtonFormField<UserRole>(
              value: _selectedRole,
              hint: Row(
                children: [
                  Icon(
                    Icons.group,
                    color: isDarkTheme
                        ? colorScheme.primary.withOpacity(0.6)
                        : Colors.white.withOpacity(0.6),
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Choose your role in ISTE',
                    style: TextStyle(
                      color: isDarkTheme
                          ? colorScheme.primary.withOpacity(0.6)
                          : Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              items: _roleItems,
              onChanged: (UserRole? value) {
                setState(() {
                  _selectedRole = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select your role';
                }
                return null;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              dropdownColor: isDarkTheme ? colorScheme.surface : Colors.white,
              style: TextStyle(
                color: isDarkTheme ? colorScheme.primary : Colors.black,
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: isDarkTheme
                    ? colorScheme.primary.withOpacity(0.7)
                    : Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          SizedBox(height: 20),

          // Password Field
          _buildFieldLabel('Password', isDarkTheme, colorScheme),
          SizedBox(height: 8),
          _buildTextField(
            controller: _passwordController,
            hintText: 'Create a strong password',
            prefixIcon: Icons.lock,
            obscureText: !_isPasswordVisible,
            isDarkTheme: isDarkTheme,
            colorScheme: colorScheme,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: isDarkTheme
                    ? colorScheme.primary.withOpacity(0.6)
                    : Colors.white.withOpacity(0.6),
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
                return 'Password must contain uppercase, lowercase and number';
              }
              return null;
            },
          ),
          SizedBox(height: 20),

          // Confirm Password Field
          _buildFieldLabel('Confirm Password', isDarkTheme, colorScheme),
          SizedBox(height: 8),
          _buildTextField(
            controller: _confirmPasswordController,
            hintText: 'Re-enter your password',
            prefixIcon: Icons.lock_outline,
            obscureText: !_isConfirmPasswordVisible,
            isDarkTheme: isDarkTheme,
            colorScheme: colorScheme,
            suffixIcon: IconButton(
              icon: Icon(
                _isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: isDarkTheme
                    ? colorScheme.primary.withOpacity(0.6)
                    : Colors.white.withOpacity(0.6),
              ),
              onPressed: () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label, bool isDarkTheme, ColorScheme colorScheme) {
    return Text(
      label,
      style: TextStyle(
        color: isDarkTheme ? colorScheme.primary : Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
    required bool isDarkTheme,
    required ColorScheme colorScheme,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(
        color: isDarkTheme ? colorScheme.primary : Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: isDarkTheme
              ? colorScheme.primary.withOpacity(0.6)
              : Colors.white.withOpacity(0.6),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: isDarkTheme
              ? colorScheme.primary.withOpacity(0.7)
              : Colors.white.withOpacity(0.7),
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: isDarkTheme
            ? colorScheme.surface.withOpacity(0.3)
            : Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkTheme
                ? colorScheme.primary.withOpacity(0.3)
                : Colors.white.withOpacity(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkTheme
                ? colorScheme.primary.withOpacity(0.3)
                : Colors.white.withOpacity(0.3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: isDarkTheme ? colorScheme.primary : Colors.white,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildSignUpButton(bool isDarkTheme, ColorScheme colorScheme) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSignUp,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF6C5CE7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_add, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              'Join the Legacy',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(bool isDarkTheme, ColorScheme colorScheme) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: isDarkTheme
                ? colorScheme.primary.withOpacity(0.3)
                : Colors.white.withOpacity(0.3),
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or',
            style: TextStyle(
              color: isDarkTheme
                  ? colorScheme.primary.withOpacity(0.7)
                  : Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: isDarkTheme
                ? colorScheme.primary.withOpacity(0.3)
                : Colors.white.withOpacity(0.3),
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialSignUp(bool isDarkTheme, ColorScheme colorScheme) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: () {
          // Handle Google sign up
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: isDarkTheme
                ? colorScheme.primary.withOpacity(0.3)
                : Colors.white.withOpacity(0.3),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: isDarkTheme
              ? colorScheme.surface.withOpacity(0.3)
              : Colors.white.withOpacity(0.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.g_mobiledata,
              color: isDarkTheme ? colorScheme.primary : Colors.white,
              size: 24,
            ),
            SizedBox(width: 12),
            Text(
              'Continue with Google',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDarkTheme ? colorScheme.primary : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginLink(bool isDarkTheme, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(
            color: isDarkTheme
                ? colorScheme.primary.withOpacity(0.7)
                : Colors.white.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Sign In',
            style: TextStyle(
              color: Color(0xFF6C5CE7),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Create user with Firebase Auth
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );

        // Update user profile with name
        await userCredential.user?.updateDisplayName(_nameController.text.trim());

        // store user data to sql
        // await _saveUserData(userCredential.user!.uid);
        //
        //
        //
        //

        _showSuccessSnackBar('Account created successfully! Welcome to ISTE!');

        // Navigate to home screen or verification screen
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreen(),));

      } on FirebaseAuthException catch (e) {
        String errorMessage = 'An error occurred during sign up';

        switch (e.code) {
          case 'weak-password':
            errorMessage = 'The password provided is too weak';
            break;
          case 'email-already-in-use':
            errorMessage = 'An account already exists for this email';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is not valid';
            break;
          default:
            errorMessage = e.message ?? errorMessage;
        }

        _showErrorSnackBar(errorMessage);
      } catch (e) {
        _showErrorSnackBar('An unexpected error occurred: ${e.toString()}');
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
