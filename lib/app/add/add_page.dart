import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();

  class _AddPageState extends State<AddPage> {
    String? imageURL;
    String? title;
    DateTime? date;
  }