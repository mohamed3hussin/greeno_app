import 'package:url_launcher/url_launcher.dart';

class EmailLauncher {
  static Future<void> openEmailApp() async {
    final gmail = Uri.parse('googlegmail://');

    if (await canLaunchUrl(gmail)) {
      await launchUrl(gmail);
      return;
    }

    final outlook = Uri.parse('ms-outlook://');

    if (await canLaunchUrl(outlook)) {
      await launchUrl(outlook);
      return;
    }

    final mail = Uri.parse('mailto:');

    if (await canLaunchUrl(mail)) {
      await launchUrl(mail);
      return;
    }

    await launchUrl(
      Uri.parse('https://mail.google.com'),
      mode: LaunchMode.externalApplication,
    );
  }
}