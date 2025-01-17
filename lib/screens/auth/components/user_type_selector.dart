import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserTypeSelector extends StatefulWidget {
  final Function(String) onProfileSelected;

  const UserTypeSelector({
    super.key,
    required this.onProfileSelected,
  });

  @override
  State<UserTypeSelector> createState() => _UserTypeSelectorState();
}

class _UserTypeSelectorState extends State<UserTypeSelector> {
  String selectedProfile = 'company';

  void _selectProfile(String profile) {
    setState(() {
      selectedProfile = profile;
    });
    widget.onProfileSelected(profile);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Normal User Option
        Expanded(
          child: GestureDetector(
            onTap: () => _selectProfile('normal'),
            child: AnimatedContainer(
              duration: Durations.short4,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selectedProfile == 'normal'
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade300,
                  width: selectedProfile == 'normal' ? 2 : 1,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/User - Normal.svg",
                          height: 40,
                          width: 40,
                          colorFilter: ColorFilter.mode(
                              selectedProfile == 'normal'
                                  ? const Color(0xFF6366F1)
                                  : Colors.grey.shade400,
                              BlendMode.srcIn),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Usuário Normal',
                          style: TextStyle(
                            color: selectedProfile == 'normal'
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (selectedProfile == 'normal')
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Real Estate Company Option
        Expanded(
          child: GestureDetector(
            onTap: () => _selectProfile('company'),
            child: AnimatedContainer(
              duration: Durations.short4,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selectedProfile == 'company'
                      ? const Color(0xFF6366F1)
                      : Colors.grey.shade300,
                  width: selectedProfile == 'company' ? 2 : 1,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/User - Property.svg",
                          height: 40,
                          width: 40,
                          colorFilter: ColorFilter.mode(
                              selectedProfile == 'company'
                                  ? const Color(0xFF6366F1)
                                  : Colors.grey.shade400,
                              BlendMode.srcIn),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Empresa Imobiliária',
                          style: TextStyle(
                            color: selectedProfile == 'company'
                                ? const Color(0xFF6366F1)
                                : Colors.grey.shade400,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (selectedProfile == 'company')
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Color(0xFF6366F1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
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
