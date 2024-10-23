import 'package:flutter/material.dart';
import 'pesantren.dart';
import 'api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pesantren App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PesantrenPage(),
    );
  }
}

class PesantrenPage extends StatefulWidget {
  const PesantrenPage({Key? key}) : super(key: key);

  @override
  _PesantrenPageState createState() => _PesantrenPageState();
}

class _PesantrenPageState extends State<PesantrenPage> {
  late Future<List<Pesantren>> pesantrenList;

  @override
  void initState() {
    super.initState();
    pesantrenList = fetchPesantren();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pesantren'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Pesantren>>(
          future: pesantrenList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final pesantrenList = snapshot.data!;
              return ListView.builder(
                itemCount: pesantrenList.length,
                itemBuilder: (context, index) {
                  final pesantren = pesantrenList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Text(
                            pesantren.nama[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        title: Text(
                          pesantren.nama,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Alamat: ${pesantren.alamat}'),
                            Text('Kyia: ${pesantren.kyai}'),
                            const SizedBox(height: 4), // Spacing between items
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // You can navigate to another page or show more details
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(pesantren.nama),
                              content: Text(
                                  'NSPP: ${pesantren.nspp}\nAlamat: ${pesantren.alamat}\nKyai: ${pesantren.kyai}'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Tutup'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('Tidak ada data'));
            }
          },
        ),
      ),
    );
  }
}
