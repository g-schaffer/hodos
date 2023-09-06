import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class IncriptionPage extends StatelessWidget {
  const IncriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> inscriptionForm = GlobalKey<FormState>();

    final Map<String, String> formValues = {
      'email': "",
      'username': "",
      'first_name': "",
      'last_name': "",
      'pasword': "",
      'confirm_password': "",
    };

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 81, 114, 85),
        title: const Text("Hodos"),
        titleSpacing: 0,
        centerTitle: true,
        toolbarHeight: 25,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Form(
            key: inscriptionForm,
            child: Column(
              children: [
                CustomInputField(
                  labelText: "Email",
                  suffixicon: (Icons.mail),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  formProperty: 'email',
                  formValues: formValues,
                ),
                const SizedBox(height: 30),
                CustomInputField(
                  labelText: "Username",
                  suffixicon: (Icons.people_alt),
                  formProperty: 'username',
                  formValues: formValues,
                  obscureText: false,
                ),
                const SizedBox(height: 30),
                CustomInputField(
                  labelText: "Name",
                  suffixicon: (Icons.people_alt),
                  formProperty: 'first_name',
                  formValues: formValues,
                  obscureText: false,
                ),
                const SizedBox(height: 30),
                CustomInputField(
                  labelText: "Lastname",
                  suffixicon: (Icons.near_me),
                  formProperty: 'last_name',
                  formValues: formValues,
                  obscureText: false,
                ),
                const SizedBox(height: 30),
                CustomInputField(
                  labelText: "Password",
                  suffixicon: (Icons.password),
                  formProperty: 'password',
                  formValues: formValues,
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                CustomInputField(
                  labelText: "Confirm password",
                  suffixicon: (Icons.password),
                  formProperty: 'confirm_password',
                  formValues: formValues,
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    //Done and print values form
                    print(inscriptionForm);
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text("Done"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
