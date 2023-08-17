import 'package:flutter/material.dart';
import 'package:food_order/jobs_show/jobs/custom_widgets/form_utils.dart';

import 'custom_widgets.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({
    Key? key,
    required this.items,
    required this.roleController,
    this.onItemSelected,
  }) : super(key: key);
  final List<String> items;
  final TextEditingController roleController;
  final ValueChanged<String>? onItemSelected;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  String _selectedItem = '';
  bool _isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _scaleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    widget.roleController.addListener(() {
      setState(() {
        _selectedItem = widget.roleController.text;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    widget.roleController.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    if (_isDropdownOpen) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: (){
            _toggleDropdown();
          },
          child: AbsorbPointer(
            child: TextFormField(
              enabled: true,
              controller: widget.roleController,
              validator: FormUtils.checkValue,
              onTap: () {
                _toggleDropdown();
              },
              decoration: buildInputDecoration(
                  name: "Categories", iconData: Icons.arrow_drop_down,),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: _isDropdownOpen ? 100 : 0,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: _isDropdownOpen ? MediaQuery.of(context).size.width : 0,
            curve: Curves.easeOut,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: ListView.builder(
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        _toggleDropdown();
                        setState(() {
                          _selectedItem = widget.items[index];
                        });
                        if (widget.onItemSelected != null) {
                          widget.onItemSelected!(_selectedItem);
                        }
                        widget.roleController.text = _selectedItem;
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(widget.items[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
