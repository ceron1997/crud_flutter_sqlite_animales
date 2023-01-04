import 'package:flutter/material.dart';
import 'animal.dart';
import 'db.dart';
import 'home.dart';

class AddAnimal extends StatefulWidget {
  final DB myDatabase;
  const AddAnimal({super.key, required this.myDatabase});

  @override
  State<AddAnimal> createState() => _AddAnimalState();
}

class _AddAnimalState extends State<AddAnimal> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController especieController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Animal'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: idController,
                decoration: const InputDecoration(
                  hintText: 'codigo numerico',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),
              // Emp Id

              // Emp Name
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Nombre del Animal',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Emp Designation
              TextField(
                controller: especieController,
                decoration: const InputDecoration(
                  hintText: 'Especie del Animal',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Emp Gender

              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        int? valor = int.tryParse(idController.text);
                        //
                        Animal animal = Animal(
                            id: valor,
                            name: nameController.text,
                            especie: especieController.text);
                        await widget.myDatabase.insert_Animal(animal);

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('${animal.name} agregado.')));
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                              (route) => false);
                        }

                        //
                      },
                      child: const Text('Agregar')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey),
                      onPressed: () {
                        //

                        nameController.text = '';
                        especieController.text = '';

                        //
                      },
                      child: const Text('Limpiar')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
