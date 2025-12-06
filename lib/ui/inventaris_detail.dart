import 'package:flutter/material.dart';
import 'package:responsi_2_mobile_h1d023094/bloc/inventaris_bloc.dart';
import 'package:responsi_2_mobile_h1d023094/models/inventaris.dart';
import 'package:responsi_2_mobile_h1d023094/ui/inventaris_form.dart';
import 'package:responsi_2_mobile_h1d023094/ui/inventaris_page.dart';
import 'package:responsi_2_mobile_h1d023094/widget/warning_dialog.dart';

class InventarisDetail extends StatefulWidget {
  Inventaris? inventaris;
  InventarisDetail({Key? key, this.inventaris}) : super(key: key);

  @override
  _InventarisDetailState createState() => _InventarisDetailState();
}

class _InventarisDetailState extends State<InventarisDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Inventaris Nopalmart'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Nama: ${widget.inventaris!.nama}",
                style: const TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 10),
              Text(
                "Harga: Rp ${widget.inventaris!.harga}",
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 10),
              Text(
                "Jumlah Stok: ${widget.inventaris!.jumlah}",
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 10),
              Text(
                "Tanggal Masuk: ${widget.inventaris!.tanggalMasuk}",
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 10),
              Text(
                "Tanggal Kedaluwarsa: ${widget.inventaris!.tanggalKedaluwarsa}",
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 20),
              _tombolHapusEdit()
            ],
          ),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(foregroundColor: Colors.green),
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InventarisForm(
                  inventaris: widget.inventaris!,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 10),
        OutlinedButton(
          style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            InventarisBloc.deleteInventaris(
                    id: int.parse(widget.inventaris!.id!))
                .then((value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const InventarisPage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}