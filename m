From: John Whitmore <arigead@gmail.com>
Subject: Documentation/networking/can.txt
Date: Mon, 2 Dec 2013 22:49:17 +0000
Message-ID: <20131202224916.GA5577@griso.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:63569 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389Ab3LBWtw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 2 Dec 2013 17:49:52 -0500
Received: by mail-wg0-f54.google.com with SMTP id n12so11657061wgh.33
        for <linux-can@vger.kernel.org>; Mon, 02 Dec 2013 14:49:51 -0800 (PST)
Received: from griso.site (host213-121-18-169.webport-cl2-hg5.ilford.mdip.bt.net. [213.121.18.169])
        by mx.google.com with ESMTPSA id s2sm127291856wiy.7.2013.12.02.14.49.49
        for <linux-can@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Dec 2013 14:49:50 -0800 (PST)
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Been lurking on this list for a while trying to get a feel for it. First post,
poking my head above the wall, so to speak.

I'll start with the Documentation in the Linux kernel. At the moment, on a
netbook, running from the Linus' git tree so perhaps I'm on the wrong git tree
for communicating with this mailing list, but given the number of different
git trees, I can't keep my head straight. Let me know if I'd be better on a
different git tree.

I've been reading (and re-reading) a few of the networking docs and specifically
can.txt as I'm starting to do some work on Linux CAN. To date I've been
working on MCP2515's connected to small micro-controllers creating my own
networks. I'm now hoping to plug a RaspberryPi into my CAN Networks.

There are a few typos in can.txt that aren't a big deal, but I could try send
a patch file for them. My bigger question is with regard to section 3.3 which
mentions Kconfig options "CAN_RAW_USER" and "CAN_BCM_USER". I've searched in
the linux "make menuconfig" for these options and neither exist. grep'd the
code, and didn't find an occurrence, outside can.txt, so I assume these two
options could be removed from the text?

Finally, for the moment, section 7 references:

http://developer.berlios.de/projects/socketcan

this link is no longer correct as it points to another URL, so perhaps this
reference could be updated?

I can attempt a patch but let me know against which git tree? Maybe that info
could go into can.txt as well.

jwhitmore
