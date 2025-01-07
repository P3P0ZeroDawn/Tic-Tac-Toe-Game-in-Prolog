# Tic-Tac-Toe Game in Prolog

## Overview
This project involves developing a functional Tic-Tac-Toe game using the Prolog programming language. Prolog, known for its application in artificial intelligence and logical problem-solving, provides an efficient way to implement game rules and logic.

The game includes three modes:
- **Basic Mode**: Play against the computer with simple logic.
- **Advanced Mode**: Play against the computer with enhanced strategy.
- **Two-Player Mode**: Compete against another human player.

---

## Features
### Game Modes
1. **Basic Mode**: 
   - The computer makes moves using a basic random generator.
   - Implements defensive logic to block the opponent's winning moves.

2. **Advanced Mode**:
   - Introduces strategic rules for the computer, such as prioritizing center and corners.
   - Applies offensive and defensive strategies for more challenging gameplay.

3. **Two-Player Mode**:
   - Allows two users to play alternately.
   - Validates each move and checks for game completion.

### Game Rules
- A player wins by aligning three symbols (X or O) vertically, horizontally, or diagonally.
- The game ends in a draw if the board is full and no player has won.

---

## How to Run the Game
1. Install **SWI-Prolog** from [SWI-Prolog Official Website](https://www.swi-prolog.org/).
2. Load the game file into the interpreter.
3. Start the game by typing `jugar.` in the Prolog console.
4. Select a game mode from the menu displayed.

### Menu Options
1. Play against the computer (Basic Mode).
2. Play against the computer (Advanced Mode).
3. Play against another player.
4. Exit the program.

---

## Technical Details
### Key Rules
1. **Board Management**: 
   - Represented as a list with 9 elements (initially spaces).
   - Updated after each move.

2. **Winning Logic**: 
   - Evaluates board configurations for three aligned symbols.

3. **Computer Strategy**: 
   - Basic Mode: Random move generation.
   - Advanced Mode: Strategic placement using defensive and offensive rules.

4. **Turn Management**:
   - Alternates between players or between the player and the computer.

5. **Display Logic**:
   - Dynamically updates and displays the board after every move.

### Tools Used
- **Text Editor**: Notepad
- **Prolog Interpreter**: SWI-Prolog
- **Flowcharts**: Microsoft Visio

---

## Challenges and Learnings
1. **Random Number Generator**: Implementing a functional random number generator in Prolog for the computer’s moves.
2. **Strategic Rules**: Designing and implementing offensive and defensive strategies.
3. **Team Collaboration**: Leveraging teamwork to divide tasks efficiently and enhance problem-solving capabilities.

---

## Future Improvements
- Add a graphical user interface (GUI).
- Include persistent storage for game statistics.
- Extend AI capabilities with machine learning.

---

## Team Members
- Pedro Enrique Sánchez Rodríguez
- Jorge Araujo Hernández
- César Daniel Ortega Castillejos

---

## References
1. Bratko, I. (2001). *Prolog Programming for Artificial Intelligence*. Addison-Wesley.
2. Clocksin, W. F., & Mellish, C. S. (2003). *Programming in Prolog*. Springer.
3. [SWI-Prolog Official Website](https://www.swi-prolog.org/).
4. [Visual Studio Code User Guide](https://code.visualstudio.com/docs).

---

## Conclusion
This project demonstrates the power of Prolog in developing logic-based applications. Through the implementation of this game, the team gained insights into logical programming, teamwork, and problem-solving, showcasing the potential of Prolog for artificial intelligence and game development.

## Acknowledgments
- Supervised by **Dr. Víctor Manuel Tlapa Carrera**.
- Developed as part of the "Logic" course, December 2024.
- Universidad Veracruzana
