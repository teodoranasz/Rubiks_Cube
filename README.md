# Rubiks Cube
 
Zauberwürfel lösen mit Clingo (Answer Set Programming) 

## Primäre Files

- _generator.lp_: Würfel zusammenstellen aus den 20 Steinen (fixe Zentren)
- _cube_rules.lp_: Rotationen raten und umsetzen
- _examples.lp_: Beispielkonfigurationen zum austesten; wird nicht aufgerufen

## Hilfsfiles

- _instance.lp_: generierte Konfiguration speichern; wird von solve_instance aufgerufen
- _diy.lp_: gelöste Startkonfiguration; Zwischenspeicher für vorgegebene Rotationen 
- _specifics.lp_ Zwischenspeicher für Zeitvorgabe beim Lösen

## Funktionen

### Zauberwürfel lösen 
- beliebige Konfiguration in _instance.lp_ in Prädikatform eingeben
```python
paintMid(position = t/b/l/r, face, color, time = 0).      
paintCorner(row = t/b, column = l/r, face, color, time = 0).
```
- solver in main.py erstellen und aufrufen
```python
solver = F.create_solveinstance()
solver()
```
- default Lösezeit (60) reicht für jede Konfiguration
- Suchraum exponentiell (6^60 Möglichkeiten), gewöhnliche Rechenleistung reicht nicht aus

### Schnell lösbare Konfiguration generieren 
- builder mit Zeitvorgabe in main.py aufrufen
```python
F.build_solvable_cube(time)
```
- generiert und visualisiert Konfiguration, die mit _=time_ Rotationen 
(im Uhrzeigersinn) lösbar ist
- speichert Konfiguration in _instance.lp_, kann dann mit Solver (s. oben) gelöst werden **[1][2]**
- gibt die Lösungsvorschrift als Abfolge von Rotationen "_rotateClockwise(face,time)_" in Konsole aus
- Nutzer kann die Lösungsvorschrift rückwärts ablaufen, um die generierte Konfiguration in Echt nachzubauen

### Konfiguration nach Vorschrift generieren
- gewünschte Abfolge von Rotationen als Array von Tupeln (Seite = 1..6, Richtung = +/- 1) angeben, zB:
```python
moves = [(1,1),(3,-1),(2,-1),(4,-1),(5,1),(1,1)]
```
- Ergebnis nach Anwendung dieser Abfolge auf Startkonfiguration (default: gelöster Würfel) berechnen
```python
F.diy_cube(moves)
```
- resultierende Konfiguration wird visualisiert und in _instance.lp_ gespeichert
- Ergebnis kann nun mit Solver (s. oben) wieder gelöst werden **[1][3]** 

### Kodierung
__Seitenflächen__: nach Farbe des Zentrums: 1 = weiß | 2 = rot | 

__Orientierung des Würfels__: ; unveränderlich

__Farben__: analog zur Nummerierung der Seitenflächen


___
___


**[1]** Um Rechenzeit in Grenzen zu halten, sollte die Lösezeit (default: _slvtime=60_) eingeschränkt werden

**[2]** Hier genügt natürlich _slvtime=time_.

**[3]** Rechenzeit kann an der Abfolge der Rotationen abgelesen werden: 
- Rotation im Uhrzeigersinn (_Richtung = 1_) rückgängig zu machen kostet 3 Zeitschritte 
- Rotation gegen den Uhrzeigersinn (_Richtung = -1_) rückgängig zu machen kostet 1 Zeitschritt.