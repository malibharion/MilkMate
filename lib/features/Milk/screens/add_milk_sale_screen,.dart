import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/color.dart';
import '../controllers/add_milk_sale_controller.dart';
import '../widgets/add_milk_sale_widgets.dart';

class AddMilkSaleScreen extends StatelessWidget {
  const AddMilkSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<AddMilkSaleController>()) {
      Get.put(AddMilkSaleController());
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: GetBuilder<AddMilkSaleController>(
          builder: (_) => Column(
            children: [
              // ── Header ──
              const AddMilkSaleHeader(),

              // ── Scrollable form ──
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Customer dropdown
                      const SaleCustomerDropdown(),
                      const SizedBox(height: 24),

                      // 2. Quantity
                      const SaleQuantityField(),
                      const SizedBox(height: 24),

                      // 3. Rate per liter
                      const SaleRateField(),
                      const SizedBox(height: 20),

                      // 4. Total amount (live calculated)
                      const SaleTotalAmount(),
                      const SizedBox(height: 24),

                      // 5. Date
                      const SaleDateSelector(),
                      const SizedBox(height: 24),

                      // 6. Notes
                      const SaleNotesField(),
                      const SizedBox(height: 20),

                      // 7. Status card
                      const SaleStatusCard(),
                      const SizedBox(height: 32),

                      // 8. Submit button
                      const RecordSaleButton(),
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
