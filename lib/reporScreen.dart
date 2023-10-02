import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  final List<Product> topSellingProducts = [
    Product('Product D', 15, "assets/images/shoe1.jpg"),
    Product('Product E', 12, "assets/images/shoe1.jpg"),
    Product('Product F', 20, "assets/images/shoe1.jpg"),
  ];
  final List<Category> categoryDistribution = [
    Category('Category X', 30),
    Category('Category Y', 25),
    Category('Category Z', 45),
  ];

  ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(107, 59, 225, 1),
        title: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .3,
            ),
            const Text('Inventory Report'),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRunningOutProducts(),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                _buildTotalStockCircularIndicator(),
                const SizedBox(
                  width: 10,
                ),
                _buildTotalCategoryCircularIndicator(),
              ],
            ),
            const SizedBox(height: 32.0),
            _buildTopSellingProducts(),
            const SizedBox(height: 16.0),
            _buildStockTrendsChart(),
            const SizedBox(height: 16.0),
            _buildCategoryDistributionChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildRunningOutProducts() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Running Out Products',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 140.0,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('users')
                    .doc(user!.uid)
                    .collection('products')
                    .where('quantity', isLessThan: 10)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final runningOutProducts = snapshot.data!.docs;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: runningOutProducts.length,
                      itemBuilder: (context, index) {
                        final product = runningOutProducts[index];
                        final productData =
                            product.data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 100.0,
                                height: 100.0,
                                alignment: Alignment.center,
                                child: ClipRRect(
                                  child: Image.network(
                                    productData['imageUrl'] as String,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text('Quantity: ${productData['quantity']}'),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSellingProducts() {
    return Card(
      child: SizedBox(
        width: 400.0, // Adjust the width to your preference
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Top selling Products',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                height: 140.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: topSellingProducts.length,
                  itemBuilder: (context, index) {
                    final product = topSellingProducts[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                              width: 100.0,
                              height: 100.0,
                              // color: Colors.red,
                              alignment: Alignment.center,
                              child: ClipRRect(
                                child: Image.asset(
                                  product.ImageUrl,
                                  fit: BoxFit.fill,
                                ),
                              )),
                          const SizedBox(height: 4.0),
                          Text('Sold: ${product.quantity}'),
                        ],
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

  Widget _buildStockTrendsChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Stock Trends',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            AspectRatio(
              aspectRatio: 1.5,
              child: LineChart(
                LineChartData(
                  // Configure your line chart data here (mock data provided)
                  titlesData: const FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  gridData: const FlGridData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 10),
                        const FlSpot(2, 20),
                        const FlSpot(4, 15),
                        const FlSpot(6, 18),
                        const FlSpot(8, 25),
                      ],
                      color: Colors.blue,
                      isCurved: true,
                      dotData: const FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryDistributionChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Category Distribution',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            AspectRatio(
              aspectRatio: 1.5,
              child: BarChart(
                BarChartData(
                  // Configure your bar chart data here (mock data provided)
                  titlesData: const FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  gridData: const FlGridData(show: true),
                  barGroups: categoryDistribution.map((category) {
                    return BarChartGroupData(
                      x: category.percentage,
                      barRods: [
                        BarChartRodData(
                          toY: category.percentage.toDouble(),
                          color: Colors.green,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTotalStockCircularIndicator() {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  return Center(
    child: Container(
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.green, width: 5),
      ),
      child: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection('users')
              .doc(user!.uid)
              .collection('products')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int totalItems = snapshot.data!.docs.length;

              return Column(
                children: [
                  const SizedBox(
                    height: 45,
                  ),
                  Text(
                    totalItems.toString(),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    "Total Items",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    ),
  );
}

Widget _buildTotalCategoryCircularIndicator() {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  return Center(
    child: Container(
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.blue, width: 5),
      ),
      child: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore
              .collection('users')
              .doc(user!.uid)
              .collection('products')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final items = snapshot.data!.docs;
              final categoryCounts = <String, int>{};

              for (final item in items) {
                final categoryName = item['category'] as String;
                categoryCounts[categoryName] =
                    (categoryCounts[categoryName] ?? 0) + 1;
              }

              final totalCategories = categoryCounts.length;

              return Column(
                children: [
                  const SizedBox(
                    height: 45,
                  ),
                  Text(
                    totalCategories.toString(),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    "Total Categories",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    ),
  );
}

class Product {
  final String name;
  final int quantity;
  final String ImageUrl;

  Product(this.name, this.quantity, this.ImageUrl);
}

class Category {
  final String name;
  final int percentage;

  Category(this.name, this.percentage);
}
