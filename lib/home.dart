import 'package:crud_sqlite/addAnimal.dart';
import 'package:crud_sqlite/editAnimal.dart';
import 'package:flutter/material.dart';
import 'package:crud_sqlite/animal.dart';
import 'db.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  bool isLoading = false;
  List<Animal> animales = List.empty(growable: true);
  final DB _myDatabase = DB();
  int count = 0;

  // getData from DATABASE
  getDataFromDb() async {
    await _myDatabase.initializeDatabase();
    List<Map<String, Object?>> map = await _myDatabase.getEmpList();
    for (int i = 0; i < map.length; i++) {
      animales.add(Animal.toEmp(map[i]));
    }
    count = await _myDatabase.count_Animal();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // solo para mostrar un registro, no va de acuerdo a la logica
    // animales.add(Animal(name: 'abc', especie: 'xyz'));

    getDataFromDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animales ($count)'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : animales.isEmpty
              ? const Center(
                  child: Text('Aun no hay animales!'),
                )
              : ListView.builder(
                  itemCount: animales.length,
                  itemBuilder: (context, index) => Card(
                    child: ListTile(
                      onTap: () {
                        // aqui va una navegacion para editar
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditAnimal(
                                animal: animales[index],
                                myDatabase: _myDatabase,
                              ),
                            ));
                      },
                      title: Text(
                        '${animales[index].name} ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(animales[index].especie),
                      trailing: IconButton(
                          onPressed: () async {
                            // LOGICA PARA ELIMINAR DE DB
                            String name = animales[index].name;
                            await _myDatabase.delete_Animal(animales[index]);
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text('$name deleted.')));
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                  (route) => false);
                            }
                            //
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            //
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddAnimal(myDatabase: _myDatabase),
                ));
            //
          }),
    );
  }
}
