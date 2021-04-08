import 'package:flutter/material.dart';

class Play extends StatefulWidget {
  final Color color;

  const Play({Key key, this.color}) : super(key: key);
  @override
  _Play createState() => _Play();
}

class _Play extends State<Play> {
  double value = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 50),
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
            color: widget.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(Icons.music_note, size: 50, color: widget.color),
        ),
        SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('00:05'),
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 1,
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 8,
                  ),
                ),
                child: Slider(
                  activeColor: widget.color,
                  inactiveColor: widget.color.withOpacity(0.1),
                  value: value,
                  min: 0.0,
                  max: 100,
                  onChanged: (val) {
                    setState(() {
                      value = val;
                    });
                  },
                ),
              ),
              Text('00:05'),
            ],
          ),
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.skip_previous),
              iconSize: 40,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.play_arrow),
              iconSize: 80,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.skip_next),
              iconSize: 40,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
