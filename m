From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] sched policies for candump
Date: Thu, 18 Dec 2014 14:51:11 +0100
Message-ID: <5492DBCF.2010500@hartkopp.net>
References: <BAY176-W240BDB3FFF425370BF5B47D3FE0@phx.gbl> <53D204A4.1060502@pengutronix.de> <BAY176-W4D41B1290DE5D3B2BD6D0D3FC0@phx.gbl> <53D2126C.40600@pengutronix.de> <BAY176-W426E5C1C47CA0379DFCD84D3FC0@phx.gbl> <53D214E2.7020205@pengutronix.de> <BAY176-W40C40CD192EBD241673159D3FC0@phx.gbl> <53D219E8.5060307@pengutronix.de> <BAY176-W36138D837FA40B1721062ED3FC0@phx.gbl> <53D234D9.2010602@hartkopp.net> <CA+V-a8vm+WQXcSwPp7e7yKQehs0+BYkHhZg-EfEL1gWE_cBF=g@mail.gmail.com> <53D91AB5.5060507@hartkopp.net> <BAY176-W523AF4513C195E7972FE52D3E60@phx.gbl> <53DA39CF.2070303@pengutronix.de> <53DA4E89.1080206@hartkopp.net> <CA+V-a8uhnn9cfuxULZQ4oBScy9jYfev+n50SphK+HDTVLPVO_g@mail.gmail.com> <5492A166.4090806@hartkopp.net> <CA+V-a8uBmfbzAD1eXoejs4H-JQwXWbY+2b0n0fauy54P=BE9sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:38294 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbaLRNvO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 18 Dec 2014 08:51:14 -0500
In-Reply-To: <CA+V-a8uBmfbzAD1eXoejs4H-JQwXWbY+2b0n0fauy54P=BE9sg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Prabhakar Lad <prabhakar.csengg@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 18.12.2014 13:33, Prabhakar Lad wrote:

>> Is this still needed / valuable?
>>
> If I remember correctly we agreed upon using chrt/nice to achieve this.
>
> But I still feel having an option in the tool itself would be better
> choice as some
> of the novice users might not be aware of chrt/nice.
>

Ah - now I remember myself.

The point was that you then become in charge to put this into all relevant 
tools - which is probably not what you want.

So increase the awareness for novice users to use chrt/nice looks like the 
better option ;-)

Best regards,
Oliver
