import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../dio_client.dart';
import '../models/item_model.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  late Future<ItemModel> _item;

  @override
  void initState() {
    super.initState();
    _item = fetchItem();
  }

  Future<ItemModel> fetchItem() async {
    final dioClient = DioClient();
    Response response = await dioClient.readData(1); // Fetch item with id 1
    return ItemModel.fromJson(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD App'),
      ),
      body: FutureBuilder<ItemModel>(
        future: _item,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final item = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ID: ${item.id}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Title: ${item.title}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Body: ${item.body}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('No Data'));
        },
      ),
    );
  }
}
