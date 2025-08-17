import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import '../models/button_config.dart';
import '../services/api_service.dart';

class ButtonScreen extends StatefulWidget {
  final ButtonConfig config;

  const ButtonScreen({
    super.key,
    required this.config,
  });

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  bool _isLoading = false;
  String? _responseData;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.config.url != null) {
      _fetchData();
    }
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final data = await ApiService.fetchData(widget.config.url!);
      setState(() {
        _responseData = const JsonEncoder.withIndent('  ').convert(data);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load data: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const double screenSize = 320.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: screenSize,
          height: screenSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[900],
          ),
          child: ClipOval(
            child: Stack(
              children: [
                // Back button at top
                Positioned(
                  top: 35,
                  left: 35,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                      iconSize: 24,
                    ),
                  ),
                ),
                // Main content - properly centered with constraints
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 45.0,
                      vertical: 60.0,
                    ),
                    child: _buildContent(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: widget.config.color,
            strokeWidth: 3,
          ),
          const SizedBox(height: 16),
          Text(
            'Loading...',
            style: TextStyle(
              fontSize: 14,
              color: widget.config.color,
            ),
          ),
        ],
      );
    }

    if (_errorMessage != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 36,
          ),
          const SizedBox(height: 12),
          Text(
            'Error',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _errorMessage!.length > 50
                ? '${_errorMessage!.substring(0, 50)}...'
                : _errorMessage!,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      );
    }

    if (_responseData != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon or label
          if (widget.config.icon != null)
            SvgPicture.asset(
              widget.config.icon!,
              width: 32,
              height: 32,
              colorFilter: ColorFilter.mode(
                widget.config.color,
                BlendMode.srcIn,
              ),
            )
          else
            Text(
              widget.config.label,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: widget.config.color,
              ),
            ),
          const SizedBox(height: 8),
          Text(
            widget.config.screenTitle,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: widget.config.color,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          // Data container with constrained height
          Container(
            constraints: const BoxConstraints(
              maxHeight: 120,
            ),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: SingleChildScrollView(
              child: Text(
                _responseData!.length > 500
                    ? '${_responseData!.substring(0, 500)}...'
                    : _responseData!,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white70,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Default content when no URL
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Display icon if available, otherwise label in a box
        if (widget.config.icon != null)
          SvgPicture.asset(
            widget.config.icon!,
            width: 56,
            height: 56,
            colorFilter: ColorFilter.mode(
              widget.config.color,
              BlendMode.srcIn,
            ),
          )
        else
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: widget.config.color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                widget.config.label,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        const SizedBox(height: 16),
        Text(
          widget.config.screenTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: widget.config.color,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}