From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Documentation/networking/can.txt
Date: Tue, 03 Dec 2013 07:56:17 +0100
Message-ID: <529D8091.20300@hartkopp.net>
References: <20131202224916.GA5577@griso.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:54146 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab3LCG4U (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 3 Dec 2013 01:56:20 -0500
In-Reply-To: <20131202224916.GA5577@griso.site>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Whitmore <arigead@gmail.com>
Cc: linux-can@vger.kernel.org


On 02.12.2013 23:49, John Whitmore wrote:
> Been lurking on this list for a while trying to get a feel for it. First post,
> poking my head above the wall, so to speak.
> 

Welcome! :-)

> I'll start with the Documentation in the Linux kernel. At the moment, on a
> netbook, running from the Linus' git tree so perhaps I'm on the wrong git tree
> for communicating with this mailing list, but given the number of different
> git trees, I can't keep my head straight. Let me know if I'd be better on a
> different git tree.

This is at least the correct mailing list for Documentation/networking/can.txt

Sometimes the Documentation URL is mentioned in the MAINTAINERS file, e.g.

http://lxr.linux.no/#linux+v3.12.2/MAINTAINERS#L123

We should add the documentation URL like this ...

diff --git a/MAINTAINERS b/MAINTAINERS
index 4afcfb4..5791d3d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2023,6 +2023,7 @@ L:	linux-can@vger.kernel.org
 W:	http://gitorious.org/linux-can
 T:	git git://gitorious.org/linux-can/linux-can-next.git
 S:	Maintained
+F:	Documentation/networking/can.txt
 F:	net/can/
 F:	include/linux/can/core.h
 F:	include/uapi/linux/can.h

... to answer the question which mailing list to use for can.txt .
You might add this change into your final patch.

> 
> I've been reading (and re-reading) a few of the networking docs and specifically
> can.txt as I'm starting to do some work on Linux CAN. To date I've been
> working on MCP2515's connected to small micro-controllers creating my own
> networks. I'm now hoping to plug a RaspberryPi into my CAN Networks.
> 

Many people tried this before. That should work.

> There are a few typos in can.txt that aren't a big deal, but I could try send
> a patch file for them. My bigger question is with regard to section 3.3 which
> mentions Kconfig options "CAN_RAW_USER" and "CAN_BCM_USER". I've searched in
> the linux "make menuconfig" for these options and neither exist. grep'd the
> code, and didn't find an occurrence, outside can.txt, so I assume these two
> options could be removed from the text?

Yes.
It's a remainder from a very early post of the CAN patch series.

> 
> Finally, for the moment, section 7 references:
> 
> http://developer.berlios.de/projects/socketcan
> 
> this link is no longer correct as it points to another URL, so perhaps this
> reference could be updated?

I updated this URL list at Wikipedia some days ago:
http://en.wikipedia.org/wiki/SocketCAN#External_links

Doing this I was also thinking about section 7 but I did not find a good
solution so far.

We could add some of the URLs here too.
But I wonder if having the URLs to the project website and the mailing list in
the MAINTAINERS file only is better (to have only one single point of
reference). E.g. section 7 could point to the MAINTAINERS file then.
Any preference?

> 
> I can attempt a patch but let me know against which git tree? Maybe that info
> could go into can.txt as well.

The different git trees (torvalds/linux.git, davem/net.git,
davem/net-next.git) and the two CAN trees located at gitorious.org are always
in different states depending on the current development phase.

Usually davem/net-next.git is the right place for new drivers and bigger
changes in the documentation.

For fixes and small documentation updates davem/net.git is the right tree to
send patched against. -> I would use this tree in your case.

Best regards,
Oliver
