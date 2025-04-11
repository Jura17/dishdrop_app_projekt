import 'package:dishdrop_app_projekt/data/models/cooking_direction.dart';
import 'package:flutter/material.dart';

class CookingDirectionRowDynamic extends StatefulWidget {
  const CookingDirectionRowDynamic({
    super.key,
    required this.cookingDirection,
    required this.removeFromCookingDirectionsListFunc,
    required this.rowIndex,
  });

  final CookingDirection cookingDirection;
  final Function removeFromCookingDirectionsListFunc;
  final int rowIndex;

  @override
  State<CookingDirectionRowDynamic> createState() => _CookingDirectionRowDynamicState();
}

class _CookingDirectionRowDynamicState extends State<CookingDirectionRowDynamic> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.cookingDirection.description;
    _controller.addListener(() {
      widget.cookingDirection.description = _controller.text;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        setState(() {
          widget.removeFromCookingDirectionsListFunc(widget.cookingDirection.id);
        });
      },
      key: Key(widget.cookingDirection.id.toString()),
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.rowIndex}. ",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: TextField(
                maxLength: 200,
                maxLines: null,
                controller: _controller,
                enabled: true,
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: InputDecoration(
                  filled: false,
                  border: InputBorder.none,
                  counterText: "",
                  contentPadding: EdgeInsets.only(left: 5, right: 5),
                  isDense: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
