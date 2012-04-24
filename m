From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH 1/3] can: c_can: fix "BUG! echo_skb is occupied!" during
 transmit
Date: Tue, 24 Apr 2012 11:24:45 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13E997D11@DBDE01.ent.ti.com>
References: <1334915862-29810-1-git-send-email-anilkumar@ti.com>
 <4F965C6D.6030303@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46606 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752310Ab2DXLZA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Apr 2012 07:25:00 -0400
In-Reply-To: <4F965C6D.6030303@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

Hi Marc,

Thanks for the comments.

On Tue, Apr 24, 2012 at 13:25:25, Marc Kleine-Budde wrote:
> On 04/20/2012 11:57 AM, AnilKumar Ch wrote:
> > This patch fixes an issue with transmit routine, which causes
> > "can_put_echo_skb: BUG! echo_skb is occupied!" messgae when
> > using "cansequence -p" on D_CAN controller.
> > 
> > In c_can driver, while transmitting packets tx_echo flag holds
> > the no of can frames put for transmission into the hardware.
> > 
> > As the comment above c_can_do_tx() indicates, if we find any packet
> > which is not transmitted then we should stop looking for more.
> > In the current implementation this is not taken care of causing the
> > said message.
> > 
> > Also, fix the condition used to find if the packet is transmitted
> > or not. Current code skips the first tx message object and ends up
> > checking one extra invalid object.
> 
> The two above listed issues can occur with the c_can hardware, too?
> Please split into two separate patches. These should go to the stable
> kernel, too. Can someone with a c_can hardware test these patches.

I will split into two patches. I had clubbed both the changes in a single
patch because both the changes are required to get rid of the error mentioned
in the subject line.

I will add the stable tag when submitting next, but since I do not have c_can
hardware, someone needs to confirm this actually solves a c_can issue. I have
read through the c_can specification and see that this would indeed be a problem
on c_can.

> 
> > While at it, fix the comment on top of c_can_do_tx() to use the
> > terminology "packet" instead of "package" since it is more
> > standard.
> 
> Add this to one of the above patches.

Sure.

Regards,
AnilKumar
