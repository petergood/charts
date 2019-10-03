#!/usr/bin/env python3

import yaml

from graphviz import Digraph

dot = Digraph(comment='The Round Table')

def traverse(file,pretty):
  try: 
    with open("{}/requirements.yaml".format(file)) as stream:
        try:
            deps = yaml.safe_load(stream)
            for dep in deps['dependencies']:
              print(dep)
              if 'alias' in dep.keys():
                dep_pretty="{} <<{}>>".format(dep['alias'],dep['name'])
              else:
                dep_pretty=dep['name']
              if dep['repository'][0:4] == "file":
                dot.edge(pretty,dep_pretty)
                traverse(dep['name'],dep_pretty)
              else:
                dot.edge(pretty,"{} {}".format(dep_pretty,dep['repository']))
        except yaml.YAMLError as exc:
            print(exc)
  except FileNotFoundError as exc:
    pass #print(exc)

if __name__ == "__main__":
    traverse("cross-support-job-3p","cross-support-job-3p")
    print(dot.source)