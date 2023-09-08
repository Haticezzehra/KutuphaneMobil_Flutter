import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Controllers/get_token_controller.dart';
import '../Models/token_model.dart';

import 'ana_sayfa.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _userNamecontroller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> rememberMe = ValueNotifier<bool>(false);

  void _loadData() async {
    final box = GetStorage();
    _userNamecontroller.text = box.read('username');
    _passwordController.text = box.read('password');
    rememberMe.value = box.read("rememberme");
  }

  void _saveCredentials() async {
    final box = GetStorage();
    if (rememberMe.value) {
      box.write('rememberme', rememberMe.value);
    }
    box.write('username', _userNamecontroller.text);
    box.write('password', _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loadData();
      _saveCredentials();
    });
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: height * .25,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("lib/images/topImage.png")),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Merhaba\n Hoşgeldiniz",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        customSizedBox(),
                        TextField(
                          controller: _userNamecontroller,
                          decoration: customDecoration("Kullanıcı Adı"),
                        ),
                        customSizedBox(),
                        TextField(
                          controller: _passwordController,
                          decoration: customDecoration("Parola"),
                        ),
                        Row(
                          children: [
                            ValueListenableBuilder<bool>(
                              valueListenable: rememberMe,
                              builder: (context, value, child) {
                                return Checkbox(
                                  value: value,
                                  onChanged: (newValue) {
                                    setState(() {
                                      rememberMe.value = newValue!;
                                    });
                                  },
                                );
                              },
                            ),
                            const Text('Remember me'),
                          ],
                        ),
                        customSizedBox(),
                        customSizedBox(),
                        Center(
                          child: TextButton(
                            onPressed: () async {
                              _saveCredentials();
                              TokenModel token = await ClientHelper.getToken(
                                  _userNamecontroller.text,
                                  _passwordController.text);
                              ClientHelper.setToken(token);
                              Get.to(const AnaSayfa());
                            },
                            child: Container(
                              height: 50,
                              width: 150,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 68),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: const Color(0xFF753cce)),
                              child: const Center(
                                  child: Text(
                                "Giriş Yap",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                        )
                      ])),
            ],
          ),
        ),
      ),
    );
  }

  Widget customSizedBox() => const SizedBox(
        height: 20,
      );
  InputDecoration customDecoration(String hintText) {
    return const InputDecoration(
        hintText: "Kullanici Adi",
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)));
  }
}
