# Quake Log Parser

This is a parser for logs of the game Quase 3 Arena generated by the server. The logs include new player connections, kills and commands for the start and end of games.

This project was done as a take-home exercise. 


## Installation

The project include only 3 gems: activesupport, rake and rspec.

To get started run:

```
./bundle install
```

## Reports

To run the main report of grouped deaths by player, run:

```
./rake kill_reports
```

To run the report of grouped deaths by cause, run:

```
./rake kill_reports_by_cause
```

## Specs

To run the tests, run:

```
./rspec
```