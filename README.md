# Telegram Bot Project

This project is a Telegram bot built using the Dart programming language and the `teledart` package. The bot can handle daily reports, late daily reports, and manage project tasks through user interaction in Telegram.

## Table of Contents

1. [Features](#features)
2. [Requirements](#requirements)
3. [Installation](#installation)
4. [Running the Project](#running-the-project)
5. [Creating a Bot with BotFather](#creating-a-bot-with-botfather)
6. [Usage](#usage)
7. [License](#license)

## Features

- Handles `/start` command to greet users and provide options for daily and late daily reports.
- Manages project names, dates, and tasks.
- Asks for user input and stores the provided information.
- Shows typing status before sending messages.
- Provides options to cancel current operations.

## Requirements

- Dart SDK
- Telegram Bot API token

## Installation

### Step 1: Clone the repository

```bash
git clone https://github.com/BadrulFlut/botquaketele.git
cd botquaketele
```

### Step 2: Install Dart and necessary packages

- Install Dart SDK: Follow the instructions on the Dart official website.
- Install dependencies by running:

```bash
dart pub get
```

### Step 3: Configure your Bot Token

Replace YOUR_BOT_TOKEN_HERE with your actual Telegram bot token in the teleInit method:

```dart
var BOT_TOKEN = 'YOUR_BOT_TOKEN_HERE';
```

### Running the Project

To run the bot, use the following command:

```bash
dart run path/to/your/main.dart
```

Ensure that the path points to your Dart file containing the bot's main code (e.g., lib/main.dart).

### Creating a Bot with BotFather

- Start a chat with BotFather: Open Telegram and search for [@BotFather](https://t.me/botfather).
- Create a new bot:
  - Send /newbot to BotFather.
  - Follow the instructions to set up the bot's name and username.
  - BotFather will provide a token. Copy this token.
- Set the token in your project: Replace the placeholder YOUR_BOT_TOKEN_HERE with the token you received from BotFather.

Simply follow the [instructions](https://core.telegram.org/bots#6-botfather).

### Usage

After running the project, your bot will start listening for commands and messages in Telegram. Below are the main functionalities:

- /start: Greets the user and displays options for daily and late daily reports.
- /dailyreport: Prompts the user to enter the project name and tasks.
- /latedailyreport: Prompts the user to enter the late date in the format dd-mm-yyyy.
- /cancel: Cancels the current operation.

### Example Flow

- Start Command:
  - User sends /start.
  - Bot replies with options for "Daily Report" and "Late Daily Report".
- Daily Report:
  - User selects "Daily Report".
  - Bot prompts for the project name.
  - User enters the project name.
  - Bot prompts for the tasks with specific format instructions.
  - User enters tasks.
  - Bot asks if there are more tasks.
  - User replies "Yes" or "No".
  - If "Yes", the bot repeats the task entry process.
  - If "No", the bot summarizes and ends the interaction.
- Late Daily Report:
  - User selects "Late Daily Report".
  - Bot prompts for the late date in the format dd-mm-yyyy.
  - User enters the date.
  - Bot continues as per the daily report flow.
