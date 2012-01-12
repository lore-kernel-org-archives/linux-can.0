From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Softing Firmware on gitorious
Date: Thu, 12 Jan 2012 11:01:37 +0100
Message-ID: <20120112100137.GE380@e-circ.dyndns.org>
References: <4F0DB66F.50509@hartkopp.net>
 <4F0DBF90.5050906@pengutronix.de>
 <4F0DC8BC.4040704@hartkopp.net>
 <20120112082536.GA380@e-circ.dyndns.org>
 <20120112090217.GB380@e-circ.dyndns.org>
 <4F0EA442.8080303@pengutronix.de>
 <20120112093009.GC380@e-circ.dyndns.org>
 <4F0EA90C.2050109@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:30123 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377Ab2ALKBl (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 12 Jan 2012 05:01:41 -0500
Content-Disposition: inline
In-Reply-To: <4F0EA90C.2050109@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Thu, Jan 12, 2012 at 10:34:04AM +0100, Marc Kleine-Budde wrote:
> On 01/12/2012 10:30 AM, Kurt Van Dijck wrote:
> >>> The 5.01 package states the binary blob (and their code) is GPLv2.
> >>> The remainders of the 4.6 package I still have (only the firmware part) also
> >>> state it's all released under GPLv2.
> >>
> >> Do you mean the binary blob's source code is available as GPLv2? Do we
> >> have access to the source code? Would be interesting for the Debian Kernel.
> > Softing releases a linux driver package, with linux driver code and firmware
> > under GPLv2. The firmware is packaged as array's in c files.
> > The sources of the firmware itself are not available.
> 
> IANAL, some people think that a binary firmwarer w/o source code
> available under GPLv2 isn't GPv2.
I _think_ the Debian goal is to have a Free system. 
Firmware under GPLv2 without source, IMHO, _is_ GPLv2, but not Free.

>
> However, we can document that in the WHENCE file of the linux firmware
> reporitory.
I think we can distribute the files, as long as we mention the source
(=Softing) to comply with the GPLv2.
> 
> Marc
Regards,
Kurt
