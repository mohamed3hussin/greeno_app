import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.background,
    required this.child
  });
  final Widget background;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          IgnorePointer(
            child: background,
          ),
          SafeArea(
              child: LayoutBuilder(
                  builder:(context,constraints){
                    return SingleChildScrollView(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Padding(
                            padding:EdgeInsets.symmetric(horizontal: 24.w),
                            child: child,
                        ),
                      ),
                    );
                  }
              ),
          ),
        ],
      ),
    );
  }
}
