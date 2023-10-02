import 'package:flutter/material.dart';
import "package:inventory/ItemsCard.dart";
import 'package:inventory/Services/database.dart';
import 'package:inventory/models/products.dart';

class SearChBar extends StatefulWidget {
  const SearChBar({super.key});

  @override
  State<SearChBar> createState() => _SearChBarState();
}

class _SearChBarState extends State<SearChBar> {
  final TextEditingController _searchController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  List<Product> searchResults = [];

  List<Product> filteredResults = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchProducts() async {
    print("fetching&&&*(((((())))))");
    try {
      List<Product> products = await _firestoreService.getProducts();
      setState(() {
        filteredResults = products;
      });
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  void performSearch(String value) {
    _fetchProducts();
    setState(() {
      searchResults = filteredResults
          .where(
              (item) => item.name.toLowerCase().contains(value.toLowerCase()))
          .map((item) => Product(
              name: item.name,
              price: item.price,
              quantity: item.quantity,
              pid: item.pid,
              distributor: item.distributor,
              expiredate: item.expiredate,
              category: item.category,
              imageUrl: item.imageUrl))
          .toList();
      print("found products $searchResults");
    });
  }

  void _showSearchResults(BuildContext context) {
    showSearch(
      context: context,
      delegate: ProductSearchDelegate(searchResults),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.82,
      child: TextFormField(
        controller: _searchController,
        onChanged: (value) => performSearch(value),
        cursorColor: const Color.fromRGBO(107, 59, 225, 1),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: "Search...",
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Color.fromRGBO(107, 59, 225, 1),
            ),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              _showSearchResults(context); // Trigger search here
            },
            child: const Icon(
              Icons.search_outlined,
              color: Color.fromRGBO(107, 59, 225, 1),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(107, 59, 225, 1),
              width: 4,
            ),
          ),
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class ProductSearchDelegate extends SearchDelegate<Product> {
  final List<Product> searchResults;

  ProductSearchDelegate(this.searchResults);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          searchResults.clear();
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredResults = searchResults
        .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredResults.length,
      itemBuilder: (context, index) {
        final item = filteredResults[index];
        return SizedBox(width: 200, child: ItmeCard(item));
      },
    );
  }

  bool isLoading = false;
  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredResults = searchResults
        .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading
          ? Center(
              child: Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    filteredResults.isEmpty
                        ? const Center(
                            child: Text(" product is Empty"),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(
                              12,
                            ),
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                primary: false,
                                itemCount: filteredResults.length,
                                itemBuilder: (ctx, index) {
                                  Product singleProduct =
                                      filteredResults[index];
                                  return SizedBox(
                                      width: 200,
                                      child: ItmeCard(singleProduct));
                                }),
                          ),
                    const SizedBox(
                      height: 12.0,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
