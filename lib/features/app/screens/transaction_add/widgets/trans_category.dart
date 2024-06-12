import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moniito_v2/features/app/models/transaction_model.dart';
import 'package:unicons/unicons.dart';
import 'package:moniito_v2/features/app/controllers/transaction_controller.dart';

class TransactionsCategory extends StatelessWidget {
  const TransactionsCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TransactionController.instance;
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
              _buildList(size, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(Size size, BuildContext context) {
    final controller = TransactionController.instance;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Obx(() {
        final firstLetters = controller.filteredCategories
            .map((entry) => entry.value[0].toUpperCase())
            .toSet()
            .toList()
          ..sort();

        return Column(
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
                  ...controller.filteredCategories
                      .where((entry) => entry.value[0].toUpperCase() == letter)
                      .map((entry) {
                    return GestureDetector(
                      onTap: () {
                        controller.selectedCategory.value = entry.key;
                        Navigator.pop(
                            context, controller.selectedCategory.value);
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
        );
      }),
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
    final controller = TransactionController.instance;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: TextField(
        controller: controller.searchController,
        decoration: InputDecoration(
          hintText: 'Search Categories',
          filled: true,
          fillColor: controller.searchController.text.isEmpty
              ? const Color.fromRGBO(248, 247, 251, 1)
              : Colors.transparent,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: controller.searchController.text.isEmpty
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
            color: controller.searchController.text.isEmpty
                ? const Color(0xFF151624).withOpacity(0.5)
                : const Color.fromRGBO(44, 185, 176, 1),
            size: size.width * 0.06,
          ),
        ),
        onChanged: controller.filterCategories,
      ),
    );
  }
}
