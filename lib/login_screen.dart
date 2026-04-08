import 'package:flutter/material.dart';
import 'bottom_navigation_bar.dart'; // ⚠️ Import dashboard
import 'api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? registeredUsername;
  String? registeredPassword;
  Map<String, dynamic>? userProfileData;
  bool isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void openRegister() async {
    final data = await Navigator.pushNamed(context, "/register");

    if (data != null) {
      final userData = data as Map<String, dynamic>;

      setState(() {
        registeredUsername = userData["username"];
        registeredPassword = userData["password"];
        userProfileData = userData;

        usernameController.text = registeredUsername!;
        passwordController.text = registeredPassword!;
      });
    }
  }

  void login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final result = await ApiService.login(
        usernameController.text,
        passwordController.text,
      );

      if (result['status'] == 'success') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Login Successful")));

        // Use returned user data if available
        final userData = result['user'] as Map<String, dynamic>?;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainBottomBar(userData: userData),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? "Login Failed")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double containerWidth;
    if (width > 900) {
      containerWidth = 400;
    } else if (width > 600) {
      containerWidth = 350;
    } else {
      containerWidth = double.infinity;
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: containerWidth,
            margin: EdgeInsets.symmetric(horizontal: width < 600 ? 15 : 0),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/download.png', height: 180),
                  const SizedBox(height: 30),

                  TextFormField(
                    controller: usernameController,
                    validator: (value) =>
                        value!.isEmpty ? "Enter Username" : null,
                    decoration: const InputDecoration(
                      labelText: "Username / Email",
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? "Enter Password" : null,
                    decoration: const InputDecoration(labelText: "Password"),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : login,
                      child: isLoading
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                          : const Text("SIGN IN"),
                    ),
                  ),

                  TextButton(
                    onPressed: openRegister,
                    child: const Text("Register"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
