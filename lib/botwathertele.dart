import 'package:botwathertele/helpers/datetime_parse.helper.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

class TeleBot {
  var nameOfProject = "";
  String? lateDateOfProject;
  var listOfTask = "";
  String? isWaitingStatus;

  teleInit() async {
    var BOT_TOKEN = 'YOUR_BOT_TOKEN_HERE';
    final username = (await Telegram(BOT_TOKEN).getMe()).username;
    var teledart = TeleDart(BOT_TOKEN, Event(username!, sync: true));

    teledart.start();

    teledart.onCommand().listen((message) async {
      await teledart.sendChatAction(message.chat.id, "typing");
      await Future.delayed(Duration(seconds: 2));
      if (message.text == '/dailyreport') {
        isWaitingStatus = "title";
        lateDateOfProject = dateParse(date: DateTime.now());
        message.reply(
            "Masukan Nama Project Di Bawah 👇\nGunakan Command /cancel untuk membatalkan.");
      }
      if (message.text == '/latedailyreport') {
        isWaitingStatus = "lateDate";
        message.reply(
            "Masukan Tanggal\n‼️ Mohon Gunakan Format: dd-mm-yyyy\nGunakana Command /cancel untuk membatalkan.");
      }
      if (message.text == "/start") {
        message.reply(
            "Hello saya bot pemantau gempa dan cuaca tetapi untuk test hari ini saya diubah menjadi bot absen untuk research pengembangan saya jadi mohon maaf jika nama tidak sesuai dengan fungsi",
            replyMarkup: InlineKeyboardMarkup(inlineKeyboard: [
              [
                InlineKeyboardButton(
                    text: "Daily Report", callbackData: "/dailyreport")
              ],
              [
                InlineKeyboardButton(
                    text: "Late Daily Report", callbackData: "/latedailyreport")
              ]
            ]));
      }
      if (isWaitingStatus != null) {
        if (message.text!.toLowerCase() == "yes") {
          if (message.text == '/dailyreport') {
            isWaitingStatus = "title";
            lateDateOfProject = dateParse(date: DateTime.now());
            message.reply(
                "Masukan Nama Project Di Bawah 👇\nGunakan Command /cancel untuk membatalkan.");
          }
          if (message.text == '/latedailyreport') {
            isWaitingStatus = "lateDate";
            message.reply(
                "Masukan Tanggal\n‼️ Mohon Gunakan Format: dd-mm-yyyy\nGunakana Command /cancel untuk membatalkan.");
          }
        }
        if (message.text!.toLowerCase() == "no") {
          message.reply(
              "Name Of Project : $nameOfProject \n${lateDateOfProject != null ? "Late Date : $lateDateOfProject" : ""} \nTask : $listOfTask \n\n Done to save in database");
        }
        if (message.text == "/cancel") {
          message.reply("Di Batalkan");
        }
      }
    });

    teledart.onCallbackQuery().listen((callbackQuery) async {
      await teledart.sendChatAction(callbackQuery.message?.chat.id, "typing");
      await Future.delayed(Duration(seconds: 2));
      if (callbackQuery.data == '/dailyreport') {
        isWaitingStatus = "title";
        lateDateOfProject = dateParse(date: DateTime.now());
        teledart.sendMessage(callbackQuery.message!.chat.id,
            "Masukan Nama Project Di Bawah 👇\nGunakan Command /cancel untuk membatalkan.");
      }
      if (callbackQuery.data == '/latedailyreport') {
        isWaitingStatus = "lateDate";
        teledart.sendMessage(callbackQuery.message!.chat.id,
            "Masukan Tanggal\n‼️ Mohon Gunakan Format: dd-mm-yyyy\nGunakan Command /cancel untuk membatalkan.");
      }
    });

    teledart.onMessage().listen((message) async {
      await teledart.sendChatAction(message.chat.id, "typing");
      await Future.delayed(Duration(seconds: 2));
      switch (isWaitingStatus ?? "") {
        case "title":
          nameOfProject = message.text!;
          isWaitingStatus = "task";
          message.reply(
              "Masukan Task\nGunakan Command /cancel untuk membatalkan.\n\n!! Mohon Gunakan Format Ini:\neg: {{number}}. {{nama_task}} | {{lama pengerjaan}} | {{progress_task}}\n\n1. Contoh Task 1 | 2 hour | 100\n2. Contoh Task 2 | 2 hour | 100\n\nuntuk lama pengerjaan menggunakan ketentuan berikut: minute, houruntuk progress task diisi dari angka 1 - 100",
              allowSendingWithoutReply: true);
          break;
        case "lateDate":
          lateDateOfProject = message.text!;
          isWaitingStatus = "title";
          message.reply(
              "Masukan Nama Project Di Bawah 👇\nGunakan Command /cancel untuk membatalkan.");
          break;
        case "task":
          listOfTask = message.text!;
          message.reply("Task Berhasil Di Tambah");
          await Future.delayed(Duration(seconds: 1));
          message.reply("Apakah Anda Memiliki Task Lain?",
              replyMarkup:
                  ReplyKeyboardMarkup(resizeKeyboard: false, keyboard: [
                [KeyboardButton(text: "Yes"), KeyboardButton(text: "No")]
              ]));
          isWaitingStatus = "taskConfirmation";
          break;
        case "taskConfirmation":
          if (message.text!.toLowerCase() == "yes") {
            if (message.text == '/dailyreport') {
              isWaitingStatus = "title";
              lateDateOfProject = dateParse(date: DateTime.now());
              message.reply(
                  "Masukan Nama Project Di Bawah 👇\nGunakan Command /cancel untuk membatalkan.");
            }
            if (message.text == '/latedailyreport') {
              isWaitingStatus = "lateDate";
              message.reply(
                  "Masukan Tanggal\n‼️ Mohon Gunakan Format: dd-mm-yyyy\nGunakana Command /cancel untuk membatalkan.");
            }
          }
          if (message.text!.toLowerCase() == "no") {
            message.reply(
                "Name Of Project : $nameOfProject \n${lateDateOfProject != null ? "Date : $lateDateOfProject" : ""} \nTask : \n$listOfTask \n\nDone to save in database",
                replyMarkup: ReplyKeyboardRemove(
                  removeKeyboard: true,
                ));
          }
          if (message.text == "/cancel") {
            message.reply("Di Batalkan");
          }
          break;
        default:
      }
    });
  }
}
