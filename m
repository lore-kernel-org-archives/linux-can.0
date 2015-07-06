From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [BULK]Re: [PATCH] can: fix loss of frames due to wrong assumption
 in raw_rcv
Date: Mon, 06 Jul 2015 19:09:34 +0200
Message-ID: <559AB64E.1060308@hartkopp.net>
References: <5585A104.1090201@gmx.at> <5585EC4D.40103@hartkopp.net> <5587D9DA.6000102@gmx.at> <5587E26A.1070000@hartkopp.net> <5588E6FB.5040903@optusnet.com.au> <55891263.3050704@hartkopp.net> <558A1244.3010908@optusnet.com.au> <558B0B6F.6010304@hartkopp.net> <558BBC92.6040906@peak-system.com> <840510251.4781629.1435224977567.JavaMail.open-xchange@patina.store> <55916EBC.2010807@hartkopp.net> <55980FCE.4030304@hartkopp.net> <559885DC.8040208@optusnet.com.au> <559975A2.9020300@hartkopp.net> <559A15D6.2010704@hartkopp.net> <559A251C.8030307@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:54768 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726AbbGFRJw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Jul 2015 13:09:52 -0400
In-Reply-To: <559A251C.8030307@optusnet.com.au>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: tom_usenet@optusnet.com.au, Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Manfred Schlaegl <manfred.schlaegl@gmx.at>

Hi Tom,

On 06.07.2015 08:50, Tom Evans wrote:

> CPU Affinity may fix this problem, but I suspect there should be a more
> "standard" fix. This sort of problem (multiple CPUs fielding interrupts and
> getting them out of order) should show up elsewhere. It might even swap bytes
> from a UART.
>
> There must be a "standard synchronization technique" of some sort that
> provides the proper sequencing here. Can anyone else reading this thread who
> knows if this is right please chime in?
>
> Google finds:
>
> http://www.alexonlinux.com/why-interrupt-affinity-with-multiple-cores-is-not-such-a-good-thing

I found this relating kernel documentation:

https://www.kernel.org/doc/Documentation/networking/scaling.txt

It seems like we should take a look at receive packet steering (RPS) - and how 
other devices like the Intel IGB ethernet driver makes use of it.

Regards,
Oliver
