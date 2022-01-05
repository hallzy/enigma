# Enigma

This is a work in progress, but I would like to make a program that emulates the
workings of the Enigma Machine with some preset rotor configurations that were
actually used.

I haven't decided on a language yet, but below is my research on how the enigma
works so that I can build it.

Ideally, I would like to have an interactive mode, where it encrypts/decrypts in
real time like the real thing, but also have a way to just feed the program text
and have it auto encrypt/decrypt the whole thing at once.

## Research

### References

- [How did the Enigma Machine Work?](https://www.youtube.com/watch?v=ybkkiGtJmkM)
YouTube video by "Jared Owen"

### How it Works

- Hit a key
- Electricity flows to:
    - The plugboard
    - The rotors
    - The plugboard
    - Lightbulb

When electricity goes to the rotors, it travels through all the rotors that are
there, then through the reflector, which is sort of another rotor that turns the
electricity back through the rotors it just came through. The reflector also
changes the letter.

Every time a key is pressed the right most rotor turns, going up numerically. The
other rotors only turn once the rotor to the right of it has rotated to a
specific point, which is different for each rotor. If that point is at 26, then
when the rotor goes from 26 to a 1, the rotor to the left will increase by 1.
The next time that rotor will increase is when the first rotor is back at 26
again.

Some rotors had 2 notches though. So some rotors would cause the rotor next to
it to rotate twice in 26 movements.

[Turnover positions](https://en.wikipedia.org/wiki/Enigma_rotor_details#Turnover_notch_positions)

### Setting Up the Enigma

Rotor Order - The order that the rotors are slotted into the enigma, and which
rotors they are.

Ring Setting - Allows you to change which wires in the rotor correspond to which
number on the rotor (Not all rotors allowed you to do this, in which case this
is the same as the starting position).

Starting Position - The starting position of each rotor when you start to
encrypt/decrypt a message

Plug board configuration at the front

And on later models, the reflector was configurable as well.

### How it was used

Rotor Order, Ring Setting, Plug Board Configuration, and the Reflector
Configuration was written down in a codebook, and changed every day (except the
reflector configurations which changed every 8 days)

The starting position was chosen at random by the operator encrypting the
message.

Say WZA was the starting position (Start positions are numeric, so use the
numeric form of these letters in the alphabet).

Now the operator needs to choose a message key. Let's say SXT.

The operator sets the starting position of WZA and encrypts the message key
SXT. Let's say the encrypted key is UHL.

Now the operator sets SXT as the start position and proceeds to type out the
message they want to encrypt.

The start position of WZA is transmitted, the encrypted message key (UHL) is
also transmitted, and then the message itself is transmitted.

The receiver gets the WZA start position, and enters UHL which decrypts to our
key SXT. The receiver then sets the starting position to SXT and enters the
cyphertext to get the plaintext message.

### Rotor Wiring

[See this chart](https://en.wikipedia.org/wiki/Enigma_rotor_details#Rotor_wiring_tables)
for rotor wirings. There were a number of rotors used.

It seems that the common wirings are the I, II, III, IV, and V rotors, so I will
use those here.
