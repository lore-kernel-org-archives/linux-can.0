From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: peak_pci: TX Frame Loss
Date: Tue, 8 Dec 2015 12:24:55 +0000
Message-ID: <20151208122455.GA16567@maxwell.marel.net>
References: <20151118145121.32487.38169@maxwell.marel.net>
 <20151202180937.19023.96078@maxwell.marel.net>
 <565F4439.3050309@hartkopp.net>
 <565FE31D.8060606@hartkopp.net>
 <20151203112319.GA5230@maxwell.marel.net>
 <56602B1D.90601@pengutronix.de>
 <5666AF26.2080806@peak-system.com>
 <20151208105026.GA13146@maxwell.marel.net>
 <5666C242.8090506@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-am1on0079.outbound.protection.outlook.com ([157.56.112.79]:40352
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755981AbbLHM0z (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 8 Dec 2015 07:26:55 -0500
Content-Disposition: inline
In-Reply-To: <5666C242.8090506@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, wg@grandegger.com, hrafnkell.eiriksson@marel.com, haukur.hafsteinsson@marel.com

Hi Stephane,

On Tue, Dec 08, 2015 at 12:42:58PM +0100, Stephane Grosjean wrote:
> Hi Andri,
> 
> So, you mean that, for example, the below sequence (extract from _xmit()):
> 
>                 priv->write_reg(priv, SJA1000_FI, fi);
>                 priv->write_reg(priv, SJA1000_ID1, (id & 0x000007f8) >> 3);
>                 priv->write_reg(priv, SJA1000_ID2, (id & 0x00000007) << 5);
>                 ...
>                 (1)
>                 ...
>                 sja1000_write_cmdreg(priv, CMD_TR);
> 
> can't be interrupted at all (especially at (1)), by any IRQ which ISR could
> write (again) some new ID?
> I mean, shouldn't the SJA1000 and the sequence order of the cmds be
> considered as shared resource?
> 

AFAIK only _xmit() writes to these registers and I think the _xmit() function is
only ever executed on one core at a time. Executing two of them at the same time
wouldn't make much sense. It would just cause out-of-order transmission.

Also, the interrupt routine does not call _xmit() directly. It just calls
netif_wake_queue() which AFAIK schedules the _xmit() routine to be called later.

I'm just saying that we shouldn't place locks where they are not needed because
it really just obfuscates the real issue. It's the equivalent of leaving the
mess on the ground and just walking around it instead of cleaning it up. Someone
else will step into it.

Besides, ftrace does not show _xmit() being called concurrently for the frames
that are lost.

By the way, I'm not sure that I understood you correctly. Did placing the spin
locks prevent the issue? I'm not sure this "guess what" rhetoric works well on a
mailing list. ;)

Thanks,
Andri
