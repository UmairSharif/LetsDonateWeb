import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckboxItem extends StatefulWidget {
  CheckboxItem(
      {super.key,
      required this.text,
      this.isSelected = false,
      this.showCheckBox = true,
      this.onChanged});

  final String text;
  bool isSelected;
  bool showCheckBox;
  Function(bool)? onChanged;

  @override
  State<CheckboxItem> createState() => _CheckboxItemState();
}

class _CheckboxItemState extends State<CheckboxItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            if (widget.showCheckBox)
              Checkbox(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  value: widget.isSelected,
                  onChanged: (newValue) {
                    setState(() {
                      widget.isSelected = newValue!;
                    });
                    widget.onChanged!(newValue!);
                  }),
            Expanded(
              child: Text(
                widget.text,
                maxLines: 3,
                style: const TextStyle(fontSize: 12),
              ),
            )
          ]),
        ],
      ),
    );
  }
}
