From: Sebastian Haas <dev@sebastianhaas.info>
Subject: [ANNOUNCEMENT] CAN restbus-simulation the Node-way
Date: Mon, 02 Jan 2012 13:59:36 +0100
Message-ID: <4F01AA38.7010203@sebastianhaas.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtprelay05.ispgateway.de ([80.67.31.97]:49286 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab2ABM7l (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Jan 2012 07:59:41 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Linux-can Mailing List <linux-can@vger.kernel.org>
Cc: socketcan-users@lists.berlios.de

Hello everybody,

I've recently started to work on restbus-simulation based on SocketCAN. 
Since it is now somewhat useable I decided to announce it here to find 
some advise and helpers to proceed even faster.

The preliminary name is RestCAN. It basically consists of a set of Node 
modules (nodejs.org), which enable the user to develop the behaviour of 
CAN node within a "simple to write" Javascript.

Background
==========
The idea was born because of my personal need to test CAN nodes by 
simulating certain parts of a network. And I also wanted to have a 
simple to use sandbox to implement and test new protocols or control 
algorithms.

I decided to use Javascript because this language is subject of current 
optimization efforts (Webkit, V8, SpiderMonkey). To provide and powerful 
development environment I switched to use NodeJS instead of using V8 
from scratch. NodeJS is a asynchronous event oriented Javascript 
environment with tons of third party modules (NPM) and a good subset of 
builtin utilities (File I/O, TCP/UDP, HTTP, IPC, ...).

Current status
==============
The current status is a Node module to work with raw channels, so a user 
can write a script to send and receive raw CAN messages.

Example
=======
	var can = require('../build/Release/can');
	var channel = can.createRawChannel("vcan0");

	// Start communication
	channel.start();

	// Send a CAN message in EFF
	channel.send({ id: 12, ext: true, data: [ 1,2,3,4,5,6,7,8 ] });

	// Register a listener for incoming messages
	channel.addListener("onMessage",
		function(msg) {
			console.log("Message received");
			console.log(msg);
		});

Planned features
================
Next step is to support specifing Rx filters and support BCM and ISOTP 
channels.

To make it a real restbus-simulation I plan to implement a CAN database 
service to receive and decode signals within CAN messages and also to 
generate CAN messages out of the CAN database.

Performance
===========
A last note about performance, I know some people may have critic 
thoughts one performance if they hear Javascript. I made some short test 
here and I was able to receive roughly 9k msgs/s (cangen vcan0 -g 0 -i) 
within a VirtualBox VM with a Core i5 running at 2.8GHz. Another script 
was able to generate 7k msgs/s on the same machine. I'm okay with this 
results so far since nothing is optimized yet. Since Node has already 
proved its performance in certain setups I'm quite confident we can gain 
more performance.

Help
====
You see it is a lot of stuff to do here, so any help is really 
appreciated. Due to lack of real CAN hardware here, I also appreciate 
any help to test restcan with real CAN hardware.

The project is hosted on github: https://github.com/sebi2k1/restcan

Cheers,
  Sebastian
