From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Informations About CAN API of the Linux Kernel
Date: Mon, 11 Mar 2013 18:20:07 +0100
Message-ID: <513E1247.1070405@hartkopp.net>
References: <2B7D120CFC15DC438D721B998AD9D9E9097105AB@SEGOTNC5180-N2.vcn.ds.volvo.net> <513763CC.1070507@pengutronix.de> <20130307124012.GC603@vandijck-laurijssen.be> <5139A78D.9060005@pengutronix.de> <20130308100548.GA496@vandijck-laurijssen.be> <20130308125123.GA28383@pengutronix.de> <20130311092923.GA5114@vandijck-laurijssen.be> <513DF3D4.6090605@pengutronix.de> <20130311153437.GD5114@vandijck-laurijssen.be> <513DFFBB.8050406@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:50218 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab3CKRUK (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 11 Mar 2013 13:20:10 -0400
In-Reply-To: <513DFFBB.8050406@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, Sako Youssouf <youssouf.sako@renault-trucks.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 11.03.2013 17:00, Marc Kleine-Budde wrote:

> On 03/11/2013 04:34 PM, Kurt Van Dijck wrote:


>>> Does j1939 have a protocol number? Probably.
>> Yes. 7.
>>
>>> If so, we shouldn't use the
>>> "next free" one for an experimental protocol.
>> That's another reason to have J1939 merged.
>> I would have alerted anyhow when the protocol number 7 got allocated...
> 
> Yes, but as soon as you are "officially" using the number 7, you have to
> provide a stable API and ABI to the userspace.


Yep - Additionally i don't think, that reserving the "7" for CAN_J1939 is a
strong reason for pushing the merge process.

We (will say "the Linux CAN community") all know that J1939 is prepared by
Kurt and that we reserve the "7" proto number for it.

I personally see no reason that someone tries to allocate the "7" without our
joint acknowledge.

Regards,
Oliver

