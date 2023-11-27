import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventario_yummy_sushi/app/extensions/size_extension.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class GeneratedPdfCubit extends Cubit<bool> {
  GeneratedPdfCubit() : super(false);

  Future<void> generatePdf({
    required String date,
    required String inventory,
    required List<String> headers,
    required List<List<String>> data,
  }) async {
    emit(false);
    WidgetsFlutterBinding.ensureInitialized();

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Header(
                level: 0,
                child: pw.Text(
                  'Inventario Yummy sushi',
                  style: pw.TextStyle(
                    fontSize: 25.sp,
                    color: PdfColors.blue500,
                  ),
                ),
              ),
              pw.Header(
                level: 1,
                child: pw.Text(inventory),
              ),
              pw.Paragraph(
                text: date,
              ),
              pw.Table.fromTextArray(
                headers: headers,
                data: data,
              ),
            ],
          );
        },
      ),
    );
    final String dir = (await getApplicationSupportDirectory()).path;
    final String path = '$dir/$inventory.pdf';
    final File file = File(path);

    await pdf.save().then((bytes) async {
      await file.writeAsBytes(bytes, flush: true);
    });

    // final XFile xFile = XFile(file.path);

    await Share.shareFiles([file.path], text: 'Inventario Yummy sushi');

    emit(true);
  }
}
