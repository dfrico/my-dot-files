Write colored bee ascii to /etc/sudo_lecture
`$ sudo bash generate_bee.sh`

Always show lecture
`$ sudo visudo`
Append following:
```
Defaults lecture = always
Defaults lecture_file = /etc/sudo_lecture
```

