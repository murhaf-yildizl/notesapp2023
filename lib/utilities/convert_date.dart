import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

String convertDate(String? date) {
  if( date==null)
    return "";
  Duration timeAgo = DateTime.now().difference(DateTime.parse(date));
  DateTime difference = DateTime.now().subtract(timeAgo);

  return timeago.format(difference);
}

String getDateTime(String? date)
{
  if(date==null)
    return '';

  var dateTime=DateTime.parse(date);
  var formatedDate=DateFormat("dd/MM/yyyy \n  hh:mm a ");

  return formatedDate.format(dateTime);
 }
