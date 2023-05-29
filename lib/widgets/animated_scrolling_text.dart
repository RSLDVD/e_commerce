import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedScrollingText extends StatefulWidget {
  const AnimatedScrollingText({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedScrollingTextState createState() => _AnimatedScrollingTextState();
}

class _AnimatedScrollingTextState extends State<AnimatedScrollingText>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  static const textData =
      "The quick brown fox jumps over the lazy dog  Lorem ipsum dolor sit amen, consenter advising elite. Sed elision, relit eu vestibule laconia, est Maurist elided lorem, a valuta nuns nullo quia quam. Maecenas eger enif func. Nulls facility. Fusee premium metes ac massa laurent, vel laborite ante bandit. Duds ut vehicular magna. Team elided posturer lorem, vitae fringiest sapient fuegian ac. Phallus elision nibs id massa condiment's dictum. In hac habitats Plataea dictums. Iquique at felid nec felid placenta aalesund. Sed biennium ornate justs, in faucet's tellus. Ut at maurist rectus. Nuns curses veldt sit amen orca tempus, vel vivaria ligula aliquot. Sed eu endue non dui venerates fuegian eger et purus.";
  late final TextPainter _textPainter;
  double _textWidth = 0;

  @override
  void initState() {
    super.initState();
    _textPainter = TextPainter(
      text: const TextSpan(
          text: textData,
          style: TextStyle(
            fontSize: 16,
          )),
      textDirection: TextDirection.ltr,
    );
    _textPainter.layout();
    _textWidth = _textPainter.size.width;

    _scrollController = ScrollController(initialScrollOffset: 0);
    Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (_scrollController.offset < _textWidth) {
        _scrollController.animateTo(_textWidth,
            duration: Duration(seconds: ((textData.length) * 0.25).toInt()),
            curve: Curves.linear);
      } else {
        _scrollController.jumpTo(0);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xff002B5B),
      ),
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.fromLTRB(7, 0, 7, 5),
      height: 30,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          children: const [
            SizedBox(width: 10),
            Text(textData,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                color: Color(
                  0xffD8D8D8),
              ),
            ),
            SizedBox(width: 110),
          ],
        ),
      ),
    );
  }
}
