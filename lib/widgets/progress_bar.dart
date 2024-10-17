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

      width: double.infinity, // Ensure the progress bar takes full width
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 100.0), // Padding for sides and vertical margin
      child: Column(
        children: [
          Row(
            children: List.generate(steps.length * 2 - 1, (index) {
              if (index.isEven) {
                return _buildProgressDot(context, index ~/ 2);
              } else {
                return Expanded(child: _buildProgressLine(context, index ~/ 2));
              }
            }),
          ),
          const SizedBox(height: 16), // Space between progress bar and text
        ],
      ),
    );
  }

  Widget _buildProgressDot(BuildContext context, int index) {
    bool isCompleted = index < currentStep;
    bool isCurrent = index == currentStep;
    bool isActive = isCompleted || isCurrent;

    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted
                ? Colors.green // Completed steps are green
                : (isCurrent ? Theme.of(context).primaryColor : Colors.grey[300]), // Active or inactive color
            border: Border.all(
              color: isActive ? Colors.transparent : Colors.grey,
              width: 2,
            ),
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 16) // Checkmark for completed steps
                : Text(
              '${index + 1}',
              style: TextStyle(
                color: isCurrent ? Colors.white : Colors.grey[600],
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
    bool isCompleted = index < currentStep;
    return Container(
      height: 5,
      color: isCompleted ? Colors.green : Colors.grey[300], // Line color based on progress
    );
  }
}
