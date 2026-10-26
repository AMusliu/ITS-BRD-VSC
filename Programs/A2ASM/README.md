Anw01 = r0 erhält Adresse: 0x2000000c (VariableA)
Anw02 = r2 erhält Wert 0xef
Anw03 = r3 erhält Wert 0xbe
Anw04 = r2 erhält Wert 0xef00; Verschiebung um 8 Bit nach links
Anw05 = r2 erhält Wert 0xefbe; Kombination von R2 und R3
Anw06 = Wert 0xef (links) und 0xbe (rechts) wechseln Seiten; Nun Anordnung "beef"; Zuvor "efbe"

Probleme/Schwierigkeiten:
- Unterscheidung von "ldr" und "ldrb"