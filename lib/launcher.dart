import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultPage extends StatelessWidget {
  final String result;

  ResultPage({required this.result});

  bool _isValidURL(String input) {
    final urlPattern = RegExp(
      r'^(http|https):\/\/[^\s$.?#].[^\s]*$',
      caseSensitive: false,
    );
    return urlPattern.hasMatch(input);
  }

  void _launchURL(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLink = _isValidURL(result);

    return Scaffold(
      appBar: AppBar(title: Text('Scan Result')),
      body: Center(
        child: GestureDetector(
          onTap: isLink ? () => _launchURL(context, result) : null,
          child: Text(
            result,
            style: TextStyle(
              fontSize: 18,
              color: isLink ? Colors.blue : Colors.black,
              decoration: isLink ? TextDecoration.underline : TextDecoration.none,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
