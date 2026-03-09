import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/color.dart';
import '../../../core/theme/text_styles.dart';
import '../controllers/add_payment_controller.dart';

// ─────────────────────────────────────────────
// 1. HEADER
// ─────────────────────────────────────────────
class AddPaymentHeader extends StatelessWidget {
  const AddPaymentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.gradientStart,
            AppColors.gradientMiddle,
            AppColors.gradientEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.20),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Add Payment',
            style: AppTextStyles.headline1.copyWith(
              color: Colors.white,
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 2. CUSTOMER DROPDOWN
// ─────────────────────────────────────────────
class PaymentCustomerDropdown extends GetView<AddPaymentController> {
  const PaymentCustomerDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Customer (dropdown)', style: AppTextStyles.headline3),
        const SizedBox(height: 12),
        Obx(
          () => GestureDetector(
            onTap: () => _showPicker(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: controller.customerError.value.isNotEmpty
                      ? AppColors.error
                      : AppColors.border,
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      color: AppColors.primary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      controller.selectedCustomer.value.isEmpty
                          ? 'Select customer...'
                          : controller.selectedCustomer.value,
                      style: controller.selectedCustomer.value.isEmpty
                          ? AppTextStyles.hint
                          : AppTextStyles.bodyText1.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textHint,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(
          () => controller.customerError.value.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 6, left: 4),
                  child: Text(
                    controller.customerError.value,
                    style: AppTextStyles.error,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Select Customer', style: AppTextStyles.headline3),
            ),
            const SizedBox(height: 8),
            const Divider(),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                children: controller.customers
                    .map(
                      (name) => ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primary.withOpacity(0.12),
                          child: Text(
                            name[0],
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        title: Text(name, style: AppTextStyles.bodyText1),
                        trailing: Obx(
                          () => controller.selectedCustomer.value == name
                              ? const Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColors.primary,
                                  size: 20,
                                )
                              : const SizedBox.shrink(),
                        ),
                        onTap: () {
                          controller.selectCustomer(name);
                          Get.back();
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 3. AMOUNT FIELD
// ─────────────────────────────────────────────
class PaymentAmountField extends GetView<AddPaymentController> {
  const PaymentAmountField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Amount', style: AppTextStyles.headline3),
        const SizedBox(height: 12),
        Obx(
          () => Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: controller.amountError.value.isNotEmpty
                    ? AppColors.error
                    : AppColors.border,
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 14),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(
                    Icons.currency_rupee_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '\$ ',
                  style: AppTextStyles.headline2.copyWith(fontSize: 22),
                ),
                Expanded(
                  child: TextField(
                    controller: controller.amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: AppTextStyles.headline2.copyWith(fontSize: 22),
                    decoration: const InputDecoration(
                      hintText: '0.00',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 18),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(
          () => controller.amountError.value.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 6, left: 4),
                  child: Text(
                    controller.amountError.value,
                    style: AppTextStyles.error,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// 4. PAYMENT METHOD DROPDOWN (inline expand)
// ─────────────────────────────────────────────
class PaymentMethodDropdown extends GetView<AddPaymentController> {
  const PaymentMethodDropdown({super.key});

  IconData _iconFor(String method) {
    final match = controller.paymentMethods.firstWhereOrNull(
      (m) => m['label'] == method,
    );
    return (match?['icon'] as IconData?) ?? Icons.payment_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Method (dropdown)', style: AppTextStyles.headline3),
        const SizedBox(height: 12),
        Obx(
          () => AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: controller.methodError.value.isNotEmpty
                    ? AppColors.error
                    : AppColors.border,
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // ── Header row ──
                GestureDetector(
                  onTap: controller.toggleMethodDropdown,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Icon(
                            controller.selectedMethod.value.isEmpty
                                ? Icons.payment_outlined
                                : _iconFor(controller.selectedMethod.value),
                            color: AppColors.primary,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            controller.selectedMethod.value.isEmpty
                                ? 'Select method...'
                                : controller.selectedMethod.value,
                            style: controller.selectedMethod.value.isEmpty
                                ? AppTextStyles.hint
                                : AppTextStyles.bodyText1.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                          ),
                        ),
                        Icon(
                          controller.isMethodOpen.value
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: AppColors.textHint,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Expanded options ──
                if (controller.isMethodOpen.value) ...[
                  Divider(height: 1, color: AppColors.divider),
                  ...controller.paymentMethods.map((m) {
                    final label = m['label'] as String;
                    final icon = m['icon'] as IconData;
                    final isSelected = controller.selectedMethod.value == label;
                    return InkWell(
                      onTap: () => controller.selectMethod(label),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 13,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary.withOpacity(0.12)
                                    : AppColors.scaffoldBackground,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Icon(
                                icon,
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                label,
                                style: AppTextStyles.bodyText1.copyWith(
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle_rounded,
                                color: AppColors.primary,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ],
            ),
          ),
        ),
        Obx(
          () => controller.methodError.value.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 6, left: 4),
                  child: Text(
                    controller.methodError.value,
                    style: AppTextStyles.error,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// 5. DATE SELECTOR
// ─────────────────────────────────────────────
class PaymentDateSelector extends GetView<AddPaymentController> {
  const PaymentDateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date selector', style: AppTextStyles.headline3),
        const SizedBox(height: 12),
        Obx(
          () => GestureDetector(
            onTap: () => controller.pickDate(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: const Icon(
                      Icons.calendar_today_outlined,
                      color: AppColors.primary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      controller.formattedDate,
                      style: AppTextStyles.bodyText1.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textHint,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// 6. NOTES FIELD
// ─────────────────────────────────────────────
class PaymentNotesField extends GetView<AddPaymentController> {
  const PaymentNotesField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Notes (Optional)', style: AppTextStyles.headline3),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Icon(
                  Icons.notes_rounded,
                  color: AppColors.primary,
                  size: 18,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.notesController,
                maxLines: 4,
                style: AppTextStyles.bodyText1,
                decoration: InputDecoration(
                  hintText: 'Add payment notes',
                  hintStyle: AppTextStyles.hint,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// 7. STATUS CARD
// ─────────────────────────────────────────────
class PaymentStatusCard extends StatelessWidget {
  const PaymentStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Status:', style: AppTextStyles.caption),
              const SizedBox(height: 4),
              Text(
                'Pending Approval',
                style: AppTextStyles.headline3.copyWith(fontSize: 15),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Pending\nApproval',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.warning,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 8. RECORD PAYMENT BUTTON
// ─────────────────────────────────────────────
class RecordPaymentButton extends GetView<AddPaymentController> {
  const RecordPaymentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: controller.isLoading.value
              ? null
              : controller.recordPayment,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            disabledBackgroundColor: AppColors.primaryLight.withOpacity(0.5),
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 4,
            shadowColor: AppColors.primary.withOpacity(0.4),
          ),
          child: controller.isLoading.value
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  'Record Payment',
                  style: AppTextStyles.button.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
        ),
      ),
    );
  }
}
