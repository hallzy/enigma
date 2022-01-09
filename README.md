# Enigma

## Build

Build with `make`. That is it.

## Usage

Configure your Enigma machine in the configuration.txt file.

Right now, the order of the lines matters, and so does the descriptive text at
the beginning of each line, so don't change those. The values after the `:` can
be changed freely, so long as the rotors and reflectors you choose are defined
in `Rotors/WWII.hs`.

The real enigma only had 3 or 4 rotors depending on the model, and it came with
10 plugs for the plug board. I do not do checks for this, so you can add as many
rotors and plugs as you want, so long as there are the same number of ring
settings and starting positions as there are rotors, and as long as you don't
connect duplicate letters with the plug board (ie, this enigma supports a
plugboard with the number of plugs ranging from 0 to 13, since if 13 plugs are
used then all the letters are swapped).

Ring settings can be either numeric and alphabetic (For example, `B` is allowed,
and so is `2` or `02`. All of which mean the same thing).

Once Configured, just run the binary:

```bash
$ ./enigma 'The message you would like to encrypt.'
```

(In order to decrypt with Enigma, you just need to setup Enigma with the same
configuration as when the original text was encrypted, and provide the encrypted
text to the enigma binary).

Running this will either give you an error message if there was some problem
with your configuration, or it will produce information that looks like this:

```
Reflector:     "CTHIN"
Rotors:        ["GAMMA","VIII","V","VI"]
Ring Settings: [8,13,23,15] aka ["H","M","W","O"]
Start Pos:     [10,17,12,1] aka ["J","Q","L","A"]
Plug Board:    ["BQ","CR","DI","EJ","KW","MT","OS","PX","UZ","GH"]

Input:  THEM ESSA GEYO UWOU LDLI KETO ENCR YPTX
Output: FKAT CMMV ICRY LQWB MTSR TXGC UMXT EJEW
```

It gives you a summary of your settings as parsed by the program (The ring
settings and starting position are provided a characters and numbers for
convenience).

The input is broken into groups of 4 and so is the output. This is how text was
written out with Enigma before and after encrypting/decrypting, so I do the
same.

Enigma is not able to encrypt non alpha characters, so spaces, numbers, and
special characters and punctuation are all removed except for the period (`.`),
which is swapped for an `X` on the input automatically, as that was the standard
practice during WWII.

## Research

### References

- [How did the Enigma Machine Work?](https://www.youtube.com/watch?v=ybkkiGtJmkM)
YouTube video by "Jared Owen"

### How it Works

- Hit a key
- Electricity follows this path:
    - Plugboard
    - Far right rotor
    - Next rotor to the left etc until it goes through the last rotor
    - Reflector
    - Back through the rotors in the reverse order
    - Plugboard
    - Light bulb

When electricity goes to the rotors, it travels through all the rotors that are
there, then through the reflector, which is sort of another rotor that turns the
electricity back through the rotors it just came through. The reflector can also
change the letters.

Every time a key is pressed the right most rotor turns, going up numerically.

The next rotor to the left will turn once the rotor to the right of it reaches
its notch (notches are at different positions for each rotor).

Because of how the mechanism works, if a notch is in the right place for a rotor
to turn, it will also rotate the rotor to the right of it. You never notice this
with the 2 right most rotors because the right most rotor always rotates once
anyways, but sometimes it can cause the other rotors to behave this way (In this
scnenario, a rotor will never rotate more than once per key press though).

Some rotors had 2 notches though. So some rotors would cause the rotor next to
it to rotate twice in 26 movements.

Some rotors have 0 notches. These are the `Beta` and `Gamma` rotors which were
used by the German Navy who used 4 rotor Enigmas. The `Beta` and `Gamma` rotors
were meant to be used as the far left rotor only, so the notches weren't needed
(this rule is not enforced in my enigma, you can but the beta and gamma rotors
wherever you want).

The 4 rotor system also was only able to use the `Thin` reflectors, to make room
for the extra rotor. `BThin` is thinner than the `B` reflector, to make room for
the rotor, but the wiring of `BThin` is also totally different from reflector
`B`. Again, this is not enforced by my engima. You can use the thin reflectors
with any amount of rotors.

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
