import 'package:dairy_farm_app/features/Transaction/controllers/add_expanse_controller.dart';
import 'package:dairy_farm_app/features/Transaction/widgets/add_expanse_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/color.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<AddExpenseController>()) {
      Get.put(AddExpenseController());
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: GetBuilder<AddExpenseController>(
          builder: (_) => Column(
            children: [
              // ── Header ──
              const AddExpenseHeader(),

              // ── Scrollable form ──
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Category
                      const ExpenseCategorySelector(),
                      const SizedBox(height: 24),

                      // 2. Amount
                      const ExpenseAmountField(),
                      const SizedBox(height: 24),

                      // 3. Date
                      const ExpenseDateSelector(),
                      const SizedBox(height: 24),

                      // 4. Notes
                      const ExpenseNotesField(),
                      const SizedBox(height: 20),

                      // 5. Status
                      const ExpenseStatusCard(),
                      const SizedBox(height: 32),

                      // 6. Save
                      const SaveExpenseButton(),
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
