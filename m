From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: CAN Interface on Toradex Board
Date: Wed, 23 Oct 2013 19:22:49 +0200
Message-ID: <526805E9.1060702@hartkopp.net>
References: <F1A135976112904197F6276B89309FEF2603BC@sgexc1.bfft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:56577 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab3JWRWv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Oct 2013 13:22:51 -0400
In-Reply-To: <F1A135976112904197F6276B89309FEF2603BC@sgexc1.bfft.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Spies, Raphael | BFFT GmbH" <raphael.spies@bfft.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 23.10.2013 18:49, Spies, Raphael | BFFT GmbH wrote:
> Hi everyone,
> 

Hi Raphael,

> 
> at the moment i try to get a can interface to work on a toradex 
> tegra2 evaluation board. in the manual there are some instructions:
> 
> 
> http://developer.toradex.com/software-resources/arm-family/linux/linux-%28colibri-t20%29-know-how#CAN
> 
> I downloaded the packages from: 
> 
> http://developer.toradex.com/files/toradex-dev/uploads/media/Colibri/Linux/Extra/can-packages.tar.bz2
> 
> and installed them on my device. When I try to set my bitrate as explained 
> 
> "ip link set can0 type can bitrate 125000"
> 
> it quits with 
> 
> "RTNETLINK answers: Invalid argument".

Can you see the can0 interface itself?

E.g. with

ip link show
ip -det link show

or

cat /proc/net/dev

??

Can you see this message from the documentation

[    4.904898] CAN device driver interface
[    4.932793] Colibri EvalBoard V3.1a/MECS Tellurium xPOD CAN Initialisation
[    4.979119] mcp251x spi3.0: probed

when invoking 'dmesg' ?

> 
> 
> A strace command yields a line with
> 
> 
> "open("usr/lib/ip/link_can.so", ...) = -1 ENOENT (No such file or directory)".
> 

This looks like the installed iproute2 package is broken.

My 'ip' does not try to access "usr/lib/ip/link_can.so"

at least the leading slash "/" is missing.

Is it possible that you have a built-in "ip" in your busybox which is invoked
here?

Say

 ls -l `which ip`

to check if 'ip' is linked to the busybox binary.

Regards,
Oliver

> 
> Does anyone have any idea how can I fix that problem? or in what direction I have to search for solutions?
> 
> 
> Thanks a lot,
> Raphael Spies
> 
> 
> 
> Kernel version 3.1.10-gd831d2d, build as explained on toradex homepage


