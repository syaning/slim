---
layout: post
title:  "devbox_remote_connection"
date: 2018-01-01
comments: true
categories: misc
---
Since my devbox will be sitting at home (which at the time of this writing, is still
in Niagara Falls), I would very much like to be able to remotely connect to it
using other devices such as my laptop. Essentially, what I want to do is to enable an
ssh connection from my laptop to my devbox when I am outside of my home network.
Besides ensuring that I have openSSH on my devbox and an ssh service running,
I needed to make the following config changes to my router:

1. Add static (internal) IP address for my devbox
2. Add a port forwarding rule to my router for SSH connections (i.e., port 22 by
    default)
3. Create a Dynamic DNS address (I used [Free DNS](http://freedns.afraid.org/)),
and subsequently configure my router so that it automatically updates the DDNS
server whenever my public IP address changes.

I learned how to perform these steps using the three "howtogeek" links provided below:

- [On Port Forwarding](https://www.howtogeek.com/66214/how-to-forward-ports-on-your-router/)
- [On Static (internal) IP](https://www.howtogeek.com/69612/how-to-set-up-static-dhcp-on-your-dd-wrt-router/)
- [On Setting up DDNS](https://www.howtogeek.com/66438/how-to-easily-access-your-home-network-from-anywhere-with-ddns/)

By enabling an ssh remote connection to my devbox, I am able to perform secure
file transfers via sftp, and can also interact with jupyter notebooks on my local
device via ssh tunnels (i.e., see steps listed in this  [coderwall.com post](https://coderwall.com/p/ohk6cg/remote-access-to-ipython-notebooks-via-ssh)).
