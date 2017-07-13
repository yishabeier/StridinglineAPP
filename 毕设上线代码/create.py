#!/usr/bin/env python
# -*- coding: utf-8 -*- 

import sys
import os
import subprocess

if len(sys.argv) != 2:
    print 'Please Enter ProjectName'
    sys.exit()

for root, dirs, files in os.walk('.'):
    for filename in files:
        if root.find("Pods") == -1 and root.find(".git") == -1:
            filepath = os.path.join(root, filename)
            if filepath.find('run.py') != -1:
                continue

            content = open(filepath).read()

            if 'MyHealthModule' in content:
                content = content.replace('MyHealthModule', sys.argv[1])
                with open(filepath, 'w') as f:
                    f.write(content)

            if filename.find('MyHealthModule') != -1:
                newfilename = filename.replace("MyHealthModule", sys.argv[1])
                newfilepath = os.path.join(root, newfilename)
                os.system("mv %s %s" % (filepath, newfilepath))

for root, dirs, files in os.walk('.'):
    if root.find("Pods") == -1 and root.find(".git") == -1:
        for directory in dirs:
            if directory.find('MyHealthModule') != -1:
                newdir = directory.replace("MyHealthModule", sys.argv[1])
                os.system("mv %s %s" % (directory, newdir))

os.system('git add -A && git commit -am "init" -q')
os.system('git remote rm origin')
os.system('echo "\nPods\nPodfile.lock" >> .gitignore')
os.system('git commit -am "update .gitignore" > /dev/null')
os.system('git rm --cached -r Pods > /dev/null')
os.system('git commit -am "remove Pods from repo" > /dev/null')
os.system('git rm --cached Podfile.lock > /dev/null')
os.system('git commit -am "remove Podfile.lock"')
print '\033[92mDone! now you can open %s.xcworkspace\033[0m' % sys.argv[1]
