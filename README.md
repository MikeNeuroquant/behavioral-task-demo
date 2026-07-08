# English Language Trainer

A small interactive app built in MATLAB with Psychtoolbox-3. Three exercises for practicing English: image naming, spoken-word spelling, and spoken-letter identification. The user picks an exercise from a click-based main menu, gets per-trial feedback, and sees a final accuracy screen with a matching emoji. All attempts across the session get logged to an Excel file.

Originally written in February 2023 as a course project. Sharing it as an early example of building an interactive behavioral interface end-to-end (stimulus presentation, input capture, scoring, and data export).

## What it does

The main menu shows four rectangles you can click with the mouse:

- **Blue square (1):** word spelling. A `.wav` audio plays a word; you spell it on the keyboard.
- **Green square (2):** image recognition. An image appears; you type its name.
- **Black square (3):** letter identification. A `.wav` audio plays a single letter; you press the matching key.
- **Red square (EXIT):** closes the app.

Inside each exercise the flow is the same: press Enter to trigger the next trial, respond, get immediate visual feedback (green screen for correct, red for wrong), and press Esc to return to the menu. When you exit an exercise you get a final screen with your accuracy for that block, color-coded to the performance tier and paired with an emoji.

At the end of the session, all attempts get written to `Final_Output.xlsx` with three columns: attempt number, accuracy percentage, and exercise name.

## Feedback design

The end-of-block screen is the moment where the app tries to earn its keep as a learning tool. A raw percentage isn't very motivating on its own, so the score gets mapped to a background color and an emoji that together convey both the result and a suggested attitude toward it.

| Accuracy       | Screen color             | Emoji                                                     | Message tone          |
|----------------|--------------------------|-----------------------------------------------------------|-----------------------|
| No attempt     | Magenta                  | ![](assets/smile_results/1_thinking.jpg)                  | Nothing to score yet  |
| 0 - 25 %       | Red `[255, 0, 0]`        | ![](assets/smile_results/2_pensive.png)                   | You can improve a lot |
| 26 - 50 %      | Orange `[255, 117, 20]`  | ![](assets/smile_results/3_neutral.png)                   | Fairly good           |
| 51 - 75 %      | Green `[0, 255, 0]`      | ![](assets/smile_results/4_smile.jpg)                     | You are good          |
| 76 - 100 %     | Teal `[8, 143, 143]`     | ![](assets/smile_results/5_grin.png)                      | You are excellent     |

A few things worth calling out about this choice:

- The bottom tier isn't shamed. Red gets a pensive face and an encouragement to keep going, not a frown or a cry.
- The top tier isn't celebrated with a saturated warm color that reads as "prize won". It uses teal instead, which sits closer to a calm-competence signal than to a dopamine hit. The intent was to reward mastery without turning it into a slot machine.
- The images get loaded from disk and sorted alphabetically at runtime, so the tier order is enforced by filename (`1_thinking`, `2_pensive`, `3_neutral`, `4_smile`, `5_grin`). Swapping the visual set is a matter of dropping in five new files with the same numeric prefixes.

## Repo structure

```
english-language-trainer/
├── main.m                       Main script (menu + three exercise blocks)
├── src/
│   ├── final_accuracy.m         Computes accuracy, renders the feedback screen
│   ├── PTBTypedWord.m           Custom keyboard input handler
│   └── checkword.m              NOT INCLUDED, see "Known gaps" below
├── stimuli/
│   ├── images/                  38 .jpg files (objects and animals)
│   ├── words/                   38 .wav files (spoken words matching the images)
│   └── letters/                 26 .wav files (A-Z spoken letters)
├── assets/
│   └── smile_results/           5 emoji images, one per performance tier
├── output/                      Where Final_Output.xlsx gets written
└── README.md
```

## Running it

The app is built on MATLAB and Psychtoolbox-3 and needs a working audio device for the spelling blocks. The path variables inside `main.m` and `src/final_accuracy.m` are placeholders (`path/to/...`) that need to be pointed at the actual folders in this repo before it'll run.

If you'd like a walkthrough, a demo, or a runnable version with the paths configured, get in touch and I'll put it together.

## What it demonstrates

For a reviewer scanning this quickly, the interesting bits are:

- **End-to-end interactive experiment design.** Menu, stimulus rendering, keyboard and mouse capture, audio playback, and trial-level scoring, all built from primitives without a higher-level framework.
- **Custom input handling.** `PTBTypedWord.m` implements a text-entry loop with backspace and enter, since Psychtoolbox doesn't ship a text field out of the box.
- **Deliberate feedback UX.** Per-trial reinforcement (green / red flash) plus an end-of-block screen where color, imagery, and message tone are all mapped to the same underlying score. Small decisions, but each one made on purpose.
- **Structured logging.** Session data gets accumulated across blocks (accuracy, exercise type, attempt number) and exported to Excel for downstream analysis.
- **Clean separation of concerns.** Scoring and feedback logic live in a dedicated function; input capture lives in another. The main script handles flow control.

The scope is deliberately small. It was a course project, not a shipped product.

## Known gaps

Being honest about what you'd trip over if you tried to run this today:

- **Path variables need configuring.** The original 2023 version used absolute paths at four points (main script and `final_accuracy.m`). Those have been replaced with `path/to/...` placeholders, so the code isn't runnable as-is. 
- **`checkword.m` isn't in this repo.** It's referenced by the word- and letter-spelling blocks in `main.m`. It was a helper that compared the typed response against the target and incremented the accuracy counter. If you want to run those two exercises, you'd need to reconstruct it as a two-line function that takes the typed word and the target, compares them with `strcmp`, and returns updated `accuracy` and `counter` values.

## Context

An early experience building a fully interactive interface with behavioral data capture. The paradigm is simpler than the experiments I've built since, but the underlying structure (stimulus, response window, scoring, session log) is the same shape as any behavioral study or task-based A/B test.
