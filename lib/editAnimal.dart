import 'package:flutter/material.dart';
import 'home.dart';
import 'animal.dart';
import 'db.dart';

class EditAnimal extends StatefulWidget {
  final DB myDatabase;
  final Animal animal;

  const EditAnimal({super.key, required this.animal, required this.myDatabase});

  @override
  State<EditAnimal> createState() => _EditAnimalState();
}

class _EditAnimalState extends State<EditAnimal> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController especieConytroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    idController.text = widget.animal.id.toString();
    nameController.text = widget.animal.name;
    especieConytroller.text = widget.animal.especie;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar Animal'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Emp Id

              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Nombre del animal',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Emp Designation
              TextField(
                controller: especieConytroller,
                decoration: const InputDecoration(
                  hintText: 'Especie del animal',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              //acciones
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        //
                        int? valor = int.tryParse(idController.text);
                        Animal animal = Animal(
                          id: int.tryParse(idController.text),
                          name: nameController.text,
                          especie: especieConytroller.text,
                        );

                        await widget.myDatabase.update_Animal(animal);

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.orange,
                              content: Text('${animal.name} updated.')));
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                              (route) => false);
                        }
                        //
                      },
                      child: const Text('Actualizar')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey),
                      onPressed: () {
                        nameController.text = '';
                        especieConytroller.text = '';
                      },
                      child: const Text('Reset')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
