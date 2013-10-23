From: "Spies, Raphael | BFFT GmbH" <raphael.spies@bfft.de>
Subject: CAN Interface on Toradex Board
Date: Wed, 23 Oct 2013 16:49:30 +0000
Message-ID: <F1A135976112904197F6276B89309FEF2603BC@sgexc1.bfft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.bfft.de ([178.239.73.3]:51239 "EHLO mail.bfft.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408Ab3JWQym convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Oct 2013 12:54:42 -0400
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi everyone,


at the moment i try to get a can interface to work on a toradex 
tegra2 evaluation board. in the manual there are some instructions:


http://developer.toradex.com/software-resources/arm-family/linux/linux-%28colibri-t20%29-know-how#CAN

I downloaded the packages from: 

http://developer.toradex.com/files/toradex-dev/uploads/media/Colibri/Linux/Extra/can-packages.tar.bz2

and installed them on my device. When I try to set my bitrate as explained 

"ip link set can0 type can bitrate 125000"

it quits with 

"RTNETLINK answers: Invalid argument".


A strace command yields a line with


"open("usr/lib/ip/link_can.so", ...) = -1 ENOENT (No such file or directory)".


Does anyone have any idea how can I fix that problem? or in what direction I have to search for solutions?


Thanks a lot,
Raphael Spies



Kernel version 3.1.10-gd831d2d, build as explained on toradex homepage


