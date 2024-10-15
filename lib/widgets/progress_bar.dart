import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final List<String> steps;
  final int currentStep;

  const ProgressBar({
    super.key,
    required this.steps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Row(
        children: List.generate(steps.length * 2 - 1, (index) {
          if (index.isEven) {
            return _buildProgressDot(context, index ~/ 2);
          } else {
            return Expanded(child: _buildProgressLine(context, index ~/ 2));
          }
        }),
      ),
    );
  }

  Widget _buildProgressDot(BuildContext context, int index) {
    bool isActive = index <= currentStep;
    return Column(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Theme.of(context).primaryColor : Colors.grey[300],
            border: Border.all(
              color: isActive ? Theme.of(context).primaryColor : Colors.grey,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              (index + 1).toString(),
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          steps[index],
          style: TextStyle(
            color: isActive ? Theme.of(context).primaryColor : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressLine(BuildContext context, int index) {
    bool isActive = index < currentStep;
    return Container(
      height: 5,
      color: isActive ? Theme.of(context).primaryColor : Colors.grey[300],
    );
  }
}
