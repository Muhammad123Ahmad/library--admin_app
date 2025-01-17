import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {

  final String title;
  final VoidCallback onTap;
  final  bool loading;
  const RoundButton({super.key,required this.onTap,required this.title,this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration:  BoxDecoration(
      
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xff8207ed),
        ),
        child: Center(child: loading ? const CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 3,
          
        ):
        Text(title,style: const TextStyle(color: Colors.white,fontSize: 14),)),
      ),
    );
  }
}