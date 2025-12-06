import 'package:flutter/material.dart';
import 'package:responsi_2_mobile_h1d023094/bloc/inventaris_bloc.dart';
import 'package:responsi_2_mobile_h1d023094/models/inventaris.dart';
import 'package:responsi_2_mobile_h1d023094/ui/inventaris_page.dart';
import 'package:responsi_2_mobile_h1d023094/widget/warning_dialog.dart';

class InventarisForm extends StatefulWidget {
  Inventaris? inventaris;
  InventarisForm({Key? key, this.inventaris}) : super(key: key);

  @override
  _InventarisFormState createState() => _InventarisFormState();
}

class _InventarisFormState extends State<InventarisForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH INVENTARIS";
  String tombolSubmit = "SIMPAN";

  final _namaTextboxController = TextEditingController();
  final _hargaTextboxController = TextEditingController();
  final _jumlahTextboxController = TextEditingController();
  final _tanggalMasukTextboxController = TextEditingController();
  final _tanggalKedaluwarsaTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.inventaris != null) {
      setState(() {
        judul = "UBAH INVENTARIS";
        tombolSubmit = "UBAH";
        _namaTextboxController.text = widget.inventaris!.nama!;
        _hargaTextboxController.text = widget.inventaris!.harga.toString();
        _jumlahTextboxController.text = widget.inventaris!.jumlah.toString();
        _tanggalMasukTextboxController.text = widget.inventaris!.tanggalMasuk!;
        _tanggalKedaluwarsaTextboxController.text =
            widget.inventaris!.tanggalKedaluwarsa!;
      });
    } else {
      judul = "TAMBAH INVENTARIS";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul + " Nopalmart"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _namaTextField(),
                _hargaTextField(),
                _jumlahTextField(),
                _tanggalMasukTextField(),
                _tanggalKedaluwarsaTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _namaTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Bahan"),
      keyboardType: TextInputType.text,
      controller: _namaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama harus diisi";
        }
        return null;
      },
    );
  }

  Widget _hargaTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Harga"),
      keyboardType: TextInputType.number,
      controller: _hargaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  Widget _jumlahTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Jumlah Stok"),
      keyboardType: TextInputType.number,
      controller: _jumlahTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jumlah harus diisi";
        }
        return null;
      },
    );
  }

  Widget _tanggalMasukTextField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: "Tanggal Masuk (YYYY-MM-DD)",
          hintText: "2024-01-15"),
      keyboardType: TextInputType.datetime,
      controller: _tanggalMasukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Tanggal Masuk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _tanggalKedaluwarsaTextField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: "Tanggal Kedaluwarsa (YYYY-MM-DD)",
          hintText: "2024-12-31"),
      keyboardType: TextInputType.datetime,
      controller: _tanggalKedaluwarsaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Tanggal Kedaluwarsa harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        child: Text(tombolSubmit, style: const TextStyle(color: Colors.white)),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.inventaris != null) {
                ubah();
              } else {
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Inventaris createInventaris = Inventaris(id: null);
    createInventaris.nama = _namaTextboxController.text;
    createInventaris.harga = int.parse(_hargaTextboxController.text);
    createInventaris.jumlah = int.parse(_jumlahTextboxController.text);
    createInventaris.tanggalMasuk = _tanggalMasukTextboxController.text;
    createInventaris.tanggalKedaluwarsa =
        _tanggalKedaluwarsaTextboxController.text;

    InventarisBloc.addInventaris(inventaris: createInventaris).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const InventarisPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Inventaris updateInventaris = Inventaris(id: widget.inventaris!.id!);
    updateInventaris.nama = _namaTextboxController.text;
    updateInventaris.harga = int.parse(_hargaTextboxController.text);
    updateInventaris.jumlah = int.parse(_jumlahTextboxController.text);
    updateInventaris.tanggalMasuk = _tanggalMasukTextboxController.text;
    updateInventaris.tanggalKedaluwarsa =
        _tanggalKedaluwarsaTextboxController.text;

    InventarisBloc.updateInventaris(inventaris: updateInventaris).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const InventarisPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
