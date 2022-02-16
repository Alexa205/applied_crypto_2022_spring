#!/usr/bin/env python3
import sys
import json
import os

#obj = """{
#  "problem 1" : ["af0b21", "deadbeeffeedface"],
#  "problem 2" : ["68656c6c6f"],
#  "problem 3" : ["48454C4C4F"],
#  "problem 4" : [21982993, 329823198, 200]
#}"""

with open('example-input.json', 'r') as openfile:
    problems = json.load(openfile)

#problems = json.loads(obj)
solutions = {}

for problem in problems:
    if problem == "problem 1":
        problem_data = problems[problem]
        solution_data = []
        for data in problem_data:
            solution_data.append(data.upper())
        solutions[problem] = solution_data
    elif problem == "problem 2":
        problem_data = problems[problem]
        solution_data = []
        for data in problem_data:
            solution_data.append(bytearray.fromhex(data).decode())
        solutions[problem] = solution_data
    elif problem == "problem 3":
        problem_data = problems[problem]
        solution_bytearray = None
        solution_data = []
        for data in problem_data:
            solution_bytearray = bytearray.fromhex(data)
            blank_byte = 0x20
            for i in range(len(solution_bytearray)):
                solution_bytearray[i] = (solution_bytearray[i] + blank_byte + i) % 256
            solution_data.append(solution_bytearray.hex().upper())
        solutions[problem] = solution_data
    elif problem == "problem 4":
        problem_data = problems[problem]
        solution_data = []
        for data in problem_data:
            sol_data = os.urandom(64)
            sol_data = int.from_bytes(sol_data, sys.byteorder) % data
            solution_data.append(sol_data)
        solutions[problem] = solution_data

#print(json.dumps(solutions))
json_obj = json.dumps(solutions)
with open("example-output.json", "w") as outfile:
    outfile.write(json_obj)
