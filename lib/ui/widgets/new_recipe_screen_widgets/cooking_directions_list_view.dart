import 'package:flutter/material.dart';

class CookingDirectionsListView extends StatefulWidget {
  const CookingDirectionsListView({
    super.key,
    required this.complexInputValues,
  });

  final Map<String, dynamic> complexInputValues;

  @override
  State<CookingDirectionsListView> createState() => _CookingDirectionsListViewState();
}

class _CookingDirectionsListViewState extends State<CookingDirectionsListView> {
  late TextEditingController textController;

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        widget.complexInputValues["directions"].length,
        (index) {
          textController = TextEditingController();
          if (widget.complexInputValues["directions"].isNotEmpty) {
            textController.text = widget.complexInputValues["directions"][index];
          }
          return Dismissible(
            key: Key(widget.complexInputValues["directions"][index]),
            background: Container(
              color: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) async {
              setState(() {
                widget.complexInputValues["directions"].removeAt(index);
              });
            },
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${index + 1}. ",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: TextField(
                        maxLength: 200,
                        maxLines: null,
                        controller: textController,
                        onChanged: (value) => widget.complexInputValues["directions"][index] = value,
                        enabled: true,
                        style: Theme.of(context).textTheme.bodyLarge,
                        decoration: InputDecoration(filled: false, border: InputBorder.none, counterText: ""),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
