import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../manager/student_home_controller.dart';

class MaintenanceBottomSheet extends StatelessWidget {
  final StudentHomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle Bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
                const Text(
                  "Report an Issue",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Chips Section
            const Text(
              "What type of issue is it?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Obx(
              () => Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildChip("ELECTRICITY", "Electricity", Icons.flash_on),
                  _buildChip("PLUMBING", "Plumbing", Icons.water_drop),
                  _buildChip("FURNITURE", "Furniture", Icons.chair),
                  _buildChip("INTERNET", "Internet", Icons.wifi),
                  _buildChip("OTHER", "Other", Icons.help_outline),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Description
            const Text(
              "Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FD),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextField(
                controller: controller.maintenanceDescController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText:
                      "Please describe the issue in detail (e.g. location, severity)...",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: controller.submitMaintenance,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E88E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Submit Request >",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String value, String label, IconData icon) {
    bool isSelected = controller.selectedMaintenanceType.value == value;
    return ChoiceChip(
      label: Text(label),
      avatar: Icon(
        icon,
        size: 18,
        color: isSelected ? Colors.white : Colors.grey,
      ),
      selected: isSelected,
      onSelected: (bool selected) {
        if (selected) controller.selectedMaintenanceType.value = value;
      },
      selectedColor: Colors.blue.shade100,
      backgroundColor: Colors.grey.shade50,
      labelStyle: TextStyle(
        color: isSelected ? Colors.blue.shade900 : Colors.black54,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: isSelected ? Colors.blue : Colors.transparent),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      showCheckmark: false, // لإخفاء علامة الصح الافتراضية
    );
  }
}
