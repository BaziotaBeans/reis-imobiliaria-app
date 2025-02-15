import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:reis_imovel_app/data/county_data.dart';
import 'package:reis_imovel_app/dto/Property.dart';
import 'package:reis_imovel_app/dto/PropertyResult.dart';
import 'package:reis_imovel_app/enums.dart';
import 'package:reis_imovel_app/utils/app_constants.dart';

class AppUtils {
  static List<String> transformValuesToList(List<Map<String, dynamic>> county) {
    List<String> valuesList = [];

    for (var countyData in county) {
      String value = countyData["value"];
      List<String> values = value.split(", ");
      valuesList.addAll(values);
    }

    return valuesList;
  }

  static List<String> filtrarCountyData(String valor) {
    List<String> filteredList = [];

    for (var county in countyData) {
      if (county['parent'] == valor) {
        filteredList = county['value'].toString().split(", ");
      }
    }

    return filteredList;
  }

  static bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidUrl && endsWithFile;
  }

  static String? validateValueAsNumber(String? _value, String type) {
    final valueString = _value ?? '';
    final value = int.tryParse(valueString) ?? -1;

    if (value <= 0) {
      return 'Informe um $type';
    }

    return null;
  }

  static String formatDateDayAndMounth(String dateTimeString) {
    final DateTime parsedDate = DateTime.parse(dateTimeString);
    // return DateFormat('dd MMMM', 'pt_Br').format(parsedDate);
    return DateFormat('dd MMMM').format(parsedDate);
    // final DateFormat formatter = DateFormat('dd MMMM');
    // return formatter.format(parsedDate);
  }

  static String formatDateDayMounthAndYear(String dateTimeString) {
    String dateString = dateTimeString;
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  static String formatNumberWithSufix(double value) {
    List<String> suffixes = ['k', 'M', 'B', 'T'];

    // Se o valor for menor que 1000, não é necessário adicionar sufixo
    if (value < 1000) {
      return value.toString();
    }

    int exp = (math.log(value) / math.log(1000)).floor();
    double result = value / math.pow(1000, exp);

    return result.toStringAsFixed(0) + suffixes[exp - 1];
  }

  // static String formatPrice(double numero) {
  //   // Converte o número para uma string formatada com duas casas decimais
  //   String numeroFormatado = numero.toStringAsFixed(2);

  //   // Divide a string em partes antes e depois do ponto decimal
  //   List<String> partes = numeroFormatado.split('.');

  //   // Formata a parte antes do ponto decimal com separadores de milhar
  //   String parteAntesDecimal = partes[0].replaceAllMapped(
  //       RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');

  //   // Se houver parte decimal, adiciona o ponto decimal e a parte decimal
  //   String parteDecimal = partes.length > 1 ? ',${partes[1]}' : '';

  //   // Retorna o número formatado com o símbolo 'kz'
  //   return '$parteAntesDecimal$parteDecimal kz';
  // }

  static String formatPrice(double price) {
    final formatter = NumberFormat.currency(
      locale: 'pt_PT',
      symbol: 'kz',
      decimalDigits: 2,
    );
    return formatter.format(price);
  }

  static Future<void> signInUserAnon() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print(
          "Signed in with temporary account. UID: ${userCredential?.user?.uid}");
    } catch (e) {
      print(e);
    }
  }

  static Future<File?> getImageFromGallery(BuildContext context) async {
    try {
      List<MediaFile>? singleMedia =
          await GalleryPicker.pickMedia(context: context, singleMedia: true);
      return singleMedia?.first.getFile();
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> uploadFileForUser(File file) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final storageRef = FirebaseStorage.instance.ref();
      final fileName = file.path.split("/").last;
      final timestamp = DateTime.now().microsecondsSinceEpoch;
      final uploadRef =
          storageRef.child("$userId/uploads/$timestamp-$fileName");
      final response = await uploadRef.putFile(file);

      var dowurl = await response.ref.getDownloadURL();

      print('YES');
      print(dowurl);
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<bool> uploadMultipleFilesForUser(
    List<MediaFile> files,
    void Function(String) addImageToImageList,
  ) async {
    bool result = false;

    debugPrint(
        "-------------------------------------------ENTROU NO UPLOAD-------------------------------------------");

    for (MediaFile mediaFile in files) {
      try {
        File file = await mediaFile.getFile();
        final storageRef = FirebaseStorage.instance.ref();
        final fileName = file.path.split("/").last;
        final timestamp = DateTime.now().microsecondsSinceEpoch;
        final uploadRef = storageRef.child("uploads/$timestamp-$fileName");

        final metadata = SettableMetadata(
          contentType: 'image/*', // Permite qualquer tipo de imagem
        );

        final response = await uploadRef.putFile(file, metadata);

        var downloadURL = await response.ref.getDownloadURL();

        addImageToImageList(downloadURL);

        result = true;
      } catch (e) {
        debugPrint(
            "-------------------------------------------ERRO NO UPLOAD-------------------------------------------");
        debugPrint("$e");
        debugPrint(
            "-------------------------------------------ERRO NO UPLOAD-------------------------------------------");
        result = false;
      }
    }
    return result;
  }

  static Future<bool> uploadPDF(
    PlatformFile pdfFile,
    void Function(String) addDocument,
  ) async {
    try {
      final file = File(pdfFile.path!);
      final storageRef = FirebaseStorage.instance.ref();
      final timestamp = DateTime.now().microsecondsSinceEpoch;
      final uploadRef =
          storageRef.child("documents/$timestamp-${pdfFile.name}");

      final metadata = SettableMetadata(
        contentType: 'application/pdf',
      );

      final response = await uploadRef.putFile(file, metadata);

      final downloadURL = await response.ref.getDownloadURL();
      print("PDF disponível em: $downloadURL");

      addDocument(downloadURL);

      return true;
    } catch (e) {
      debugPrint("Erro no upload: $e");
      return false;
    }
  }

  static Future<List<Reference>?> getUsersUploadedFiles() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final storageRef = FirebaseStorage.instance.ref();
      final uploadsRefs = storageRef.child("$userId/uploads");
      final uploads = await uploadsRefs.listAll();
      return uploads.items;
    } catch (e) {
      print(e);
    }
  }

  static String getPropertyStatus(String selectedPropertyStatus) {
    if (selectedPropertyStatus == 'Público')
      return PropertyStatus.PUBLISHED.name;
    else if (selectedPropertyStatus == 'Em espera')
      return PropertyStatus.STANDBY.name;
    else if (selectedPropertyStatus == 'Arrendado')
      return PropertyStatus.RENTED.name;
    return '';
  }

  static String getWeekDay(String weekDay) {
    if (weekDay == 'Segunda-feira') {
      return 'MONDAY';
    } else if (weekDay == 'Terça-feira') {
      return 'TUESDAY';
    } else if (weekDay == 'Quarta-feira') {
      return 'WEDNESDAY';
    } else if (weekDay == 'Quinta-feira') {
      return 'THURSDAY';
    } else if (weekDay == 'Sexta-feira') {
      return 'FRIDAY';
    } else if (weekDay == 'Sábado') {
      return 'SATURDAY';
    }
    return 'SUNDAY';
  }

  static String showWeekDay(String weekDay) {
    if (weekDay == 'MONDAY') {
      return 'Segunda-feira';
    } else if (weekDay == 'Terça-feira') {
      return 'TUESDAY';
    } else if (weekDay == 'TUESDAY') {
      return 'Terça-feira';
    } else if (weekDay == 'WEDNESDAY') {
      return 'Quarta-feira';
    } else if (weekDay == 'THURSDAY') {
      return 'Quinta-feira';
    } else if (weekDay == 'FRIDAY') {
      return 'Sexta-feira';
    } else if (weekDay == 'SATURDAY') {
      return 'Sábado';
    }
    return 'Domingo';
  }

  static String formatTimeInPickedTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  static String getPropertyStatusLabel(String propertyStatus) {
    if (propertyStatus == 'PUBLISHED') {
      return 'Público';
    } else if (propertyStatus == 'STANDBY') {
      return 'Pendente';
    } else if (propertyStatus == 'DENIED') {
      return 'Negado';
    }
    return 'Ocupado';
  }

  static bool isEmptyIntValue(int value) {
    return value == 0;
  }

  static double getTotalValueToPaidInProperty(PropertyResult data) {
    if ((AppConstants.propertyTypeGround == data.property.fkPropertyType) ||
        (AppConstants.propertyTypeSale == data.property.fkPropertyType)) {
      return data.property.price;
    } else if (data.property.paymentModality == 'Mensal') {
      return data.property.price;
    } else if (data.property.paymentModality == 'Trimestral') {
      return data.property.price * 3;
    } else if (data.property.paymentModality == 'Semestral') {
      return data.property.price * 6;
    }
    return data.property.price * 12;
  }

  static String getPropertyTypeLabel(String propertyTypeId) {
    if (AppConstants.propertyTypeGround == propertyTypeId) {
      return 'Venda de Terreno';
    } else if (AppConstants.propertyTypeSale == propertyTypeId) {
      return 'Venda de Imóvel';
    }
    return 'Aluguel de Imóvel';
  }

  static String getPropertyTypeTag(String propertyTypeId) {
    if (AppConstants.propertyTypeGround == propertyTypeId) {
      return 'Venda de Terreno';
    } else if (AppConstants.propertyTypeSale == propertyTypeId) {
      return 'Venda de Imóvel';
    }
    return 'Arrendamento';
  }

  static String getPaymentModalityTextForContract(String paymentModality) {
    if (paymentModality == 'Mensal') {
      return 'mensalmente';
    } else if (paymentModality == 'Trimestral') {
      return 'trimestralmente';
    } else if (paymentModality == 'Semestral') {
      return 'semestralmente';
    }
    return 'anualmente';
  }

  static String getPaymentModalityForContract(String paymentModality) {
    if (paymentModality == 'Mensal') {
      return 'mês';
    } else if (paymentModality == 'Trimestral') {
      return 'trimestre';
    } else if (paymentModality == 'Semestral') {
      return 'semestre';
    }
    return 'ano';
  }

  static isContractDateValid(String? contractDate) {
    DateTime parsedContractDate =
        DateTime.parse(contractDate ?? DateTime.now().toString());

    DateTime now = DateTime.now();

    return parsedContractDate.isAfter(now);
  }

  static String getFirstAndLastName(String fullName) {
    // Remove espaços extras e divide o nome em partes
    List<String> parts = fullName.trim().split(RegExp(r'\s+'));

    // Retorna o primeiro e o último nome
    if (parts.length >= 2) {
      return '${parts.first} ${parts.last}';
    } else if (parts.length == 1) {
      // Caso o nome tenha apenas uma palavra, retorna ela mesma
      return parts.first;
    }
    return ''; // Retorna vazio se não houver nome
  }

  static String? getPropertyType(Property? property) {
    return property?.fkPropertyTypeEntity?.designation;
  }

  static String getPaymentMethodLabel(String value) {
    if (value == 'MULTICAIXA_EXPRESS') {
      return 'Multicaixa Express';
    } else {
      return 'Referência';
    }
  }

  static String getPropertyTypeToSaveInDatabase(String value) {
    if (value == 'APARTMENT') return 'Apartamento';
    if (value == 'HOME') return 'Casa';
    if (value == 'VILLA') return 'Vivenda';
    return 'Terreno';
  }

  static String generateRandomReference() {
    const int leftLimit = 48; // Código ASCII para '0'
    const int rightLimit = 57; // Código ASCII para '9'
    const int targetStringLength = 9;

    final random = Random();

    return String.fromCharCodes(
      List.generate(
        targetStringLength,
        (_) => leftLimit + random.nextInt(rightLimit - leftLimit + 1),
      ),
    );
  }
}
