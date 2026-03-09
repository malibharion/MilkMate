import 'package:dairy_farm_app/features/Transaction/controllers/add_expanse_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/color.dart';
import '../../../core/theme/text_styles.dart';

// ─────────────────────────────────────────────
// 1. HEADER
// ─────────────────────────────────────────────
class AddExpenseHeader extends StatelessWidget {
  const AddExpenseHeader({super.key});

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
            'Add Expense',
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
// 2. CATEGORY SELECTOR
// ─────────────────────────────────────────────
class ExpenseCategorySelector extends GetView<AddExpenseController> {
  const ExpenseCategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Expense Category (dropdown)', style: AppTextStyles.headline3),
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
          child: Column(
            children: [
              // ── Dropdown row ──
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
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
                          _iconFor(controller.selectedCategory.value),
                          color: AppColors.primary,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          controller.selectedCategory.value,
                          style: AppTextStyles.bodyText1.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showPicker(context),
                        child: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.textHint,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Divider(height: 1, color: AppColors.divider),

              // ── Quick-pick chips ──
              Obx(
                () => Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: controller.categories
                        .where(
                          (c) =>
                              c['label'] != controller.selectedCategory.value,
                        )
                        .take(3)
                        .map(
                          (c) => _CategoryChip(
                            icon: c['icon'] as IconData,
                            label: c['label'] as String,
                            onTap: () =>
                                controller.selectCategory(c['label'] as String),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _iconFor(String cat) {
    final match = controller.categories.firstWhereOrNull(
      (c) => c['label'] == cat,
    );
    return (match?['icon'] as IconData?) ?? Icons.category_outlined;
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
              child: Text('Select Category', style: AppTextStyles.headline3),
            ),
            const SizedBox(height: 8),
            const Divider(),
            ...controller.categories.map(
              (c) => ListTile(
                leading: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    c['icon'] as IconData,
                    color: AppColors.primary,
                    size: 18,
                  ),
                ),
                title: Text(
                  c['label'] as String,
                  style: AppTextStyles.bodyText1,
                ),
                trailing: Obx(
                  () => controller.selectedCategory.value == c['label']
                      ? const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.primary,
                          size: 20,
                        )
                      : const SizedBox.shrink(),
                ),
                onTap: () {
                  controller.selectCategory(c['label'] as String);
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

class _CategoryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _CategoryChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.primary, size: 22),
          ),
          const SizedBox(height: 6),
          Text(label, style: AppTextStyles.caption.copyWith(fontSize: 11)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// 3. AMOUNT FIELD
// ─────────────────────────────────────────────
class ExpenseAmountField extends GetView<AddExpenseController> {
  const ExpenseAmountField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Expense Amount', style: AppTextStyles.headline3),
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
                    Icons.attach_money_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 4),
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
// 4. DATE SELECTOR
// ─────────────────────────────────────────────
class ExpenseDateSelector extends GetView<AddExpenseController> {
  const ExpenseDateSelector({super.key});

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
// 5. NOTES FIELD
// ─────────────────────────────────────────────
class ExpenseNotesField extends GetView<AddExpenseController> {
  const ExpenseNotesField({super.key});

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
                  hintText: 'Add expense details',
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
// 6. STATUS CARD
// ─────────────────────────────────────────────
class ExpenseStatusCard extends StatelessWidget {
  const ExpenseStatusCard({super.key});

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
// 7. SAVE BUTTON
// ─────────────────────────────────────────────
class SaveExpenseButton extends GetView<AddExpenseController> {
  const SaveExpenseButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: controller.isLoading.value ? null : controller.saveExpense,
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
                  'Save Expense',
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
