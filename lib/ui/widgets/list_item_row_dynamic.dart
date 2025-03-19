import 'package:dishdrop_app_projekt/core/utils/check_and_convert_amount.dart';
import 'package:flutter/material.dart';

class ListItemRowDynamic extends StatefulWidget {
  const ListItemRowDynamic({
    super.key,
    required this.amount,
    required this.unit,
    required this.description,
    required this.index,
    required this.complexInputValues,
    required this.removeFromListFunc,
  });

  final double? amount;
  final String? unit;
  final String description;
  final int index;
  final Map<String, dynamic> complexInputValues;
  final Function removeFromListFunc;

  @override
  State<ListItemRowDynamic> createState() => _ListItemRowDynamicState();
}

class _ListItemRowDynamicState extends State<ListItemRowDynamic> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isEditingAmount = false;
  bool _isEditingUnit = false;
  bool _isEditingDescription = false;
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _unitFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _amountController.text = "${widget.amount}";
    _amountController.addListener(() {
      double? newAmount = double.tryParse(_amountController.text);
      if (newAmount != null) {
        widget.complexInputValues["ingredients"][widget.index].amount = newAmount;
      }
    });
    _unitController.text = "${widget.unit}";
    _unitController.addListener(() {
      widget.complexInputValues["ingredients"][widget.index].unit = _unitController.text;
    });
    _descriptionController.text = widget.description;
    _descriptionController.addListener(() {
      widget.complexInputValues["ingredients"][widget.index].description = _descriptionController.text;
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
    double? amountValue = double.tryParse(_amountController.text);
    List<String> convertedAmount = checkAndconvertAmount(amountValue);

    return Dismissible(
      onDismissed: (direction) {
        widget.removeFromListFunc(widget.index);
      },
      key: Key(widget.description),
      background: Container(
        color: Colors.red,
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
          spacing: 10,
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
                  ? SizedBox(
                      width: 60,
                      child: TextField(
                        maxLength: 6,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        controller: _amountController,
                        focusNode: _amountFocusNode,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 5, right: 5),
                        ),
                      ),
                    )
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
                  ? SizedBox(
                      width: 50,
                      child: TextField(
                        maxLength: 10,
                        controller: _unitController,
                        focusNode: _unitFocusNode,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 5, right: 5),
                        ),
                      ),
                    )
                  : Text(
                      _unitController.text,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
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
                    ? TextField(
                        maxLength: 40,
                        controller: _descriptionController,
                        textAlign: TextAlign.right,
                        focusNode: _descriptionFocusNode,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 5, right: 5),
                        ),
                      )
                    : Text(
                        _descriptionController.text,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.right,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
