Hometask #3 (26/09)
===================

Vagrant task
------------
1. create repo hometask3
2. create AWS VM using ami-01bc990364452ab3e (AWS Linux) with aws-cli (like a hometask2)
3. configure cron job (/etc/crontab/…) which write every minute on workdays (Mon-Fri) next information to log file `/var/log/sysinfo`:
 - current system time and date;   (use date command)
 - system uptime, logged-in users and CPU load;  (use w command)
 - memory usage and disk space usage;  (use free -m and df -h )
 - list of programs used open TCP ports; (ss -tulpn)
 - check connection to ukr.net host; (ping -c1 -w1 ukr.net ) 
 - list of SUID programs in local system. (find  see options in man) 

Tips 
-----
- best way is to create script /root/sysinfo.sh ran by cron job. Do not forget make your script executable (use chmod).
- AWS Linux does not contain cron daemon by default. You need to install it (the name of package is cronie)

Implementation notes
--------------------

Vagrant AWS plugin has a bug as follows:
```bash
$ vagrant -v
Vagrant 2.4.0

$ vagrant plugin install vagrant-aws
Installing the 'vagrant-aws' plugin. This can take a few minutes...
/opt/vagrant/embedded/lib/ruby/3.1.0/rubygems/specification.rb:2278:in `check_version_conflict': can't activate json-2.7.1, already activated json-2.6.1 (Gem::LoadError)
	from /opt/vagrant/embedded/lib/ruby/3.1.0/rubygems/specification.rb:1415:in `activate'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/lib/vagrant/bundler.rb:759:in `block in activate_solution'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/lib/vagrant/bundler.rb:756:in `each'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/lib/vagrant/bundler.rb:756:in `activate_solution'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/lib/vagrant/bundler.rb:596:in `internal_install'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/lib/vagrant/bundler.rb:358:in `install'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/lib/vagrant/plugin/manager.rb:141:in `block in install_plugin'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/lib/vagrant/plugin/manager.rb:151:in `install_plugin'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/plugins/commands/plugin/action/install_gem.rb:33:in `call'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/lib/vagrant/action/warden.rb:38:in `call'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/lib/vagrant/action/builder.rb:183:in `call'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/lib/vagrant/action/runner.rb:104:in `block in run'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/lib/vagrant/util/busy.rb:22:in `busy'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/lib/vagrant/action/runner.rb:104:in `run'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/plugins/commands/plugin/command/base.rb:17:in `action'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/plugins/commands/plugin/command/install.rb:73:in `block in execute'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/plugins/commands/plugin/command/install.rb:72:in `each'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/plugins/commands/plugin/command/install.rb:72:in `execute'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/plugins/commands/plugin/command/root.rb:69:in `execute'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/lib/vagrant/cli.rb:67:in `execute'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/lib/vagrant/environment.rb:319:in `cli'
	from /opt/vagrant/embedded/gems/gems/vagrant-2.4.0/bin/vagrant:248:in `<main>'
```

Based on that fact, the task has been done using AWS CLI and user-data script.

Guide
-----

- Login to the EC2 instance
```bash
ssh -i ../diana-key-pair.pem ec2-user@ip-address-ec2-instance
```

- Watch the log file updating
```bash
tail -f /var/log/sysinfo
```
