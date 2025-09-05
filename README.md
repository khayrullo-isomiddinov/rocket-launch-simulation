# Rocket Launch Simulation  

*A concurrent rocket simulation written in **Ada**, modeling propellant consumption, engine tasks, and stage control.*  

---

## Overview  
This project simulates a two–stage rocket launch (similar in spirit to **Super Heavy + Starship**) using **Ada tasks, protected types, and concurrency primitives**.  

- Each **engine** is modeled as a task that can be started and shut down.  
- A **propellant tank** is represented as a protected object, tracking oxidizer and fuel consumption over time.  
- A **stage** coordinates multiple engines, supporting startup and MECO (Main Engine Cut Off).  
- Output is logged through a synchronized printer to avoid interleaved console messages.  

This demonstrates Ada’s strengths in **safety-critical, concurrent, and real-time software** — the kind of software used in aerospace and embedded systems.  

---

## Features
- Concurrent tasks for rocket engines  
- Protected types for propellant tank state  
- Real-time propellant drain using wall-clock deltas  
- Failure generator for random fault simulation  
- Clear console telemetry (fuel/oxidizer percentage, engine start/shutdown events)  

I made this project to practice my skills in ADA's concurrency concepts. Let me know if you're looking to learn ADA on harryshady131@gmail.com
---


---

## ⚙️ Build & Run

### Install GNAT and gprbuild
On Debian/Ubuntu:
```bash
sudo apt-get update
sudo apt-get install -y gnat gprbuild
gprbuild -p -P project.gpr
./bin/main
```

## Sample output:

---

Super Heavy engine 1 is starting
Super Heavy engine 2 is starting
...
Starship engine 1 is starting
Super Heavy Booster: Fuel percentage:  97.85
Super Heavy Booster: Oxidizer percentage:  96.32
Starship: Fuel percentage:  99.42
Starship: Oxidizer percentage:  98.77
...
Super Heavy engine 2 is shutting off
Starship engine 1 is shutting off

**NASA** — if you're seeing this, email me: **harryshady131@gmail.com**



