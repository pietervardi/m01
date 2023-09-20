import 'package:flutter/material.dart';
import 'package:minggu_01/contoh2.dart';

var data = [];

Future<List<Map<String, String>>> getUserData() async {
  await Future.delayed(const Duration(seconds: 3));
  return [
    {'nama': 'Bunny', 'nomorTelepon': '0123456789'},
    {'nama': 'Funny', 'nomorTelepon': '0987654321'},
    {'nama': 'Miles', 'nomorTelepon': '0192837465'},
  ];
}

void main() async {
  runApp(const MyApp());
  await getUserData();
  print('Getting user data...');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: const Contoh2(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: getUserData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
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
                    title: Text(user['nama']),
                    subtitle: Text(user['nomorTelepon']),
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

// import 'package:flutter/material.dart';
// import 'package:minggu_01/contoh2.dart';

// class User {
//   final String nama;
//   final String nomorTelepon;

//   User(this.nama, this.nomorTelepon);
// }

// var data = <User>[];

// Future<void> getUserData() {
//   data = [
//     User('Bunny', '0123456789'),
//     User('Funny', '0987654321'),
//     User('Miles', '0192837465'),
//   ];
//   return Future.delayed(const Duration(seconds: 3), () {
//     print('Downloaded ${data.length} data');
//   });
// }

// void main() async {
//   runApp(const MyApp());
//   await getUserData();
//   print('Getting user data...');
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       // home: const MyHomePage(title: 'Flutter Demo Home Page'),
//       home: const Contoh2(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text(
//           widget.title,
//           style: const TextStyle(
//             color: Colors.white
//           ),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Daftar Pengguna',
//               style: Theme.of(context).textTheme.titleLarge,
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: data.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(data[index].nama),
//                     subtitle: Text(data[index].nomorTelepon),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
