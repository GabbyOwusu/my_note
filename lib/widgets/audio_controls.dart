import 'package:flutter/material.dart';

class AudioControls extends StatefulWidget {
  final Color color;

  final bool playing;
  final Function playFunction;
  final Function stopFunction;
  final void Function(double) onSliderChanged;

  const AudioControls({
    Key? key,
    required this.color,
    required this.playFunction,
    required this.stopFunction,
    required this.playing,
    required this.onSliderChanged,
  }) : super(key: key);
  @override
  _AudioControls createState() => _AudioControls();
}

class _AudioControls extends State<AudioControls> {
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
              Expanded(
                child: SliderTheme(
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
                    onChanged: widget.onSliderChanged,
                  ),
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
              icon: Icon(widget.playing ? Icons.pause : Icons.play_arrow),
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
