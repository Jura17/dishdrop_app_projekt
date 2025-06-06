import 'package:dishdrop_app_projekt/core/utils/check_and_convert_amount.dart';
import 'package:dishdrop_app_projekt/data/models/list_item.dart';
import 'package:dishdrop_app_projekt/data/provider/recipe_form_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IngredientRowDynamic extends StatefulWidget {
  const IngredientRowDynamic({
    super.key,
    required this.ingredient,
  });

  final ListItem ingredient;

  @override
  State<IngredientRowDynamic> createState() => _IngredientRowDynamicState();
}

class _IngredientRowDynamicState extends State<IngredientRowDynamic> {
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
    _amountController.text = widget.ingredient.amount == null ? "" : widget.ingredient.amount.toString();
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
    final recipeFormNotifier = context.read<RecipeFormNotifier>();

    double? amountValue = double.tryParse(_amountController.text);
    List<String> convertedAmount = checkAndconvertAmount(amountValue);

    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        recipeFormNotifier.removeFromIngredientList(widget.ingredient.id);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  : AmountText(convertedAmount: convertedAmount),
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
                  : UnitText(unitController: _unitController),
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
                    : DescriptionText(descriptionController: _descriptionController),
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
  const AmountText({
    super.key,
    required this.convertedAmount,
  });

  final List<String> convertedAmount;

  @override
  Widget build(BuildContext context) {
    return convertedAmount[0] == '' && convertedAmount[1] == ''
        ? Text('      ')
        : RichText(
            text: TextSpan(
              text: convertedAmount[0],
              style: Theme.of(context).textTheme.bodyLarge,
              children: [
                TextSpan(
                  text: convertedAmount[1],
                  style: TextStyle(
                    fontFeatures: [FontFeature.fractions()],
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
  }) : _unitController = unitController;

  final TextEditingController _unitController;

  @override
  Widget build(BuildContext context) {
    return Text(
      _unitController.text.isEmpty ? "      " : _unitController.text,
      style: Theme.of(context).textTheme.bodyLarge,
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
    required TextEditingController descriptionController,
  }) : _descriptionController = descriptionController;

  final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    return Text(
      _descriptionController.text,
      style: Theme.of(context).textTheme.bodyLarge,
      textAlign: TextAlign.right,
    );
  }
}
