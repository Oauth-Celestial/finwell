import 'package:finwell/core/route_manager/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

class AppUpdateService {
  AppUpdateService._();
  final _shorebirdCodePush = ShorebirdCodePush();
  static final AppUpdateService _instance = AppUpdateService._();

  factory AppUpdateService() {
    return _instance;
  }

  Future<void> checkForUpdate() async {
    // Ask the Shorebird servers if there is a new patch available.
    final isUpdateAvailable =
        await _shorebirdCodePush.isNewPatchAvailableForDownload();

    if (isUpdateAvailable) {
      _showUpdateAvailableBanner();
    }
  }

  void _showUpdateAvailableBanner() {
    ScaffoldMessenger.of(NavigationService().navigationContext!)
        .showMaterialBanner(
      MaterialBanner(
        content: const Text('Update available'),
        actions: [
          TextButton(
            onPressed: () async {
              ScaffoldMessenger.of(NavigationService().navigationContext!)
                  .hideCurrentMaterialBanner();
              await _downloadUpdate();

              ScaffoldMessenger.of(NavigationService().navigationContext!)
                  .hideCurrentMaterialBanner();
            },
            child: const Text('Download'),
          ),
        ],
      ),
    );
  }

  void _showDownloadingBanner() {
    ScaffoldMessenger.of(NavigationService().navigationContext!)
        .showMaterialBanner(
      const MaterialBanner(
        content: Text('Downloading...'),
        actions: [
          SizedBox(
            height: 14,
            width: 14,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
        ],
      ),
    );
  }

  void _showRestartBanner() {
    ScaffoldMessenger.of(NavigationService().navigationContext!)
        .showMaterialBanner(
      const MaterialBanner(
        content: Text('App is Updated Please Restart the app'),
        actions: [],
      ),
    );
  }

  void _showErrorBanner() {
    ScaffoldMessenger.of(NavigationService().navigationContext!)
        .showMaterialBanner(
      MaterialBanner(
        content: const Text('An error occurred while downloading the update.'),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(NavigationService().navigationContext!)
                  .hideCurrentMaterialBanner();
            },
            child: const Text('Dismiss'),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadUpdate() async {
    _showDownloadingBanner();

    await _shorebirdCodePush.downloadUpdateIfAvailable();
    // Add an artificial delay so the banner has enough time to animate in.

    final isUpdateReadyToInstall =
        await _shorebirdCodePush.isNewPatchReadyToInstall();

    ScaffoldMessenger.of(NavigationService().navigationContext!)
        .hideCurrentMaterialBanner();
    if (isUpdateReadyToInstall) {
      _showRestartBanner();
    } else {
      _showErrorBanner();
    }
  }
}
