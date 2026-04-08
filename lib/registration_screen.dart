import 'package:flutter/material.dart';
import 'api_service.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  String? prefix;
  String? gender;
  String? delegateType;
  String? attendWorkshop;

  Map<String, bool> workshops = {
    "Pre-conference 1": false,
    "Pre-conference 2": false,
    "Pre-conference 3": false,
    "Pre-conference 4": false,
  };

  Map<String, bool> workshop = {
    "Workshops": false,
    "Oral Presentations for research submission": false,
    "Posters": false,
    "Yenvision- Lightning talk": false,
  };

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController collegeController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    ageController.dispose();
    designationController.dispose();
    collegeController.dispose();
    universityController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    pinCodeController.dispose();
    super.dispose();
  }

  Widget buildTextField(String label, [TextEditingController? controller]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter $label";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "Enter $label",
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(
    String label,
    List<String> items,
    String? value,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: value,
        hint: const Text("Select"),
        validator: (value) => value == null ? "Please select $label" : null,
        decoration: const InputDecoration(),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  void register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final userData = {
        "username": usernameController.text,
        "password": passwordController.text,
        "name": "${prefix ?? ""} ${nameController.text}".trim(),
        "email": emailController.text,
        "mobile": mobileController.text,
        "age": ageController.text,
        "gender": gender,
        "delegate": delegateType,
        "designation": designationController.text,
        "college": collegeController.text,
        "university": universityController.text,
        "address": addressController.text,
        "city": cityController.text,
        "state": stateController.text,
        "country": countryController.text,
        "pinCode": pinCodeController.text,
        "attendWorkshop": attendWorkshop,
        "workshops": workshops,
        "workshop": workshop,
      };


      final result = await ApiService.register(userData);

      if (result['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration Successful!")),
        );
        Navigator.pop(context, userData);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? "Registration Failed")),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("VIDYEN 3.0"),
        backgroundColor: Colors.blue.shade900,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;

          double formWidth;
          if (width > 900) {
            formWidth = 700;
          } else if (width > 600) {
            formWidth = 600;
          } else {
            formWidth = double.infinity;
          }

          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(width < 600 ? 12 : 24),
              child: Container(
                width: formWidth,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Register Now",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text("Username"),
                      buildTextField("Username", usernameController),

                      Text("Password"),
                      buildTextField("Password", passwordController),

                      Text("Name Prefix"),
                      buildDropdown(
                        "Prefix",
                        ["Mr", "Ms", "Dr"],
                        prefix,
                        (val) => setState(() => prefix = val),
                      ),

                      Text("Full Name"),
                      buildTextField("Full Name", nameController),

                      Text("Age"),
                      buildTextField("Age", ageController),

                      Text("Gender"),
                      buildDropdown(
                        "Gender",
                        ["Male", "Female", "Other"],
                        gender,
                        (val) => setState(() => gender = val),
                      ),

                      Text("Type of Delegate"),
                      buildDropdown(
                        "Delegate",
                        ["Student", "Doctor", "Faculty", "Other"],
                        delegateType,
                        (val) => setState(() => delegateType = val),
                      ),

                      Text("Designation"),
                      buildTextField("Designation", designationController),

                      Text("College"),
                      buildTextField("College", collegeController),

                      Text("University"),
                      buildTextField("University", universityController),

                      Text("Address"),
                      buildTextField("Address", addressController),

                      Text("City"),
                      buildTextField("City", cityController),

                      Text("State"),
                      buildTextField("State", stateController),

                      Text("Country"),
                      buildTextField("Country", countryController),

                      Text("Pin Code"),
                      buildTextField("Pin Code", pinCodeController),

                      Text("Email"),
                      buildTextField("Email", emailController),

                      Text("Mobile"),
                      buildTextField("Mobile", mobileController),

                      const SizedBox(height: 16),

                      Text("Will you attend workshops?"),
                      Row(
                        children: [
                          Radio(
                            value: "Yes",
                            groupValue: attendWorkshop,
                            onChanged: (val) =>
                                setState(() => attendWorkshop = val.toString()),
                          ),
                          const Text("Yes"),
                          Radio(
                            value: "No",
                            groupValue: attendWorkshop,
                            onChanged: (val) =>
                                setState(() => attendWorkshop = val.toString()),
                          ),
                          const Text("No"),
                        ],
                      ),

                      Column(
                        children: workshops.keys.map((key) {
                          return CheckboxListTile(
                            title: Text(key),
                            value: workshops[key],
                            onChanged: (val) {
                              setState(() {
                                workshops[key] = val!;
                              });
                            },
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 20),

                      Column(
                        children: workshop.keys.map((key) {
                          return CheckboxListTile(
                            title: Text(key),
                            value: workshop[key],
                            onChanged: (val) {
                              setState(() {
                                workshop[key] = val!;
                              });
                            },
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : register,
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text("Submit"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
