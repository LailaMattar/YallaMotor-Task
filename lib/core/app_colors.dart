import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ===== THEME MODE =====
  static bool _isDarkMode = false;
  static bool get isDarkMode => _isDarkMode;
  static void setDarkMode(bool isDark) => _isDarkMode = isDark;

  // ===== ACTUALLY USED COLORS =====
  
  // Primary Colors
  static const Color primary = Color(0xFF2986F6);  // Main blue
  static const Color whatsAppGreen = Color(0xFF25D366);
  
  // Background Colors
  static Color get background => _isDarkMode ? const Color(0xFF121212) : Colors.white;
  static Color get surface => _isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
  
  // Text Colors  
  static Color get textPrimary => _isDarkMode ? Colors.white : Colors.black;
  static Color get textSecondary => _isDarkMode ? Colors.white70 : Colors.black87;
  static Color get textTertiary => _isDarkMode ? Colors.white54 : Colors.black54;
  static Color get textLight => _isDarkMode ? Colors.white38 : Colors.grey;
  static Color get textMedium => _isDarkMode ? Colors.white60 : const Color(0xFF757575);
  
  // Icon Colors
  static Color get iconPrimary => _isDarkMode ? Colors.white70 : Colors.grey;
  static Color get iconSecondary => _isDarkMode ? Colors.white54 : Colors.black54;
  static const Color iconFavorite = Colors.red;
  static Color get iconUnfavorite => _isDarkMode ? Colors.white54 : Colors.grey;
  static const Color iconFavoriteOnCard = Colors.red;
  static const Color iconUnfavoriteOnCard = Colors.white;
  
  // State Colors
  static const Color success = Colors.green;
  static const Color error = Colors.red;
  static const Color warning = Colors.orange;
  
  // Overlay Colors
  static const Color overlay = Colors.black26;
  static const Color overlayDark = Colors.black54;
  
  // Placeholder Colors
  static Color get placeholderBackground => _isDarkMode ? const Color(0xFF2C2C2C) : const Color(0xFFEEEEEE);
  static Color get placeholderIcon => _isDarkMode ? Colors.white38 : Colors.grey;
  
  // Tab Colors
  static const Color tabSelected = primary;
  static Color get tabUnselected => _isDarkMode ? Colors.white54 : Colors.grey;
  static const Color tabIndicator = primary;
  
  // Button Colors
  static const Color buttonPrimary = primary;
  static const Color buttonPrimaryText = Colors.white;
  static const Color buttonWhatsApp = whatsAppGreen;
  
  // Snackbar Colors
  static const Color snackBarSuccess = success;
  static const Color snackBarError = error;
  static const Color snackBarWarning = warning;
  static Color get snackBarNeutral => _isDarkMode ? Colors.grey[700]! : Colors.grey;
  
  // Refresh Indicator
  static const Color refreshIndicator = primary;
  
  // Theme Seed
  static const Color themeSeed = Colors.deepPurple;
} 