import '../entities/enums.dart';

/// this will be used to show permission dialog
/// in real app it may contains all functionality for routing and navigation
abstract class INavigator {
  Future<bool> openPermissionDialog(PermissionType type);
}
