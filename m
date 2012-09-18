From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Tue, 18 Sep 2012 15:39:19 +0200
Message-ID: <50587987.3070308@grandegger.com>
References: <2478881.znSzbTXnK5@uschi> <505777BC.3000705@hartkopp.net> <5058659E.2010804@grandegger.com> <50586A50.5060300@pengutronix.de> <50586DE4.9020707@grandegger.com> <50587058.7090703@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:53531 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757122Ab2IRNj2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 18 Sep 2012 09:39:28 -0400
In-Reply-To: <50587058.7090703@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, =?ISO-8859-1?Q?Heinz-J=FCrg?= =?ISO-8859-1?Q?en_Oertel?= <oe@port.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 09/18/2012 03:00 PM, Marc Kleine-Budde wrote:
> On 09/18/2012 02:49 PM, Wolfgang Grandegger wrote:
> [...]
> 
>>> We have several customers who asked how to abort pending TX messages,
>>> too. Which involves:
>>> a) clear the TX-queue in Linux
>>> b) clear queue in hardware
>>> c) abort currently transmitting CAN frame
>>>
>>> I think c) would be a usecase of its own, too.
>>
>> I think you need c) for b), at least for some controllers. These
> 
> Yes, if it's a hardware limitation so be it. But if we design an
> interface it should support "clear everything" (a+b+c), but also just
> only c.

Yes, that you be nice. The only portable "clear everything" (a+b+c) I
see is "ifconfig down -> up". This also answers you other related mail.

What do people really want/need and why? This is still not clear to me.
More input would be nice.

Wolfgang.
