import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCalanderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '무엇을 기록할까요?',
              style: Theme.of(context).textTheme.headline4,
            ),
            Center(
              child: CircleAvatar(
                radius: 40,
                child: CupertinoButton(
                  onPressed: () {},
                  child: const Icon(
                    CupertinoIcons.photo_camera_solid,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Text(
              '일정 이름',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            TextFormField(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            textStyle: Theme.of(context).textTheme.subtitle1,
          ),
          child: const Text('다음'),
        ),
      ),
    );
  }
}
