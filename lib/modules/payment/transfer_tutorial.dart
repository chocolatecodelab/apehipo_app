import 'package:flutter/material.dart';

class TutorialStep {
  final int stepNumber;
  final String stepTitle;
  final String stepDescription;

  TutorialStep({
    required this.stepNumber,
    required this.stepTitle,
    required this.stepDescription,
  });
}

final List<TutorialStep> tutorialSteps = [
  TutorialStep(
    stepNumber: 1,
    stepTitle: 'Buka Aplikasi',
    stepDescription: 'Buka aplikasi pembayaran Anda.',
  ),
  TutorialStep(
    stepNumber: 2,
    stepTitle: 'Pilih Penerima',
    stepDescription:
        'Pilih penerima transfer dari kontak atau masukkan nomor rekening.',
  ),
  TutorialStep(
    stepNumber: 3,
    stepTitle: 'Isi Jumlah Transfer',
    stepDescription: 'Isi jumlah yang ingin Anda transfer.',
  ),
  // Tambahkan langkah-langkah lain sesuai kebutuhan Anda
];

List<String> steps = [
  "Datang ke ATM BNI terdekat.",
  "Masukkan kartu ATM BNI ke mesin.",
  "Pilih bahasa Indonesia.",
  "Masukkan PIN ATM.",
  "Pilih Menu Lain.",
  "Klik Transfer.",
  "Klik ke rekening BNI.",
  "Masukkan nomor rekening BNI.",
  "Masukkan nominal transfer BNI.",
  "Klik Ya di halaman konfirmasi.",
  "Tunggu proses transfer berlangsung.",
  "Ambil kartu ATM dan jangan tinggal di mesin.",
];
