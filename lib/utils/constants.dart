import 'package:flutter/material.dart';

//colors
const kRedProgressColor = Color(0xFFB60A0A);
const kGreenProgressColor = Color(0xFF13B60A);
const kNoProgressColor = Color(0xFFD9D9D9);
const kAppBackgroundColor = Color(0xFFF1F2F3);

//styles
const kSignUpButtonTextStyle = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black);

const kBottomNavHeaderTextStyle = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.white);

const kAppSettingTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 30,
  fontWeight: FontWeight.bold,
  fontFamily: 'Nunito',
);

const kEditHabitTextStyle = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white);

const List<IconData> habitIconsList = [
  Icons.fitness_center,
  Icons.menu_book,
  Icons.local_drink,
  Icons.self_improvement,
  Icons.brush,
  Icons.directions_run,
  Icons.directions_bike,
  Icons.nightlight_round,
  Icons.accessibility,
  Icons.edit,
  Icons.restaurant,
  Icons.directions_walk,
  Icons.home,
  Icons.work,
  Icons.book,
  Icons.movie,
  Icons.shopping_cart,
  Icons.beach_access,
  Icons.music_note,
  Icons.flight,
  Icons.hotel,
  Icons.local_hospital,
  Icons.pets,
  Icons.child_friendly,
  Icons.phone,
  Icons.email,
  Icons.message,
  Icons.notifications,
  Icons.search,
  Icons.settings,
  Icons.camera_alt,
  Icons.videocam,
  Icons.mic,
  Icons.share,
  Icons.favorite,
  Icons.star,
  Icons.add,
  Icons.remove,
  Icons.check,
  Icons.close,
  Icons.arrow_upward,
  Icons.arrow_downward,
  Icons.arrow_left,
  Icons.arrow_right,
  Icons.today,
  Icons.event,
  Icons.alarm,
  Icons.location_on,
  Icons.map,
  Icons.lock,
  Icons.lock_open,
  Icons.visibility,
  Icons.visibility_off,
  Icons.cloud,
  Icons.wb_sunny,
  Icons.wb_cloudy,
  Icons.wb_iridescent,
  Icons.brightness_4,
  Icons.brightness_7,
  Icons.color_lens,
  Icons.format_bold,
  Icons.format_italic,
  Icons.format_underlined,
  Icons.format_quote,
  Icons.insert_emoticon,
  Icons.attach_file,
  Icons.attach_money,
  Icons.audiotrack,
  Icons.cake,
  Icons.card_giftcard,
  Icons.card_membership,
  Icons.card_travel,
  Icons.celebration,
  Icons.check_circle,
  Icons.child_care,
  Icons.credit_card,
  Icons.directions,
  Icons.disc_full,
  Icons.drafts,
  Icons.error,
  Icons.event_seat,
  Icons.exit_to_app,
  Icons.expand_less,
  Icons.expand_more,
  Icons.explicit,
  Icons.face,
  Icons.fast_forward,
  Icons.fast_rewind,
  Icons.file_download,
  Icons.file_upload,
  Icons.filter_list,
  Icons.flag,
  Icons.folder,
  Icons.folder_open,
  Icons.format_align_center,
  Icons.format_align_justify,
  Icons.format_align_left,
  Icons.format_align_right,
  Icons.format_clear,
  Icons.format_color_fill,
  Icons.format_list_bulleted,
  Icons.format_list_numbered,
  Icons.format_paint,
  Icons.format_shapes,
  Icons.format_size,
  Icons.forward,
  Icons.functions,
  Icons.gamepad,
  Icons.gesture,
  Icons.gif,
  Icons.group,
  Icons.headset,
  Icons.headset_mic,
  Icons.healing,
  Icons.highlight,
  Icons.high_quality,
  Icons.history,
  Icons.home_work,
  Icons.hourglass_empty,
  Icons.hourglass_full,
  Icons.http,
  Icons.https,
  Icons.image_aspect_ratio,
  Icons.import_export,
  Icons.inbox,
  Icons.info,
  Icons.input,
  Icons.invert_colors,
  Icons.keyboard,
  Icons.label,
  Icons.landscape,
  Icons.language,
  Icons.launch,
  Icons.library_add,
  Icons.library_books,
  Icons.library_music,
  Icons.lightbulb_outline,
  Icons.line_weight,
  Icons.linear_scale,
  Icons.link,
  Icons.list,
  Icons.live_tv,
  Icons.local_activity,
  Icons.local_airport,
  Icons.local_atm,
  Icons.local_bar,
  Icons.local_cafe,
  Icons.local_car_wash,
  Icons.local_convenience_store,
  Icons.local_dining,
  Icons.local_florist,
  Icons.local_gas_station,
  Icons.local_grocery_store,
  Icons.local_hotel,
  Icons.local_library,
  Icons.local_mall,
  Icons.local_movies,
  Icons.local_offer,
  Icons.local_parking,
  Icons.local_pharmacy,
  Icons.local_phone,
  Icons.local_pizza,
  Icons.local_post_office,
  Icons.local_printshop,
  Icons.local_see,
  Icons.local_shipping,
  Icons.local_taxi,
  Icons.location_city,
  Icons.loop,
  Icons.loupe,
  Icons.mail_outline,
  Icons.memory,
  Icons.menu,
  Icons.merge_type,
  Icons.mic_none,
  Icons.military_tech,
  Icons.minimize,
  Icons.mobile_friendly,
  Icons.mobile_off,
];
