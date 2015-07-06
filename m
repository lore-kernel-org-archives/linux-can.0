From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [BULK]Re: [PATCH] can: fix loss of frames due to wrong assumption
 in raw_rcv
Date: Mon, 06 Jul 2015 07:44:54 +0200
Message-ID: <559A15D6.2010704@hartkopp.net>
References: <5585A104.1090201@gmx.at> <5585EC4D.40103@hartkopp.net> <5587D9DA.6000102@gmx.at> <5587E26A.1070000@hartkopp.net> <5588E6FB.5040903@optusnet.com.au> <55891263.3050704@hartkopp.net> <558A1244.3010908@optusnet.com.au> <558B0B6F.6010304@hartkopp.net> <558BBC92.6040906@peak-system.com> <840510251.4781629.1435224977567.JavaMail.open-xchange@patina.store> <55916EBC.2010807@hartkopp.net> <55980FCE.4030304@hartkopp.net> <559885DC.8040208@optusnet.com.au> <559975A2.9020300@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:49882 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbbGFFpQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 6 Jul 2015 01:45:16 -0400
In-Reply-To: <559975A2.9020300@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Tom Evans <tom_usenet@optusnet.com.au>, Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Manfred Schlaegl <manfred.schlaegl@gmx.at>

/me again

On 05.07.2015 20:21, Oliver Hartkopp wrote:

> With
>
> # echo 1 > /proc/irq/28/smp_affinity
>
> I assigned the IRQ 28 to CPU0 and it now looks like this:
>
> # cat /proc/interrupts
>             CPU0       CPU1       CPU2       CPU3
>    0:         23          0          0          0  IR-IO-APIC   2-edge      timer
> (..)
>   28:    9072996      53480     766233    2125901  IR-PCI-MSI 327680-edge      xhci_hcd
> (..)
>
> and all the out-of-order receptions were totally gone! \o/
>

I ran the test for 11 hours now (3 x 8000 = 24.000 frames/s).

No single out-of-order frame this time - not even with the PCAN-USB.

Cheers,
Oliver
