import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../constants/app_colors.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final _loginForm = GlobalKey<FormState>();
  final _signupForm = GlobalKey<FormState>();

  final _loginEmail = TextEditingController();
  final _loginPassword = TextEditingController();
  final _signupName = TextEditingController();
  final _signupEmail = TextEditingController();
  final _signupPassword = TextEditingController();

  bool _obscureLogin = true;
  bool _obscureSignup = true;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    _loginEmail.dispose();
    _loginPassword.dispose();
    _signupName.dispose();
    _signupEmail.dispose();
    _signupPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            _header(),
            const SizedBox(height: 32),
            _tabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabs,
                children: [_loginTab(), _signupTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        const Text('📚', style: TextStyle(fontSize: 56)),
        const SizedBox(height: 12),
        Text(
          'KidStories',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          'Magical stories for little readers',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _tabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabs,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[600],
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Login'),
          Tab(text: 'Sign Up'),
        ],
      ),
    );
  }

  Widget _loginTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _loginForm,
        child: Column(
          children: [
            const SizedBox(height: 16),
            _field(
              controller: _loginEmail,
              label: 'Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: _emailValidator,
            ),
            const SizedBox(height: 16),
            _field(
              controller: _loginPassword,
              label: 'Password',
              icon: Icons.lock_outline,
              obscure: _obscureLogin,
              suffixIcon: IconButton(
                icon: Icon(_obscureLogin ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(() => _obscureLogin = !_obscureLogin),
              ),
              validator: _passwordValidator,
            ),
            const SizedBox(height: 24),
            _submitButton(
              label: 'Login',
              onTap: _login,
            ),
          ],
        ),
      ),
    );
  }

  Widget _signupTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _signupForm,
        child: Column(
          children: [
            const SizedBox(height: 16),
            _field(
              controller: _signupName,
              label: 'Display Name (optional)',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            _field(
              controller: _signupEmail,
              label: 'Email',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: _emailValidator,
            ),
            const SizedBox(height: 16),
            _field(
              controller: _signupPassword,
              label: 'Password',
              icon: Icons.lock_outline,
              obscure: _obscureSignup,
              suffixIcon: IconButton(
                icon: Icon(_obscureSignup ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(() => _obscureSignup = !_obscureSignup),
              ),
              validator: _passwordValidator,
            ),
            const SizedBox(height: 24),
            _submitButton(
              label: 'Create Account',
              onTap: _signUp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscure = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primary),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }

  Widget _submitButton({required String label, required VoidCallback onTap}) {
    return Consumer<AuthProvider>(
      builder: (_, auth, __) {
        if (auth.error != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(auth.error!), backgroundColor: Colors.red),
            );
          });
        }
        return SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: auth.isLoading ? null : onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            child: auth.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }

  Future<void> _login() async {
    if (!_loginForm.currentState!.validate()) return;
    final auth = context.read<AuthProvider>();
    await auth.login(email: _loginEmail.text.trim(), password: _loginPassword.text);
    if (auth.isLoggedIn && mounted) Navigator.of(context).pop();
  }

  Future<void> _signUp() async {
    if (!_signupForm.currentState!.validate()) return;
    final auth = context.read<AuthProvider>();
    await auth.signUp(
      email: _signupEmail.text.trim(),
      password: _signupPassword.text,
      displayName: _signupName.text.trim().isEmpty ? null : _signupName.text.trim(),
    );
    if (auth.isLoggedIn && mounted) Navigator.of(context).pop();
  }

  String? _emailValidator(String? v) {
    if (v == null || v.isEmpty) return 'Email is required';
    if (!v.contains('@')) return 'Enter a valid email';
    return null;
  }

  String? _passwordValidator(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 6) return 'Password must be at least 6 characters';
    return null;
  }
}
