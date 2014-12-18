From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Subject: Re: [RFC] sched policies for candump
Date: Thu, 18 Dec 2014 18:03:11 +0530
Message-ID: <CA+V-a8uBmfbzAD1eXoejs4H-JQwXWbY+2b0n0fauy54P=BE9sg@mail.gmail.com>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl> <53D204A4.1060502@pengutronix.de>
 <BAY176-W4D41B1290DE5D3B2BD6D0D3FC0@phx.gbl> <53D2126C.40600@pengutronix.de>
 <BAY176-W426E5C1C47CA0379DFCD84D3FC0@phx.gbl> <53D214E2.7020205@pengutronix.de>
 <BAY176-W40C40CD192EBD241673159D3FC0@phx.gbl> <53D219E8.5060307@pengutronix.de>
 <BAY176-W36138D837FA40B1721062ED3FC0@phx.gbl> <53D234D9.2010602@hartkopp.net>
 <CA+V-a8vm+WQXcSwPp7e7yKQehs0+BYkHhZg-EfEL1gWE_cBF=g@mail.gmail.com>
 <53D91AB5.5060507@hartkopp.net> <BAY176-W523AF4513C195E7972FE52D3E60@phx.gbl>
 <53DA39CF.2070303@pengutronix.de> <53DA4E89.1080206@hartkopp.net>
 <CA+V-a8uhnn9cfuxULZQ4oBScy9jYfev+n50SphK+HDTVLPVO_g@mail.gmail.com> <5492A166.4090806@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:51896 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbaLRMdl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 18 Dec 2014 07:33:41 -0500
Received: by mail-oi0-f52.google.com with SMTP id h136so305858oig.11
        for <linux-can@vger.kernel.org>; Thu, 18 Dec 2014 04:33:41 -0800 (PST)
In-Reply-To: <5492A166.4090806@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

On Thu, Dec 18, 2014 at 3:11 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> Hello Prabhakar,
>
> I just discovered your pull-request for candump to add scheduling policies for candump:
>
> https://gitorious.org/linux-can/can-utils/commit/0ea8caacfa723271778d000e8cb97b2be4f92165
>
> Is this still needed / valuable?
>
If I remember correctly we agreed upon using chrt/nice to achieve this.

But I still feel having an option in the tool itself would be better
choice as some
of the novice users might not be aware of chrt/nice.

> If so I would suggest to make the commandline option able to handle more than only SCHED_RR ...
>
> Would the following patch be ok for you?
>
I am OK with it, but still depends on Marc.

Regards,
--Prabhakar Lad
