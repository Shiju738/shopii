import 'package:flutter/material.dart';
import 'package:shopi/model/list.dart'; // Assuming you have a model named 'ItemController'

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchTextController = TextEditingController();
  final ItemController itemController = ItemController();

  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    searchItems('');
  }

  void searchItems(String query) {
    setState(() {
      filteredProducts = itemController.searchItems(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: TextField(
                        controller: searchTextController,
                        onChanged: searchItems,
                        decoration: const InputDecoration(
                          hintText: 'Search...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      searchItems(searchTextController.text);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: filteredProducts.isEmpty
                    ? Container()
                    : ListView.builder(
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: Image.asset(
                                filteredProducts[index]['image'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              title: Text(filteredProducts[index]['name']),
                              subtitle: Text(filteredProducts[index]['price']),
                              trailing: IconButton(
                                icon: Icon(
                                  filteredProducts[index]['isFavorite']
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                ),
                                onPressed: () {
                                  setState(() {
                                    filteredProducts[index]['isFavorite'] =
                                        !filteredProducts[index]['isFavorite'];
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
