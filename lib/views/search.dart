import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopi/controller/search_controller.dart';
import 'package:shopi/views/home_page.dart'; // Assuming you have a model named 'ItemController'

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchControllers>(
      builder: (context, searchController, _) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(),
                    ),
                    (route) => false);
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
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
                            onChanged: searchController.searchItems,
                            decoration: const InputDecoration(
                              hintText: 'Search...',
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          searchController
                              .searchItems(searchTextController.text);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Visibility(
                      visible: searchController.showList,
                      child: searchController.filteredProducts.isEmpty
                          ? Container()
                          : ListView.builder(
                              itemCount:
                                  searchController.filteredProducts.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    leading: Image.asset(
                                      searchController.filteredProducts[index]
                                          ['image'],
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    title: Text(searchController
                                        .filteredProducts[index]['name']),
                                    subtitle: Text(searchController
                                        .filteredProducts[index]['price']),
                                    trailing: IconButton(
                                      icon: Icon(
                                        searchController.filteredProducts[index]
                                                ['isFavorite']
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                      ),
                                      onPressed: () {
                                        searchController.toggleFavorite(index);
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
