# WhizKidz - Fun and Educational Games for Kids

WhizKidz is an interactive iOS mobile application designed to support early childhood development through fun, educational games. The app helps children learn the alphabet, basic mathematics, colors, shapes, and hygiene habits, while also allowing parents to monitor their child's weekly progress through a dedicated statistics dashboard.

## What Does "WhizKidz" Mean?

"WhizKidz" combines the concept of "whiz," referring to someone who excels or learns quickly, with "kidz," a playful variation of the word "kids." This name reflects the app’s goal of making learning fast, fun, and effective for young children.

## Features

### 1. **Alphabet Learning Game**
   - This game helps children learn the alphabet by matching letters with images of objects whose names start with the given letter. It encourages both visual and auditory learning to enhance memory retention and letter recognition.
   - Each successful round helps the working bee produce honey.

### 2. **Mathematics Learning Game**
   - This game provides a series of simple math questions with four answer options, only one of which is correct. 
   - Each correct answer contributes to the growth of a plant, making learning more interactive and rewarding.

### 3. **Color Learning Game**
   - This is a memory game designed to help children recognize and remember colors. It challenges their memory skills in a fun and colorful way, reinforcing color identification.

### 4. **Find the Word Game**
   - In this game, children are presented with jumbled letters and must rearrange them to form a correct word. It helps develop vocabulary, spelling, and logical thinking. 
   - Each successfully completed word moves the butterfly closer to the flower.

### 5. **Learn Shapes Game**
   - Geometric shapes fall from the top of the screen, and the child receives a prompt instructing which shape to tap. If the child taps the wrong shape, the game ends. This game encourages quick recognition of shapes, improves hand-eye coordination, and teaches focused attention.

### 6. **Learn About Hygiene Game**
   - This is a quiz-based game that teaches children about proper hygiene habits. Through a series of simple, multiple-choice questions (e.g., "When should you wash your hands?"), children learn important health practices in an interactive and age-appropriate way.
   - With each correct answer, the child helps the tooth heal.
   - To reinforce correct answers and improve auditory learning, the game uses AVSpeechSynthesizer to provide immediate spoken feedback after each correct response. This adds a layer of encouragement and supports language development by clearly pronouncing hygiene-related terms.
   - This game also has a feature where the child can turn on music for brushing their teeth so they brush their teeth long enough and properly.
   
### **User Profile & Progression**
    - Each child has their own user profile where their username, avatar and age are stored.
    - The app uses a level system, where each successfully completed game session contributes to leveling up.
    - Upon leveling up, children unlock new badges or "gems", encouraging contiuned engagement and motivation.
    - Games get harder with a certain level.
    
### **Parent Dashboard & Statistics**
    - A dedicated parent screen provides insight into the child's weekly progress. 
    - Statistics include comparison of current vs. previous week's performance, automatically generated feedback with motivational or advisory comments, and average number of scores per day.

### **Authentication & Security**
    - The app includes a registration and login system.
   
## Technologies Used

- **SwiftUI**: For building the user interface in a declarative manner.
- **Swift**: For implementing the app’s logic and functionality.
- **GRDB**: For local data persistance and statistics tracking
- **Keychain**: For storing sensitive data
- **AVSpeechSynthesizer**: For improving auditory learning 
- **Xcode**: The integrated development environment used for building and testing the app.

## Installation

To get started with the WhizKidz app on your local machine, follow these steps:

### Prerequisites

Before you begin, make sure you have the following installed:
- [Xcode](https://developer.apple.com/xcode/) (version 14 or higher) on macOS
- A macOS device to run the application

### Steps

1. **Clone the repository**
    First, clone this repository to your local machine:

    git clone https://github.com/tinajuresko/whizKidz.git cd whizKidz

2. **Open the project in Xcode** 
    Navigate to the project folder and open the .xcodeproj file.

    open whizKidz.xcodeproj

3. **Run the app **
    Select the target device or simulator in Xcode and click the Run button (Cmd + R) to build and run the app on your device or simulator.

4. **Enjoy the App once the app is running!**

