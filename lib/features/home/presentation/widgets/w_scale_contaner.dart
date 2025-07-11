import 'package:flutter/material.dart';

class WScaleAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongTap;
  final Duration duration;
  final double scaleValue;
  final bool isDisabled;
  const WScaleAnimation({
    required this.child,
    this.onTap,
    this.isDisabled = false,
    this.duration = const Duration(milliseconds: 300),
    this.scaleValue = 0.95,
    this.onLongTap,
    super.key,
  }) : assert(
         scaleValue <= 1 && scaleValue >= 0,
         'scale value should be in the range [0,1]',
       );

  @override
  State<WScaleAnimation> createState() => _WScaleAnimationState();
}

class _WScaleAnimationState extends State<WScaleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleValue,
    ).animate(CurvedAnimation(curve: Curves.easeInOut, parent: _controller));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Animation'ni boshlash
  void _startAnimation() {
    if (!widget.isDisabled) {
      _controller.forward();
    }
  }

  /// Animation'ni tugallash va callback'ni chaqirish
  void _completeAnimation() {
    if (!widget.isDisabled) {
      _controller.reverse().then((_) {
        // Animation tugagandan keyin callback'ni chaqirish
        if (widget.onTap != null) {
          widget.onTap!();
        }
      });
    }
  }

  /// Animation'ni bekor qilish
  void _cancelAnimation() {
    if (!widget.isDisabled) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,

      // Tap boshlanishi
      onTapDown: (_) => _startAnimation(),

      // Tap tugashi
      onTapUp: (_) => _completeAnimation(),

      // Tap bekor qilinishi
      onTapCancel: () => _cancelAnimation(),

      // Long press
      onLongPress: () {
        if (!widget.isDisabled && widget.onLongTap != null) {
          widget.onLongTap!();
        }
      },

      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}

// Alternative versiya - daha sodda va samarali
class WScaleAnimationSimple extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongTap;
  final Duration duration;
  final double scaleValue;
  final bool isDisabled;

  const WScaleAnimationSimple({
    required this.child,
    this.onTap,
    this.isDisabled = false,
    this.duration = const Duration(milliseconds: 100),
    this.scaleValue = 0.95,
    this.onLongTap,
    super.key,
  });

  @override
  State<WScaleAnimationSimple> createState() => _WScaleAnimationSimpleState();
}

class _WScaleAnimationSimpleState extends State<WScaleAnimationSimple> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        if (!widget.isDisabled) {
          setState(() => _isPressed = true);
        }
      },
      onTapUp: (_) {
        if (!widget.isDisabled) {
          setState(() => _isPressed = false);
          Future.delayed(const Duration(milliseconds: 120), () {
            widget.onTap?.call();
          });
        }
      },
      onTapCancel: () {
        if (!widget.isDisabled) {
          setState(() => _isPressed = false);
        }
      },
      onLongPress: () {
        if (!widget.isDisabled) {
          widget.onLongTap?.call();
        }
      },
      child: AnimatedScale(
        scale: _isPressed ? widget.scaleValue : 1.0,
        duration: widget.duration,
        curve: Curves.easeInOut,
        child: widget.child,
      ),
    );
  }
}
