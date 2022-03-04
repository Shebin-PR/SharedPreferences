import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  List<Map<String, dynamic>> detail = [];
  int lgt = 0;

  saveDataLocally(String email, String phone) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final a = prefs.getStringList("emails");
    final b = prefs.getStringList("phones");

    if (a != null && b != null) {
      final yy = a
          .where((element) => element.toLowerCase() == email.toLowerCase())
          .isEmpty;
      final zz = b
          .where((element) => element.toLowerCase() == phone.toLowerCase())
          .isEmpty;

      if (yy && zz) {
        a.add(email);
        await prefs.setStringList("emails", a);
        b.add(phone);
        await prefs.setStringList("phones", b);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Already exist")));
      }
    } else {
      final tv = [email];
      await prefs.setStringList("emails", tv);
      final sv = [phone];
      await prefs.setStringList("phones", sv);
    }
    setState(() {});
  }

  List<String> nmn = [];
  List<String> abc = [];

  abcd() async {
    // detail = [];
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final a = preferences.getStringList("emails");
    final b = preferences.getStringList("phones");

    if (a != null && b != null) {
      abc = a.toList();
      nmn = b.toList();
    }
    if (abc.length == nmn.length) {
      lgt = abc.length;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    abcd();
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomeScreen"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextFormField(
                    controller: emailController,
                    style: const TextStyle(
                      color: Colors.black,
                      letterSpacing: 0.8,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter your mail",
                      prefixIcon: const Icon(
                        Icons.mail,
                        color: Colors.blue,
                      ),
                      label: const Text(
                        "Enter your mail",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: phoneController,
                    style: const TextStyle(
                      color: Colors.black,
                      letterSpacing: 0.8,
                      fontSize: 16,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter your number",
                      prefixIcon: const Icon(
                        Icons.phone,
                        color: Colors.blue,
                      ),
                      label: const Text(
                        "Enter your number",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      saveDataLocally(
                          emailController.text, phoneController.text);

                      setState(() {});

                      emailController.clear();
                      phoneController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red[900],
                    ),
                    icon: const Icon(Icons.save),
                    label: const Text(
                      "Save",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: ListView.builder(
                  itemCount: lgt,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          Text(
                            "Email  : " + abc[index],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20),
                          ),
                          Text(
                            "Phone : " + nmn[index],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
