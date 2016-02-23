From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: RFC can-j1939
Date: Tue, 23 Feb 2016 11:06:43 +0100
Message-ID: <20160223100643.GA17694@airbook.eia.lan>
References: <006b01d16db9$1b9e94d0$52dbbe70$@slingshot.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:47671 "EHLO
	relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbcBWKHi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 23 Feb 2016 05:07:38 -0500
Content-Disposition: inline
In-Reply-To: <006b01d16db9$1b9e94d0$52dbbe70$@slingshot.co.nz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: R U Local <roystonvasey@slingshot.co.nz>
Cc: 'linux-can' <linux-can@vger.kernel.org>

> 
> Dear Kurt,
> Thanks for your great work.
> I'm just bringing up the J1939 stack on a TI OMAP4 based system.
> I'm locked to a custom kernel 3.19 due to media drivers and codecs.
> I followed your guide and pulled code from 4.1 and 3.15 branches.

I guessed you just merge the j1939d-3.15 branch, noth the 4.1.

> I also patched and built can-utils and iproute2.

iproute2 must not be patched anymore.

> I can't get the Transport Protocol to work send only sends the first packet and receive hangs on reception of the first packet.

I walked through my quick starter guide and i realised I had not updated
it for dealing with the j1939 socket closing before the transport
protocol is ready.

I just now updated my quick start guide. Can you try that, and tell
where exactly it goes wrong in your opinion.

> As far as your RFC your implementation looks to be ideal for our applications.
> For user space applications where should the headers (<linux/can/can.h> & <linux/can/j1939/j1939.h>) be taken from or provided by?

Ideally, this becomes mainline and then you will sooner or later find
the header in linux/can/j1939.h. Up to then, you will need to fix your
toolchain manually by copying j1939.h there yourself.
Do not forget that linux/can.h needs patching too.

Kurt
