From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: can: flexcan: Ancient Freescale Reference FlexCAN Driver and bug
 fixes so it works.
Date: Fri, 11 Dec 2015 09:53:27 +1100
Message-ID: <566A0267.2080809@optusnet.com.au>
References: <1431603215-25546-1-git-send-email-bhupesh.sharma@freescale.com>
 <1431603215-25546-6-git-send-email-bhupesh.sharma@freescale.com>
 <5554C244.80809@pengutronix.de>
 <BY1PR0301MB130358076C3A5969406DE69182D80@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <BY1PR0301MB130384E91308C49A850DEC4782E90@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <56696582.7020503@optusnet.com.au> <566973A4.5000703@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:60464 "EHLO
	mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753671AbbLJWxi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Dec 2015 17:53:38 -0500
In-Reply-To: <566973A4.5000703@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Sharma Bhupesh <bhupesh.sharma@freescale.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arora Sakar <Sakar.Arora@freescale.com>

On 10/12/2015 11:44 PM, Marc Kleine-Budde wrote:
> On 12/10/2015 12:44 PM, Tom Evans wrote:
>> I've just had to delve back into the deep murky past and try to get
>> Freescale's Kernel 2.6.35 FlexCAN driver working...

On an i.MX53. That's the last supported kernel Freescale ever released 
for that series of parts.

> 2.6.x I feel your pain. Another option would be to port the flexcan
> driver to that old kernel. But I'm getting off topic here :)

Been there. Options are to port 2.6.38 (Freescale's Android release) 
which has the 2.6.38 mainstream driver, but looks to have a full 
collection of all the bugs fixed since then. Some kind soul has already 
done that and released a patch (but I don't like the bugs). Or the 3.4 
version we're running with our 3.4 kernel or something more modern. I 
don't trust later versions to even compile - the headers and interfaces 
change. Then I can't use modern ones anyway as they use NAPI and that 
simply doesn't work with Linux and CAN. So I'd have to apply all my 
de-NAPI patches. The simplest path was to fix the simple and stupidly 
obvious bugs in the existing driver rather than add new complicated bugs.

>> 2 - It can't receive in order, but you'd only need to sort on the
>> 3 - It can't transmit in order either (unless you drop it to one
>
> In order reception is crucial.

So what mind-set at Freescale doesn't see this as a problem? I suspect 
their CAN knowledge stopped at the HCS08 stage, making tiny devices that 
control just one thing, like a door lock. So just receive and transmit 
one or two messages where "priority order" is more important than 
running any debug or diagnostic protocols.

>> Patches to fix all of it on the end of this thread:
>>
>> https://community.freescale.com/thread/303271
>
> If there's interest in working with this prehistoric kernel, why isn't
> there anyone that picks up all the patches and add them to a git repo.

There was. That's what the above post is meant to be for. But the last 
actual activity was in January 2013. It details how to submit patches, 
but it is too onerous for me. It has to use their exact complete 
distribution (of everything, not just the kernel) running on their exact 
development board. It also needs your .gitconfig set up "just so" 
matching your Freescale registration details. I'm using the thread as a 
dumping ground for "useful patches for customers", and hope google or 
Freescale's search can find them.

> fsl doesn't seem to care either, maybe unless you're using
 > their newest product :(

The team seems to disappear almost before the product is released. They 
all moved to i.MX6 years ago.

Tom


