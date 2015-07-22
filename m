From: Tobias Schmitt <tobias.schmitt@codm.de>
Subject: State of ISO-TP in SocketCAN?
Date: Wed, 22 Jul 2015 11:45:35 +0200
Message-ID: <C0D0FD46-6144-4CFF-9730-FC6920E35766@codm.de>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.codm.de ([213.178.9.190]:37698 "EHLO aria.codm.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932429AbbGVJyK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Jul 2015 05:54:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by aria.codm.de (Postfix) with ESMTP id 2D36D3460B6
	for <linux-can@vger.kernel.org>; Wed, 22 Jul 2015 11:45:37 +0200 (CEST)
Received: from aria.codm.de ([127.0.0.1])
	by localhost (aria.codm.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dm2bPJSVMrpw for <linux-can@vger.kernel.org>;
	Wed, 22 Jul 2015 11:45:35 +0200 (CEST)
Received: from [192.168.40.100] (toni.codm.de [87.139.45.202])
	(Authenticated sender: tobias.schmitt@codm.de)
	by aria.codm.de (Postfix) with ESMTPSA id BEF203460B5
	for <linux-can@vger.kernel.org>; Wed, 22 Jul 2015 11:45:35 +0200 (CEST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi

I work on a project using a beaglebone black and it's CAN interface via SocketCAN. At first I want to thank you all for this, it's working incredibly stable! Since our payload of data will be much higher soon (about 50-100 bytes in one package) we want to use ISO-TP. The thing is, that the information about the state of the ISO-TP implementation of SocketCAN is very rare and provides some contrary information. I hope this mailinglist can bring some clarity to my confused mind.

At first my target device where I try to run can-isotp:
Beaglebone Black Rev B / C
Beaglebone Ubuntu 14.04.02 image from http://elinux.org/BeagleBoardUbuntu
uname: Linux bone 3.8.13-bone63 #1 SMP Mon Aug 11 23:03:02 UTC 2014 armv7l armv7l armv7l GNU/Linux

What I have done:
0: lots of internet searches

1: read Documentation/networking/can.txt:
It says that one just has to use the ISOTP protocol when initializing the socket.
I downloaded the can-utils repo and tried to use isotpsend for testing purposes. the isotp programs exit with "socket: protocol not supported".

2: Then I found an old post by Oliver Hartkopp on this mailinglist (http://comments.gmane.org/gmane.linux.can/2135) which says that one has to use kernelmodule can-isotp instead of can-raw. I also cannot find any option for compiling a can-isotp module on the 3.8 kernel in 'make menuconfig'. Then I found the can-isotp-modules repo in Oliver Hartkopps github account (http://github.com/hartkopp/can-isotp-modules) which I cannot build because of missing definitions (NETIF_F_NO_CSUM in net/can/slcan.c). Since the repos description says that this Repo is obsolete and there's a Alpha-Warning in the README.isotp file, i assume this is not the right repository to use anyway.

And now I'm very confused and maybe on a complete wrong track. Is there a official and stable way to use ISOTP as a protocol in SocketCAN, and where can I find it? Is it still in development and can I help with it somehow?

Best regards
Tobias

PS: I hope this mail provides enough information and is not too text heavy, since it's my first question on a official mailinglist. If not, I apologize!

