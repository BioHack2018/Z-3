#!/usr/bin/env python

import argparse
import json

parser = argparse.ArgumentParser()
parser.add_argument('INPUT_JSON', type=str, help="path to input JSON")

args = parser.parse_args()
input_json_path = args.INPUT_JSON


input_json = json.load(open(input_json_path, "r"))

for key in input_json .keys():
    if input_json [key].__class__ not in [unicode, int]:
        input_json[key] = json.dumps(input_json[key])


print(json.dumps(input_json))