import 'package:flutter/material.dart';
import 'package:minggu_01/contoh2.dart';

var data = [];

Future<List<Map<String, dynamic>>> getUserData() async {
  await Future.delayed(const Duration(seconds: 3), () {
    data = [
      {'nama': 'Bunny', 'nomorTelepon': '0123456789'},
      {'nama': 'Sandy', 'nomorTelepon': '0987654327'},
      {'nama': 'Funny', 'nomorTelepon': '0987654321'},
      {'nama': 'Miles', 'nomorTelepon': '0192837465'},
      {'nama': 'Budi', 'nomorTelepon': '0123456782'},
      {'nama': 'Adi', 'nomorTelepon': '0123456784'},
      {'nama': 'Ucok', 'nomorTelepon': '0123456783'},
      {'nama': 'Agus', 'nomorTelepon': '0123456781'},
      {'nama': 'Beni', 'nomorTelepon': '0123456785'},
      {'nama': 'Harry', 'nomorTelepon': '0123456787'},
      {'nama': 'Ronny', 'nomorTelepon': '0987654322'},
      {'nama': 'Kendy', 'nomorTelepon': '0987654323'},
      {'nama': 'Doni', 'nomorTelepon': '0123456786'},
      {'nama': 'Kori', 'nomorTelepon': '0987654328'},
      {'nama': 'Anton', 'nomorTelepon': '0987654324'},
      {'nama': 'Udil', 'nomorTelepon': '0987654325'},
      {'nama': 'Luis', 'nomorTelepon': '0123456788'},
      {'nama': 'Arna', 'nomorTelepon': '0987654326'},
      {'nama': 'Suli', 'nomorTelepon': '0987654329'},
    ];
  });
  return data.map((item) => Map<String, dynamic>.from(item)).toList();
}

class Contoh1 extends StatefulWidget {
  const Contoh1({Key? key}) : super(key: key);

  @override
  State<Contoh1> createState() => _Contoh1State();
}

class _Contoh1State extends State<Contoh1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Future',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          ElevatedButton(
            child: const Text('Contoh 2'),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Contoh2()));
            },
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getUserData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.hasData) {
            final users = snapshot.data;

            if (users != null && users.isNotEmpty) {
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text((index + 1).toString()),
                    ),
                    title: Text(user['nama']),
                    subtitle: Text("Hp: ${user['nomorTelepon']}"),
                  );
                },
              );
            } else {
              return const Text('No user data available.');
            }
          }

          return Container();
        },
      ),
    );
  }
}
