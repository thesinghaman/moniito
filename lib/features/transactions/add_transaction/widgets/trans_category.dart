import 'package:flutter/material.dart';
import 'package:moniito_v2/features/transactions/models/transaction_model.dart';

import 'package:unicons/unicons.dart';

class TransactionsCategory extends StatefulWidget {
  const TransactionsCategory({super.key});

  @override
  State<TransactionsCategory> createState() => _TransactionsCategoryState();
}

class _TransactionsCategoryState extends State<TransactionsCategory> {
  Category selectedCategory = Category.artAndCrafts;

  TextEditingController searchController = TextEditingController();
  List<MapEntry<Category, String>> filteredCategories = [];

  @override
  void initState() {
    super.initState();
    // Initialize the filtered list with all categories initially.
    filteredCategories = categoryType.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCloseButton(size, context),
              _buildSearchField(size),
              _buildList(size),
            ],
          ),
        ),
      ),
    );
  }

  /*
  Widget _buildList(Size size) {
    final sortedEntries = categoryType.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    Map<String, List<MapEntry<Category, String>>> groupedEntries = {};

    for (int i = 0; i < sortedEntries.length; i++) {
      final entry = sortedEntries[i];
      final firstLetter = entry.value[0].toUpperCase();
      groupedEntries[firstLetter] ??= [];
      groupedEntries[firstLetter]!.add(entry);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...groupedEntries.entries.map((group) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.025),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    group.key,
                    style: GoogleFonts.montserrat(
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                ...group.value.map((entry) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = entry.key;
                        Navigator.pop(context, selectedCategory);
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromRGBO(44, 185, 176, 1),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            entry.value,
                            style: GoogleFonts.montserrat(
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                      ],
                    ),
                  );
                }).toList(),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
  */

  Widget _buildList(Size size) {
    // Extract unique first letters from the filtered categories
    final firstLetters = filteredCategories
        .map((entry) => entry.value[0].toUpperCase())
        .toSet()
        .toList()
      ..sort();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.025),
          ...firstLetters.map((letter) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.025),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    letter,
                  ),
                ),
                ...filteredCategories
                    .where((entry) => entry.value[0].toUpperCase() == letter)
                    .map((entry) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = entry.key;
                        Navigator.pop(context, selectedCategory);
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromRGBO(44, 185, 176, 1),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            entry.value,
                            style: TextStyle(
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                      ],
                    ),
                  );
                }).toList(),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCloseButton(Size size, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            UniconsLine.angle_left_b,
            size: size.height * 0.04,
            color: const Color.fromRGBO(128, 139, 150, 1),
          ),
        )
      ],
    );
  }

  Widget _buildSearchField(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: TextField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search Categories',
          filled: true,
          fillColor: searchController.text.isEmpty
              ? const Color.fromRGBO(248, 247, 251, 1)
              : Colors.transparent,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: searchController.text.isEmpty
                    ? Colors.transparent
                    : const Color.fromRGBO(44, 185, 176, 1),
              )),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                const BorderSide(color: Color.fromRGBO(44, 185, 176, 1)),
          ),
          prefixIcon: Icon(
            UniconsLine.search_alt,
            color: searchController.text.isEmpty
                ? const Color(0xFF151624).withOpacity(0.5)
                : const Color.fromRGBO(44, 185, 176, 1),
            size: size.width * 0.06,
          ),
        ),
        onChanged: (text) {
          // Filter the categories based on the search input
          setState(() {
            filteredCategories = categoryType.entries
                .where((entry) =>
                    entry.value.toLowerCase().contains(text.toLowerCase()))
                .toList()
              ..sort((a, b) => a.value.compareTo(b.value));

            // If there are no search matches, include "Miscellaneous"
            if (filteredCategories.isEmpty) {
              // Replace 'Category.miscellaneous' with the actual value you want
              filteredCategories = [
                const MapEntry(Category.miscellaneous, 'Miscellaneous')
              ];
            }
          });
        },
      ),
    );
  }
}
