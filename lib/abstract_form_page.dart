import 'package:flutter/material.dart';
import 'api_service.dart';

class AbstractFormPage extends StatefulWidget {
  final Map<String, dynamic>? userData;
  const AbstractFormPage({super.key, this.userData});

  @override
  State<AbstractFormPage> createState() => _AbstractFormPageState();
}

class AuthorData {
  String? prefix;
  final TextEditingController firstName = TextEditingController();
  final TextEditingController middleName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  String? authorType;
  final TextEditingController designation = TextEditingController();
  final TextEditingController institution = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController pincode = TextEditingController();

  void dispose() {
    firstName.dispose();
    middleName.dispose();
    lastName.dispose();
    email.dispose();
    designation.dispose();
    institution.dispose();
    city.dispose();
    state.dispose();
    country.dispose();
    pincode.dispose();
  }
}

class _AbstractFormPageState extends State<AbstractFormPage> {
  String? subTheme;
  String? presentationType;
  String? category;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController keywordsController = TextEditingController();
  final TextEditingController abstractDetailsController =
      TextEditingController();

  final List<AuthorData> authors = [AuthorData()..authorType = "Author"];

  bool isLoading = false;

  @override
  void dispose() {
    titleController.dispose();
    keywordsController.dispose();
    abstractDetailsController.dispose();
    for (var author in authors) {
      author.dispose();
    }
    super.dispose();
  }

  void addAuthor() {
    setState(() {
      authors.add(AuthorData()..authorType = "Co Author");
    });
  }

  void removeAuthor(int index) {
    if (index == 0) return; // Don't remove the primary author
    setState(() {
      authors[index].dispose();
      authors.removeAt(index);
    });
  }

  Future<void> submitForm() async {
    if (titleController.text.isEmpty ||
        abstractDetailsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in the title and abstract details"),
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final submission = {
        "user_id": widget.userData?['id'] ?? 0,
        "sub_theme": subTheme,
        "presentation_type": presentationType,
        "category": category,
        "title": titleController.text,
        "keywords": keywordsController.text,
        "abstract_details": abstractDetailsController.text,
        "authors": authors
            .map(
              (a) => {
                "prefix": a.prefix,
                "first_name": a.firstName.text,
                "middle_name": a.middleName.text,
                "last_name": a.lastName.text,
                "email": a.email.text,
                "author_type": a.authorType,
                "designation": a.designation.text,
                "institution": a.institution.text,
                "city": a.city.text,
                "state": a.state.text,
                "country": a.country.text,
                "pincode": a.pincode.text,
              },
            )
            .toList(),
      };

      final result = await ApiService.submitAbstract(submission);

      if (result['status'] == 'success') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(result['message'])));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'] ?? "Submission failed")),
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

  Widget buildDropdown(
    String label,
    String? value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        hint: Text(label),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget buildTextField(
    String hint, {
    int maxLines = 1,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget authorSection(AuthorData author, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                index == 0 ? "Primary Author" : "Co-Author $index",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (index > 0)
                IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () => removeAuthor(index),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: buildDropdown("Prefix", author.prefix, [
                  "Mr",
                  "Dr",
                  "Ms",
                ], (v) => setState(() => author.prefix = v)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: buildTextField(
                  "First Name",
                  controller: author.firstName,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: buildTextField(
                  "Middle Name",
                  controller: author.middleName,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: buildTextField("Last Name", controller: author.lastName),
              ),
            ],
          ),
          buildTextField("Email", controller: author.email),
          buildDropdown(
            "Author Type",
            author.authorType,
            ["Author", "Co Author"],
            (v) => setState(() => author.authorType = v),
          ),
          buildTextField("Designation", controller: author.designation),
          buildTextField("Institution", controller: author.institution),
          Row(
            children: [
              Expanded(child: buildTextField("City", controller: author.city)),
              const SizedBox(width: 10),
              Expanded(
                child: buildTextField("State", controller: author.state),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: buildTextField("Country", controller: author.country),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: buildTextField("Pincode", controller: author.pincode),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        title: const Text("Submit"),
        backgroundColor: Colors.blue.shade900,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Submission Details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            buildDropdown("Sub-Theme", subTheme, [
              "Blended Learning",
              "Dental Education",
            ], (val) => setState(() => subTheme = val)),
            buildDropdown(
              "Presentation Type",
              presentationType,
              ["Oral Presentation", "Poster"],
              (val) => setState(() => presentationType = val),
            ),
            buildDropdown("Category", category, [
              "Systematic Review",
              "Case Study",
            ], (val) => setState(() => category = val)),
            buildTextField("Title of Paper", controller: titleController),
            buildTextField("Keywords", controller: keywordsController),
            buildTextField(
              "Abstract Details (max 400 words)",
              maxLines: 5,
              controller: abstractDetailsController,
            ),
            const SizedBox(height: 20),
            const Text(
              "Author(s) Details",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...authors.asMap().entries.map(
              (entry) => authorSection(entry.value, entry.key),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: addAuthor,
              child: Row(
                children: const [
                  Icon(Icons.add_circle_outline, size: 20, color: Colors.blue),
                  SizedBox(width: 5),
                  Text("Add Co-Author", style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: isLoading ? null : submitForm,
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
