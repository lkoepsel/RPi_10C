# Raspberry Pi Setup for ATmega328P C Development

## 1. Use Pi Imager v2.0+ for creating Raspberry Pi OS Image
1. Open *Pi Imager*
2. Select your device -> Next
3. Select Raspberry Pi OS (other) -> Raspberry Pi OS Lite (64-bit) -> Next
4. Select Your Storage Device -> Next
5. Choose Hostname -> Next
6. Select:
    * Capital city:
    * Time zone:
    * Keyboard layout: us -> Next
7. Enter:
    * Username:
    * Password
    * Confirm password: -> Next
8. Select Secure Network:
    * SSID:
    * Password
    * Confirm password: -> Next
9. Enable SSH (**turn on**) -> Use password... -> Next
10. Enable Raspberry Pi Connect (**turn on**) -> Open Raspberry Pi Connect -> *confirm Authentication token: is filled in* -> Next
11. Write -> **I UNDERSTAND, ERASE AND WRITE** -> Enter System Password to write to storage device
12. Wait for the Write to finish
13. Remove *SD card/USB drive* and place in *Raspberry Pi*
14. Power up and wait for it to show up in the [Raspberry Pi Connect dashboard](https://connect.raspberrypi.com) . (*Normally takes about 90 seconds.*)

## 2. Connect via Raspberry Connect 

[Raspberry Pi Connect](https://connect.raspberrypi.com)

**NOTE:** In the instructions below, **Command/Control** means, in **macOS**, *press the `command` key* and in **Windows**, *press the `Control` key*.

This step will connect you to the Raspberry Pi using the command line in your browser window.

### 1. Copy and Paste:

```bash
sudo apt update && sudo apt upgrade -y &&
sudo apt-get install gcc-avr binutils-avr avr-libc gdb-avr avrdude git tio -y &&
git clone https://github.com/lkoepsel/RPi_10C.git
```

### 2. Obtain Uno device address

```bash
# Connect an Arduino Uno via USB cable and run:
tio -l
```
Under **Device** will be something like:
*/dev/ttyUSB0* or */dev/ttyACM0*. 

Copy this string, we'll refer to it as **DEVICE**.

``` bash
cd RPi_10C
nano env.make
# go to line 42, it will look like this: 'SERIAL = /dev/ttyACM0'
# confirm SERIAL equals DEVICE
# or overwrite it, with DEVICE
# you will end up with one of two variations below
SERIAL = /dev/ttyACM0
SERIAL = /dev/ttyUSB0
```
*Ctrl-S to save, Ctrl-X to exit*

### 3. Compile and load Uno with blink program

``` bash
cd examples/blink
make flash
```

**Confirm the Uno is blinking at a fast rate.**

### 4. Change delay and recompile/load program

```bash
nano main.c
# go to this line
    int delay_ms = 200;
# change the 200 to 2000
```
*Ctrl-S to save, Ctrl-X to exit*

```bash
make flash
```

**Confirm the Uno is blinking at a slow rate (every 2 seconds).**

This confirms everything is working properly.

### 5. Obtain the IP address to connect using VS Code

```bash
hostname -I
```

The first address will be a IP4 address similar to *10.0.0.223*, *192.168.1.5*, or *172.24.21.220*. This number will be referred to as **IP_ADDRESS** below.

## 3. Connect via VS Code Remote

Open *VS Code*

### 1. Install the required extensions

**Please install these extensions before continuing.**

```bash
ms-vscode-remote.remote-containers
ms-vscode-remote.remote-ssh
ms-vscode-remote.remote-ssh-edit
ms-vscode.cpptools
ms-vscode.cpptools-themes
ms-vscode.remote-explorer
```

### 2. Open a remote connection

In **VS Code:**

1. `Shift-command/Control-P`
2. Enter "*remo*" and click on **Remote-SSH: Connect to Host**
3. Enter *username@IP_ADDRESS*, where:
    * **username** is the username, you used on creating the Raspberry Pi OS image *from 1.7 above*
    * **IP_ADDRESS** is the IP_ADDRESS of your Raspberry Pi *from 2.5 above*
4. Click `Continue` on *Are you sure you want to continue?*
5. Enter password
6. Click on **Open Folder** -> **RPi_10C** -> **OK** and might need to click **Yes** to "*Trust...authors*"
7. Use the `Explorer` to open *examples/blink/main.c*
8. Change the *2000* on line 10, to *200* and `command/Control-s` to save the file
9. `Shift-command/Control-B` and click on *flash*

**Now the Uno will be blinking at its original fast rate.**

If you were successful in getting the Uno to blink both fast and slow, you are now ready to begin programming!

## Introduction
This repository is for an introductory course on the *C* language using the Arduino Uno, the *C* tool chain (avr-gcc, avrdude etc) and the [*AVR C Library*](https://github.com/lkoepsel/AVR_C). The content is for students who desire understanding *C* using an embedded microcontroller, in this case the *Arduino Uno R3*. This content uses the *avr* tool chain via command line (also called the *terminal*), it doesn't use the Arduino IDE GUI nor does it use the Arduino software framework.  

The directory, *templates*, contains the programs for labs. Each template folder contains multiple folders, each folder is a specific programming exercise. Within each exercise folder is a file called *main.c* and a file called *Makefile*. The file *main.c* is the template for the exercise and the *Makefile* is the required file using *make* to compile/link/load it to an UNO. Think of the *main.c* file as the Arduino IDE sketch and the *Makefile* as a command-line version of the *Arduino IDE*. The files in *Library* are similar to those found in the *Arduino framework library*.

## Dependencies
The approach this class follows is to use a standardized platform running the *C* tool chain. This removes the pain of having to maintain documentation and support for each of the major computing platforms, *macOS*, *Windows* and *Linux*. Instead, the platform will be an inexpensive *Raspberry Pi (RPi)* running *Raspberry Pi OS* with all of the required programs pre-installed.

In order to use this content you need to have the following installed on **your** computer or a computer you will be using in class:

* **VS Code** - Code editor, able to connect remotely to the  RPi
* **Terminal** - command line interface, *part of each operating system*:
    * *macOS* - called *Terminal*
    * *Windows* - its best to install [git for Windows](https://git-scm.com/install/windows) and use *git bash* installed as part of *git*

## Additional Sources of Information

* [Developing in C on the AVR ATmega328P](https://www.wellys.com/posts/courses_avr_c/) A series of web pages explaining in detail how to use specific aspects of the AVR C software framework.
* [AVR LibC](https://www.nongnu.org/avr-libc/) This library is the basis for the *C*language for the AVR. From GNU "*AVR Libc is a Free Software project whose goal is to provide a high quality C library for use with GCC on Atmel AVR microcontrollers.*" 

## Directories
**Note: *Library* and *examples* will be maintained identical to the [AVR_C versions](https://github.com/lkoepsel/AVR_C)**

* *examples* - contains code demonstrating how to use specific functions in the Library
* *Library* - *AVR C Library*, specific Arduino functions rewritten in *C* such as analogRead(), analogWrite(), digitalRead(), and pinMode()
* *templates* - template directories for each of the lab exercises. This directory must be duplicated to be used and called *dev*. **This directory is tracked by git and could be over-written in the next clone operation.**
* *dev* - the student's version of the templates directory, where the students will make changes to the lab files. **This directory is not tracked by git and won't be overwritten.**

## Usage
The recommended method to develop code using this repository is to use *VS Code* and your *terminal* program, side-by-side. This allows you to quickly and easily perform functions in either window.

To start:
1. Connect the *Uno* to the *Raspberry Pi* via the USB cable.
1. Put the Raspberry Pi power supply into an outlet and connect the USB-C cable from the power supply into the *USB C* connector on the *Raspberry Pi*.
1. The *Raspberry Pi* red light will come on and the green light will blink sporadically. Allow the *RPi* to run for a few minutes on initial boot.

### Terminal Steps

1. Open the Terminal application:
    * *Windows*, enter *Terminal* in the Windows search bar, click on either *Terminal* or *Command Prompt*
    * *macOS*, press *Cmd-Space* to pull up the search and enter *Terminal* then return
1. Make the *Terminal* window fill the right half of your monitor screen.
1. At the command prompt *(this is the name of prompt in Terminal)*, enter *ssh *pi10C@pi10C01.local*, using your *RPi* username and hostname. The *username* will always be *pi10C*, your hostname will be labeled on the *Raspberry Pi* and follow it with a *".local"*.
1. If this the first time, you have connected, you will need to respond "*yes*" to "*...continue connecting (yes/no/[fingerprint])?*".

For example, it will look similar to this:
```bash
ssh pi10C@pi10C01.local
The authenticity of host 'pi10c01.local (192.168.1.75)' can't be established.
ED25519 key fingerprint is SHA256:1xivnuODhnLQR0VzTC4JIlHzYzZ9/6zm9R/gjh6/TIo.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'pi10c.local' (ED25519) to the list of known hosts.
pi10C@pi10c01.local's password:
```
This will connect your computer to the *RPi* via a secure connection (*SSH*) and you will now be in the *command line interface (CLI)* of the *Raspberry Pi*.

Your screen now similar to this, with *VS Code* on the left and *Terminal* on the right:

![Desired Screen Setup](./docs/screen_setup.png)

## Confirm Working System

### Confirm in Terminal

To confirm everything is setup correctly, please perform the following steps in your *Terminal*:
```bash
# change directories to the Labs folder
cd Labs_10C_Class/
cd examples/blink
make complete
```

If everything is successful, you will see the end of the screen printout look like this:
```bash
avrdude: AVR device initialized and ready to accept instructions

Reading | ################################################## | 100% 0.00 s

avrdude: device signature = 0x1e950f (probably m328p)
avrdude: Note: flash memory has been specified, an erase cycle will be performed.
         To disable this feature, specify the -D option.
avrdude: erasing chip
avrdude: reading input file main.hex for flash
         with 1698 bytes in 1 section within [0, 0x6a1]
         using 14 pages and 94 pad bytes
avrdude: writing 1698 bytes flash ...

Writing |                                                    | 0% 0.00 s avrdude: padding flash [0x0680, 0x06ff]
Writing | ################################################## | 100% 0.36 s

avrdude: 1698 bytes of flash written

avrdude done.  Thank you.
```

And your Uno will be blinking quickly (2.5 times per second).

### Confirm in VS Code

Now switch to the *VS Code* window. 
1. Make sure the top icon in the left-side panel is selected to view your files. The second panel will show *EXPLORER* at the top.
1. Click on the ">" to the left of *examples*, to show the folders.
1. Click on the ">" to the left of the folder *blink* to show the files.
1. Click on *main.c* to show the file in the main *Editor* window
1. Go to line 10 and change *200* to *1000*
1. Press *Shift-Ctrl/CMD-b* and press *return* (*compile and upload code (upload): flash*)
1. After a small delay to compile and upload the code, the *Uno* will be blinking much slower (once per second).

**If both tests worked, you are now ready to code!!!**


