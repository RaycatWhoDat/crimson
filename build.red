Red []

commands: [install run-tests generate-reference]
do %crimson.red
foreach command commands [
    crimson/internal/:command
]