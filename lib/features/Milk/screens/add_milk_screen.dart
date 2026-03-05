import 'package:dairy_farm_app/features/Milk/widgets/add_milk_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/color.dart';
import '../controllers/add_milk_production_controller.dart';

class AddMilkProductionScreen extends StatelessWidget {
  const AddMilkProductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<AddMilkProductionController>()) {
      Get.put(AddMilkProductionController());
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: GetBuilder<AddMilkProductionController>(
          builder: (_) => Column(
            children: [
              // ── Header ──
              const AddMilkProductionHeader(),

              // ── Scrollable form ──
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Quantity
                      const MilkQuantityField(),
                      const SizedBox(height: 24),

                      // Date
                      const MilkDateSelector(),
                      const SizedBox(height: 24),

                      // Notes
                      const MilkNotesField(),
                      const SizedBox(height: 40),

                      // Save button
                      const SaveProductionButton(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
