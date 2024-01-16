// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Every moment you invest in studying brings you one step closer to realizing your academic dreams`
  String get splash_text {
    return Intl.message(
      'Every moment you invest in studying brings you one step closer to realizing your academic dreams',
      name: 'splash_text',
      desc: '',
      args: [],
    );
  }

  /// `Your Path`
  String get splash_title {
    return Intl.message(
      'Your Path',
      name: 'splash_title',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get splash_button {
    return Intl.message(
      'Continue',
      name: 'splash_button',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back`
  String get login_title {
    return Intl.message(
      'Welcome Back',
      name: 'login_title',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get login_appar {
    return Intl.message(
      'Sign in',
      name: 'login_appar',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with your email and password  \nor continue with social media`
  String get login_text {
    return Intl.message(
      'Sign in with your email and password  \nor continue with social media',
      name: 'login_text',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get login_button {
    return Intl.message(
      'Continue',
      name: 'login_button',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get login_hint_email {
    return Intl.message(
      'Email',
      name: 'login_hint_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get login_label_email {
    return Intl.message(
      'Enter your email',
      name: 'login_label_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get login_hint_pass {
    return Intl.message(
      'Password',
      name: 'login_hint_pass',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get login_label_pass {
    return Intl.message(
      'Enter your password',
      name: 'login_label_pass',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get login_forgot {
    return Intl.message(
      'Forgot Password',
      name: 'login_forgot',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get login_remeber {
    return Intl.message(
      'Remember me',
      name: 'login_remeber',
      desc: '',
      args: [],
    );
  }

  /// `'Don't have on account ?`
  String get login_text_singUp {
    return Intl.message(
      '\'Don\'t have on account ?',
      name: 'login_text_singUp',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get login_button_singUp {
    return Intl.message(
      'Sign Up',
      name: 'login_button_singUp',
      desc: '',
      args: [],
    );
  }

  /// `Register Account`
  String get signUp_title {
    return Intl.message(
      'Register Account',
      name: 'signUp_title',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp_appar {
    return Intl.message(
      'Sign up',
      name: 'signUp_appar',
      desc: '',
      args: [],
    );
  }

  /// `Complete your details or continue \nwith social media`
  String get signUp_text {
    return Intl.message(
      'Complete your details or continue \nwith social media',
      name: 'signUp_text',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get signUp_button {
    return Intl.message(
      'Continue',
      name: 'signUp_button',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get signUp_hint_email {
    return Intl.message(
      'Email',
      name: 'signUp_hint_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get signUp_label_email {
    return Intl.message(
      'Enter your email',
      name: 'signUp_label_email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get signUp_hint_pass {
    return Intl.message(
      'Password',
      name: 'signUp_hint_pass',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get signUp_label_pass {
    return Intl.message(
      'Enter your password',
      name: 'signUp_label_pass',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get signUp_hint_confirm_pass {
    return Intl.message(
      'Confirm Password',
      name: 'signUp_hint_confirm_pass',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter your password`
  String get signUp_label_confirm_pass {
    return Intl.message(
      'Re-enter your password',
      name: 'signUp_label_confirm_pass',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get signUp_forgot {
    return Intl.message(
      'Forgot Password',
      name: 'signUp_forgot',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get signUp_remeber {
    return Intl.message(
      'Remember me',
      name: 'signUp_remeber',
      desc: '',
      args: [],
    );
  }

  /// `'Don't have on account ?`
  String get signUp_text_singUp {
    return Intl.message(
      '\'Don\'t have on account ?',
      name: 'signUp_text_singUp',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp_button_singUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp_button_singUp',
      desc: '',
      args: [],
    );
  }

  /// `By continuing your confirm that you agree \nwith our Term and Condition`
  String get signUp_term {
    return Intl.message(
      'By continuing your confirm that you agree \nwith our Term and Condition',
      name: 'signUp_term',
      desc: '',
      args: [],
    );
  }

  /// `Hi,`
  String get home_welcome {
    return Intl.message(
      'Hi,',
      name: 'home_welcome',
      desc: '',
      args: [],
    );
  }

  /// `WISE University`
  String get home_title {
    return Intl.message(
      'WISE University',
      name: 'home_title',
      desc: '',
      args: [],
    );
  }

  /// `Acadmic`
  String get home_acadmic {
    return Intl.message(
      'Acadmic',
      name: 'home_acadmic',
      desc: '',
      args: [],
    );
  }

  /// `Exchange Book`
  String get home_exchange_book {
    return Intl.message(
      'Exchange Book',
      name: 'home_exchange_book',
      desc: '',
      args: [],
    );
  }

  /// `To-Do List`
  String get home_toDo {
    return Intl.message(
      'To-Do List',
      name: 'home_toDo',
      desc: '',
      args: [],
    );
  }

  /// `Ads`
  String get home_ads {
    return Intl.message(
      'Ads',
      name: 'home_ads',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get home_profile {
    return Intl.message(
      'Profile',
      name: 'home_profile',
      desc: '',
      args: [],
    );
  }

  /// `Houses`
  String get home_houses {
    return Intl.message(
      'Houses',
      name: 'home_houses',
      desc: '',
      args: [],
    );
  }

  /// `Braking News`
  String get home_braking {
    return Intl.message(
      'Braking News',
      name: 'home_braking',
      desc: '',
      args: [],
    );
  }

  /// `Business cafeteria`
  String get home_braking_title1 {
    return Intl.message(
      'Business cafeteria',
      name: 'home_braking_title1',
      desc: '',
      args: [],
    );
  }

  /// `Cooperation with the Pharmacists Syndicate`
  String get home_braking_title2 {
    return Intl.message(
      'Cooperation with the Pharmacists Syndicate',
      name: 'home_braking_title2',
      desc: '',
      args: [],
    );
  }

  /// `University`
  String get university_title {
    return Intl.message(
      'University',
      name: 'university_title',
      desc: '',
      args: [],
    );
  }

  /// `Abstracts`
  String get university_tapBar_abstracts {
    return Intl.message(
      'Abstracts',
      name: 'university_tapBar_abstracts',
      desc: '',
      args: [],
    );
  }

  /// `Ads`
  String get university_tapBar_ads {
    return Intl.message(
      'Ads',
      name: 'university_tapBar_ads',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get university_tapBar_news {
    return Intl.message(
      'News',
      name: 'university_tapBar_news',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get university_tapBar_calander {
    return Intl.message(
      'Events',
      name: 'university_tapBar_calander',
      desc: '',
      args: [],
    );
  }

  /// `University`
  String get university_abstracts {
    return Intl.message(
      'University',
      name: 'university_abstracts',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get university_button_abstracts {
    return Intl.message(
      'Add',
      name: 'university_button_abstracts',
      desc: '',
      args: [],
    );
  }

  /// `Title Abstract`
  String get university_search {
    return Intl.message(
      'Title Abstract',
      name: 'university_search',
      desc: '',
      args: [],
    );
  }

  /// `Upload Abstract`
  String get university_upload_abstracts_title {
    return Intl.message(
      'Upload Abstract',
      name: 'university_upload_abstracts_title',
      desc: '',
      args: [],
    );
  }

  /// `Attach Abstract.pdf`
  String get university_upload_abstracts_pick_button {
    return Intl.message(
      'Attach Abstract.pdf',
      name: 'university_upload_abstracts_pick_button',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get university_upload_abstracts_submit_button {
    return Intl.message(
      'Submit',
      name: 'university_upload_abstracts_submit_button',
      desc: '',
      args: [],
    );
  }

  /// `No matching Abstract found`
  String get university_upload_abstracts_null {
    return Intl.message(
      'No matching Abstract found',
      name: 'university_upload_abstracts_null',
      desc: '',
      args: [],
    );
  }

  /// `Ads`
  String get university_ads_title {
    return Intl.message(
      'Ads',
      name: 'university_ads_title',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get university_news_title {
    return Intl.message(
      'News',
      name: 'university_news_title',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get university_events_title {
    return Intl.message(
      'Events',
      name: 'university_events_title',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get university_calendar_title {
    return Intl.message(
      'Calendar',
      name: 'university_calendar_title',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get profile_button_editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'profile_button_editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get profile_button_information {
    return Intl.message(
      'Privacy Policy',
      name: 'profile_button_information',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get profile_button_settings {
    return Intl.message(
      'Settings',
      name: 'profile_button_settings',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get profile_button_logout {
    return Intl.message(
      'Log out',
      name: 'profile_button_logout',
      desc: '',
      args: [],
    );
  }

  /// `Exchange Book`
  String get exchange_book_title {
    return Intl.message(
      'Exchange Book',
      name: 'exchange_book_title',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get exchange_book_button {
    return Intl.message(
      'Add',
      name: 'exchange_book_button',
      desc: '',
      args: [],
    );
  }

  /// `Upload Book`
  String get exchange_book_upload_title {
    return Intl.message(
      'Upload Book',
      name: 'exchange_book_upload_title',
      desc: '',
      args: [],
    );
  }

  /// `Book Title`
  String get exchange_book_upload_hint_title {
    return Intl.message(
      'Book Title',
      name: 'exchange_book_upload_hint_title',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get exchange_book_upload_hint_Description {
    return Intl.message(
      'Description',
      name: 'exchange_book_upload_hint_Description',
      desc: '',
      args: [],
    );
  }

  /// `Please indicate where the book is located`
  String get exchange_book_upload_text {
    return Intl.message(
      'Please indicate where the book is located',
      name: 'exchange_book_upload_text',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get exchange_book_upload_submit_button {
    return Intl.message(
      'Submit',
      name: 'exchange_book_upload_submit_button',
      desc: '',
      args: [],
    );
  }

  /// `Choose image`
  String get exchange_book_upload_choose_button {
    return Intl.message(
      'Choose image',
      name: 'exchange_book_upload_choose_button',
      desc: '',
      args: [],
    );
  }

  /// `Houses`
  String get houses_title {
    return Intl.message(
      'Houses',
      name: 'houses_title',
      desc: '',
      args: [],
    );
  }

  /// `Google Map`
  String get houses_button {
    return Intl.message(
      'Google Map',
      name: 'houses_button',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get navBar_home {
    return Intl.message(
      'Home',
      name: 'navBar_home',
      desc: '',
      args: [],
    );
  }

  /// `University`
  String get navBar_university {
    return Intl.message(
      'University',
      name: 'navBar_university',
      desc: '',
      args: [],
    );
  }

  /// `To-Do`
  String get navBar_profile {
    return Intl.message(
      'To-Do',
      name: 'navBar_profile',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get navBar_toDo {
    return Intl.message(
      'Profile',
      name: 'navBar_toDo',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
