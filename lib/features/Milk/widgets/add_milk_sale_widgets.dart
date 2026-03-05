import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/color.dart';
import '../../../core/theme/text_styles.dart';
import '../controllers/add_milk_sale_controller.dart';

// ─────────────────────────────────────────────
// 1. HEADER
// ─────────────────────────────────────────────
class AddMilkSaleHeader extends StatelessWidget {
  const AddMilkSaleHeader({super.key});

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
            'Add Milk Sale',
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
class SaleCustomerDropdown extends GetView<AddMilkSaleController> {
  const SaleCustomerDropdown({super.key});

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
      builder: (_) => Container(
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
            ...controller.customers.map(
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
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 3. QUANTITY FIELD
// ─────────────────────────────────────────────
class SaleQuantityField extends GetView<AddMilkSaleController> {
  const SaleQuantityField({super.key});

  @override
  Widget build(BuildContext context) {
    return _LabelledInputField(
      label: 'Milk Quantity (Liters)',
      controller: controller.quantityController,
      icon: Icons.local_drink_outlined,
      hint: 'Enter quantity (Liters)',
      badge: 'Liters',
      errorObs: controller.quantityError,
      onChanged: (_) => controller.quantityError.value = '',
    );
  }
}

// ─────────────────────────────────────────────
// 4. RATE FIELD
// ─────────────────────────────────────────────
class SaleRateField extends GetView<AddMilkSaleController> {
  const SaleRateField({super.key});

  @override
  Widget build(BuildContext context) {
    return _LabelledInputField(
      label: 'Rate per Liter',
      controller: controller.rateController,
      icon: Icons.currency_rupee_rounded,
      hint: 'Enter rate per liter',
      badge: 'Liters',
      errorObs: controller.rateError,
      onChanged: (_) => controller.rateError.value = '',
    );
  }
}

// ── Shared input field widget ──
class _LabelledInputField extends StatelessWidget {
  final String label, hint, badge;
  final TextEditingController controller;
  final IconData icon;
  final RxString errorObs;
  final ValueChanged<String>? onChanged;

  const _LabelledInputField({
    required this.label,
    required this.controller,
    required this.icon,
    required this.hint,
    required this.badge,
    required this.errorObs,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.headline3),
        const SizedBox(height: 12),
        Obx(
          () => Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: errorObs.value.isNotEmpty
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
                  child: Icon(icon, color: AppColors.primary, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: AppTextStyles.bodyText1,
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: AppTextStyles.hint,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    badge,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(
          () => errorObs.value.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 6, left: 4),
                  child: Text(errorObs.value, style: AppTextStyles.error),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// 5. TOTAL AMOUNT DISPLAY
// ─────────────────────────────────────────────
class SaleTotalAmount extends GetView<AddMilkSaleController> {
  const SaleTotalAmount({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Total Amount', style: AppTextStyles.headline3),
        const SizedBox(height: 8),
        Obx(
          () => Text(
            controller.formattedTotal,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
              height: 1.0,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// 6. DATE SELECTOR
// ─────────────────────────────────────────────
class SaleDateSelector extends GetView<AddMilkSaleController> {
  const SaleDateSelector({super.key});

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
// 7. NOTES FIELD
// ─────────────────────────────────────────────
class SaleNotesField extends GetView<AddMilkSaleController> {
  const SaleNotesField({super.key});

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
                  hintText: 'Add sale notes',
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
// 8. STATUS CARD
// ─────────────────────────────────────────────
class SaleStatusCard extends GetView<AddMilkSaleController> {
  const SaleStatusCard({super.key});

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
              Obx(
                () => Text(
                  controller.status.value,
                  style: AppTextStyles.headline3.copyWith(fontSize: 15),
                ),
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
// 9. RECORD SALE BUTTON
// ─────────────────────────────────────────────
class RecordSaleButton extends GetView<AddMilkSaleController> {
  const RecordSaleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: controller.isLoading.value ? null : controller.recordSale,
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
                  'Record Sale',
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
