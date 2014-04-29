From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: am335x: d_can: rx issue
Date: Tue, 29 Apr 2014 19:10:28 +0200
Message-ID: <535FDD04.2050804@hartkopp.net>
References: <CAGm1_ktbB6SOGd5PygOrh4FOZU1fofAK4omAur-VHeo1Tw9tJQ@mail.gmail.com> <alpine.DEB.2.02.1404281510170.6261@ionos.tec.linutronix.de> <CAGm1_ks=xU3tomPy+YhFtACqsbPLSP6D-hocC=pkhdtA5L_cQQ@mail.gmail.com> <alpine.DEB.2.02.1404291102240.6261@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:55028 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491AbaD2RKc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Apr 2014 13:10:32 -0400
In-Reply-To: <alpine.DEB.2.02.1404291102240.6261@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

On 29.04.2014 11:03, Thomas Gleixner wrote:
> On Tue, 29 Apr 2014, Yegor Yefremov wrote:

>>>> TX is working, but rx not. Am I missing any patches, that fix this issue?
>>>
>>> I bet, TX is not working either. You probably fall over the issue with
>>> the startup logic.
>>>
>>> Does the following patch fix your issue?
>>>
>>>     http://patchwork.ozlabs.org/patch/342518/
>>
>> Yes, it does.
>>
>> Thanks.
>>
>> Are these patches going to hit 3.15-rc4?
> 
> Marc, can you expedite that one for 3.15 please?
> 

Hi Thomas,

Marc is out of office until May 5th.
See: http://marc.info/?l=linux-can&m=139855189427393&w=2

But this requested patch has already been pulled into Dave Millers net-tree:

http://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?id=bed11db3d4095e5f818f5e8bf7f43ef2beb36d4e

So it will hit mainline with the next pull request from Dave to Linus.
3.15-rc4 looks therefore really feasible :-)

Btw. I'm currently running Daves net-tree here and was forced to define 
CONFIG_CAN_C_CAN_STRICT_FRAME_ORDERING during 'make oldconfig' ...

Can this Kconfig option probably be removed in the 3.15-rc phase when
it's not really needed anymore?

See: http://marc.info/?l=linux-can&m=139746476821294&w=2

Regards,
Oliver
