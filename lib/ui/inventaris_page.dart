import 'package:flutter/material.dart';
import 'package:responsi_2_mobile_h1d023094/bloc/logout_bloc.dart';
import 'package:responsi_2_mobile_h1d023094/bloc/inventaris_bloc.dart';
import 'package:responsi_2_mobile_h1d023094/models/inventaris.dart';
import 'package:responsi_2_mobile_h1d023094/ui/login_page.dart';
import 'package:responsi_2_mobile_h1d023094/ui/inventaris_detail.dart';
import 'package:responsi_2_mobile_h1d023094/ui/inventaris_form.dart';

class InventarisPage extends StatefulWidget {
  const InventarisPage({Key? key}) : super(key: key);

  @override
  _InventarisPageState createState() => _InventarisPageState();
}

class _InventarisPageState extends State<InventarisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventaris Bahan Nopalmart'),
        backgroundColor: Colors.green,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InventarisForm()));
                },
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                          (route) => false)
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: InventarisBloc.getInventaris(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListInventaris(list: snapshot.data)
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ListInventaris extends StatelessWidget {
  final List? list;

  const ListInventaris({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemInventaris(inventaris: list![i]);
        });
  }
}

class ItemInventaris extends StatelessWidget {
  final Inventaris inventaris;

  const ItemInventaris({Key? key, required this.inventaris}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InventarisDetail(inventaris: inventaris)));
      },
      child: Card(
        child: ListTile(
          title: Text(inventaris.nama!),
          subtitle: Text(
              'Rp ${inventaris.harga} • Stok: ${inventaris.jumlah} • Exp: ${inventaris.tanggalKedaluwarsa}'),
        ),
      ),
    );
  }
}