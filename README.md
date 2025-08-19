# mrtg
MRTG scripts to monitor my home network

## Getting started

Edit `config.txt` with the hosts you want to check.

Actions can be `count` or `latency`

```bash
$ sudo ./install.sh
$ ./config.sh
```
If you want to use another config file...

```bash
$ ./config.sh config_do.txt
```