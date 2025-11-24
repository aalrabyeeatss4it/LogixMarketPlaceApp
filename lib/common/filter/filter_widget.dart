// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controllers/product_filter_controller.dart';
//
// class FilterWidget1 extends StatelessWidget {
//   final controller = Get.find<ProductFilterController>();
//   FilterWidget1({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text("Filters", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
//                 TextButton(onPressed: controller.reset, child: const Text("Reset"))
//               ],
//             ),
//             const SizedBox(height: 20),
//             const Text("Name"),
//             const SizedBox(height: 6),
//             TextField(
//               controller: controller.nameController,
//               decoration: const InputDecoration(
//                 hintText: "Search product",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text("Price Range"),
//             Obx(() => RangeSlider(
//               values: RangeValues(controller.minPrice.value, controller.maxPrice.value),
//               min: 0,
//               max: 2000,
//               divisions: 40,
//               onChanged: (v) {
//                 controller.minPrice.value = v.start;
//                 controller.maxPrice.value = v.end;
//               },
//             )),
//             const SizedBox(height: 20),
//             const Text("Sort By"),
//             Obx(() => Wrap(
//               spacing: 8,
//               children: [
//                 _sortChip("newest"),
//                 _sortChip("price_low"),
//                 _sortChip("price_high"),
//                 _sortChip("popular"),
//               ],
//             )),
//             const SizedBox(height: 20),
//           Column(
//             children: [
//               const Text("Colors"),
//               Obx(() => Wrap(
//                 children: controller.selectedColors.map((c) {
//                   return FilterChip(
//                     label: Text(c),
//                     selected: controller.selectedColors.contains(c),
//                     onSelected: (_) => controller.toggleColor(c),
//                   );
//                 }).toList(),
//               )),
//             ],
//           ),
//           const SizedBox(height: 20),
//             const Text("Sizes"),
//             Obx(() => Wrap(
//               spacing: 8,
//               children: ["S", "M", "L", "XL", "XXL"].map((size) {
//                 return FilterChip(
//                   label: Text(size),
//                   selected: controller.selectedSizes.contains(size),
//                   onSelected: (_) => controller.toggleSize(size),
//                 );
//               }).toList(),
//             )),
//             const SizedBox(height: 30),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Get.back(); // close sheet
//                 },
//                 child: const Text("Apply Filters"),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _sortChip(String value) {
//     return ChoiceChip(
//       label: Text(value.replaceAll("_", " ").toUpperCase()),
//       selected: controller.sort.value == value,
//       onSelected: (_) => controller.sort.value = value,
//     );
//   }
//
//   Widget _colorBox(String color) {
//     final c = controller;
//     return GestureDetector(
//       onTap: () => c.toggleColor(color),
//       child: Obx(() {
//         bool selected = c.selectedColors.contains(color);
//         return Container(
//           width: 32,
//           height: 32,
//           margin: EdgeInsets.all(4),
//           decoration: BoxDecoration(
//             color: _color(color),
//             shape: BoxShape.circle,
//             border: Border.all(
//               width: 2,
//               color: selected ? Colors.black : Colors.grey.shade300,
//             ),
//           ),
//         );
//       }),
//     );
//   }
//
//   Color _color(String name) {
//     switch (name) {
//       case "red": return Colors.red;
//       case "blue": return Colors.blue;
//       case "green": return Colors.green;
//       case "black": return Colors.black;
//       case "white": return Colors.white;
//       default: return Colors.grey;
//     }
//   }
// }
