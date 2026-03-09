import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/color.dart';
import '../controllers/add_payment_controller.dart';
import '../widgets/add_payment_widgets.dart';

class AddPaymentScreen extends StatelessWidget {
  const AddPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<AddPaymentController>()) {
      Get.put(AddPaymentController());
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: GetBuilder<AddPaymentController>(
          builder: (_) => Column(
            children: [
              // ── Header ──
              const AddPaymentHeader(),

              // ── Scrollable form ──
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Customer
                      const PaymentCustomerDropdown(),
                      const SizedBox(height: 24),

                      // 2. Amount
                      const PaymentAmountField(),
                      const SizedBox(height: 24),

                      // 3. Payment method (inline expand)
                      const PaymentMethodDropdown(),
                      const SizedBox(height: 24),

                      // 4. Date
                      const PaymentDateSelector(),
                      const SizedBox(height: 24),

                      // 5. Notes
                      const PaymentNotesField(),
                      const SizedBox(height: 20),

                      // 6. Status
                      const PaymentStatusCard(),
                      const SizedBox(height: 32),

                      // 7. Submit
                      const RecordPaymentButton(),
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
