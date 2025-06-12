import 'package:dishdrop_app_projekt/core/utils/check_and_convert_amount.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/provider/shopping_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingItemRowDynamic extends StatefulWidget {
  const ShoppingItemRowDynamic({
    super.key,
    required this.index,
    required this.dismissFromList,
    required this.ingredient,
  });

  final int index;
  final Function dismissFromList;
  final ListItem ingredient;

  @override
  State<ShoppingItemRowDynamic> createState() => _ShoppingItemRowDynamicState();
}

class _ShoppingItemRowDynamicState extends State<ShoppingItemRowDynamic> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _unitFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();
  bool _isEditingAmount = false;
  bool _isEditingUnit = false;
  bool _isEditingDescription = false;

  @override
  void initState() {
    super.initState();
    _amountController.text = widget.ingredient.amount == null ? "Amount" : widget.ingredient.amount.toString();
    _amountController.addListener(() {
      double? newAmount = double.tryParse(_amountController.text);
      if (newAmount != null) {
        widget.ingredient.amount = newAmount;
      }
    });
    _unitController.text = widget.ingredient.unit ?? "";
    _unitController.addListener(() {
      widget.ingredient.unit = _unitController.text;
    });

    _descriptionController.text = widget.ingredient.description;
    _descriptionController.addListener(() {
      widget.ingredient.description = _descriptionController.text;
    });

    _amountFocusNode.addListener(_handleFocusChange);
    _unitFocusNode.addListener(_handleFocusChange);
    _descriptionFocusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (!_amountFocusNode.hasFocus && !_unitFocusNode.hasFocus && !_descriptionFocusNode.hasFocus) {
      setState(() {
        _isEditingAmount = false;
        _isEditingUnit = false;
        _isEditingDescription = false;
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _unitController.dispose();
    _descriptionController.dispose();
    _amountFocusNode.dispose();
    _unitFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shoppingListProvider = context.watch<ShoppingListNotifier>();

    double? amountValue = double.tryParse(_amountController.text);
    List<String> convertedAmount = checkAndconvertAmount(amountValue);

    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        shoppingListProvider.removeFromAllPurposeShoppingList(widget.ingredient.id);
        widget.dismissFromList(widget.index);
      },
      key: Key(widget.ingredient.id.toString()),
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        padding: EdgeInsets.only(right: 20),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {
            _isEditingAmount = false;
            _isEditingUnit = false;
            _isEditingDescription = false;
          });
        },
        child: Row(
          spacing: 35,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
                value: widget.ingredient.isDone,
                onChanged: (bool? value) {
                  widget.ingredient.isDone = value ?? false;
                  context.read<ShoppingListNotifier>().updateAllPurposeShoppingList(widget.ingredient);
                }),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isEditingAmount = true;
                  _isEditingUnit = false;
                  _isEditingDescription = false;
                });
                _amountFocusNode.requestFocus();
              },
              child: _isEditingAmount
                  ? AmountTextField(amountController: _amountController, amountFocusNode: _amountFocusNode)
                  : AmountText(
                      convertedAmount: convertedAmount,
                      isDone: widget.ingredient.isDone,
                    ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isEditingAmount = false;
                  _isEditingUnit = true;
                  _isEditingDescription = false;
                });
                _unitFocusNode.requestFocus();
              },
              child: _isEditingUnit
                  ? UnitTextField(unitController: _unitController, unitFocusNode: _unitFocusNode)
                  : UnitText(unitController: _unitController, isDone: widget.ingredient.isDone),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isEditingAmount = false;
                    _isEditingUnit = false;
                    _isEditingDescription = true;
                  });
                  _descriptionFocusNode.requestFocus();
                },
                child: _isEditingDescription
                    ? DescriptionTextField(
                        descriptionController: _descriptionController,
                        descriptionFocusNode: _descriptionFocusNode,
                      )
                    : DescriptionText(
                        descriptionController: _descriptionController,
                        isDone: widget.ingredient.isDone,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AmountTextField extends StatelessWidget {
  const AmountTextField({
    super.key,
    required TextEditingController amountController,
    required FocusNode amountFocusNode,
  })  : _amountController = amountController,
        _amountFocusNode = amountFocusNode;

  final TextEditingController _amountController;
  final FocusNode _amountFocusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: TextField(
        maxLength: 6,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        controller: _amountController,
        focusNode: _amountFocusNode,
        decoration: const InputDecoration(
          hintText: "Amount",
          border: OutlineInputBorder(),
          counterText: "",
          contentPadding: EdgeInsets.only(left: 5, right: 5),
          isDense: true,
        ),
      ),
    );
  }
}

class AmountText extends StatelessWidget {
  const AmountText({super.key, required this.convertedAmount, required this.isDone});

  final List<String> convertedAmount;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return convertedAmount[0] == '' && convertedAmount[1] == ''
        ? Text('      ')
        : RichText(
            text: TextSpan(
              text: convertedAmount[0],
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    decoration: isDone ? TextDecoration.lineThrough : null,
                  ),
              children: [
                TextSpan(
                  text: convertedAmount[1],
                  style: TextStyle(
                    fontFeatures: [FontFeature.fractions()],
                    decoration: isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
            ),
          );
  }
}

class UnitTextField extends StatelessWidget {
  const UnitTextField({
    super.key,
    required TextEditingController unitController,
    required FocusNode unitFocusNode,
  })  : _unitController = unitController,
        _unitFocusNode = unitFocusNode;

  final TextEditingController _unitController;
  final FocusNode _unitFocusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextField(
        maxLength: 10,
        controller: _unitController,
        focusNode: _unitFocusNode,
        decoration: const InputDecoration(
          hintText: "Unit",
          border: OutlineInputBorder(),
          counterText: "",
          contentPadding: EdgeInsets.only(left: 5, right: 5),
          isDense: true,
        ),
      ),
    );
  }
}

class UnitText extends StatelessWidget {
  const UnitText({
    super.key,
    required TextEditingController unitController,
    required this.isDone,
  }) : _unitController = unitController;

  final TextEditingController _unitController;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Text(
      _unitController.text.isEmpty ? "      " : _unitController.text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            decoration: isDone ? TextDecoration.lineThrough : null,
          ),
    );
  }
}

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField({
    super.key,
    required TextEditingController descriptionController,
    required FocusNode descriptionFocusNode,
  })  : _descriptionController = descriptionController,
        _descriptionFocusNode = descriptionFocusNode;

  final TextEditingController _descriptionController;
  final FocusNode _descriptionFocusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 20,
      controller: _descriptionController,
      textAlign: TextAlign.right,
      focusNode: _descriptionFocusNode,
      decoration: const InputDecoration(
        hintText: "Description",
        border: OutlineInputBorder(),
        counterText: "",
        contentPadding: EdgeInsets.only(left: 5, right: 5),
        isDense: true,
      ),
    );
  }
}

class DescriptionText extends StatelessWidget {
  const DescriptionText({
    super.key,
    required this.isDone,
    required TextEditingController descriptionController,
  }) : _descriptionController = descriptionController;

  final TextEditingController _descriptionController;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Text(
      _descriptionController.text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            decoration: isDone ? TextDecoration.lineThrough : null,
          ),
      textAlign: TextAlign.right,
    );
  }
}
