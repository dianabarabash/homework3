Hometask #3 (26/09)
===================
Guide
-----
- Start instance
```bash
./run-and-provision.sh
```

- Login to the EC2 instance
```bash
ssh -i ../diana-key-pair.pem ec2-user@ip-address-ec2-instance
```

- Watch the log file updating
```bash
tail -f /var/log/sysinfo
```
