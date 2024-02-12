# Rubiks Cube
 
Zauberwürfel lösen mit Clingo (Answer Set Programming) 

## Primäre Files

- _generator.lp_: Würfel zusammenstellen aus den 20 Steinen (fixe Zentren)
- _cube_rules.lp_: Rotationen raten und umsetzen
- _examples.lp_: Beispielkonfigurationen zum austesten; wird nicht aufgerufen
- _instance.lp_: zu lösende Konfiguration eingeben oder generierte Konfiguration speichern; wird von solve_instance aufgerufen

## Hilfsfiles

- _diy.lp_: gelöste Startkonfiguration; Zwischenspeicher für vorgegebene Rotationen 
- _specifics.lp_ Zwischenspeicher für Zeitvorgabe beim Lösen

## Funktionen

### Zauberwürfel lösen 
- beliebige Konfiguration in _instance.lp_ in Prädikatform eingeben (Beispiele in _examples.lp_ verfügbar)
```python
paintMid(position = t/b/l/r, face, color, time = 0).      
paintCorner(row = t/b, column = l/r, face, color, time = 0).
```
- Solver in main.py erstellen und aufrufen **[1]**
```python
solver = F.create_solveinstance()
solver()
```
- Lösungsvorschrift als Abfolge von Rotationen _(face,timestep)_ im Uhrzeigersinn wird in der Konsole ausgegeben
- default Lösezeit _(slvtime=60)_ reicht für jede Konfiguration
- Suchraum exponentiell (6^60 Möglichkeiten), gewöhnliche Rechenleistung reicht nicht aus

### Schnell lösbare Konfiguration generieren 
- builder mit Zeitvorgabe in main.py aufrufen
```python
F.build_solvable_cube(time)
```
- generiert und visualisiert Konfiguration, die mit _=time_ Rotationen 
(im Uhrzeigersinn) lösbar ist
- speichert Konfiguration in _instance.lp_, die nun mit Solver (s. oben) gelöst werden kann **[1][2]**
- gibt die Lösungsvorschrift als Abfolge von Rotationen "_rotateClockwise(face,time)_" in Konsole aus
- Nutzer kann die Lösungsvorschrift rückwärts ablaufen, um die generierte Konfiguration in Echt nachzubauen

### Konfiguration nach Vorschrift generieren
- gewünschte Abfolge von Rotationen als Array von Tupeln _(Seite = 1..6, Richtung = +/- 1)_ angeben
- Redundanz (Loops) ist nicht erlaubt (genaue Vorgabe s. _cube_rules.lp_, Zeile 18)

gültiges Beispiel:
```python
moves = [(1,1),(3,-1),(2,-1),(4,-1),(5,1),(1,1)]
```
ungültiges Beispiel:
```python
moves = [(2,-1),(1,1),(1,1),(1,1),(1,1)]
```
- Ergebnis nach Anwendung dieser Abfolge auf Startkonfiguration (default: gelöster Würfel) aus _diy.lp_ berechnen
```python
F.diy_cube(moves)
```
- resultierende Konfiguration wird visualisiert und in _instance.lp_ gespeichert
- Ergebnis kann nun mit Solver (s. oben) wieder gelöst werden **[1][3]** 

### Kodierung
__Seitenflächen__: nach Farbe des Zentrums: 1 = weiß | 2 = rot | 3 = blau | 4 = gelb | 5 = orange | 6 = grün

__Ausrichtung des Würfels__: weißes Zentrum zeigt nach oben, rotes Zentrum zeigt nach vorn; Ausrichtung ist unveränderlich

__Farben__: analog zur Nummerierung der Seitenflächen


___
___


**[1]** Um die Rechenzeit in Grenzen zu halten, sollte die Lösezeit (default: _slvtime=60_) eingeschränkt werden.

**[2]** Hier genügt natürlich _slvtime=time_.

**[3]** Rechenzeit kann an der Abfolge der Rotationen abgelesen werden: 
- Rotation im Uhrzeigersinn (_Richtung = 1_) rückgängig zu machen kostet 3 Zeitschritte.
- Rotation gegen den Uhrzeigersinn (_Richtung = -1_) rückgängig zu machen kostet 1 Zeitschritt.