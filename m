From: "Oliver Hartkopp" <socketcan@hartkopp.net>
Subject: Re: Re: Softing Firmware on gitorious
Date: Thu, 12 Jan 2012 10:47:36 +0100 (MET)
Message-ID: <201201120947.q0C9lav9006603@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from em-p00-ob.rzone.de ([81.169.146.224]:42050 "EHLO
	em-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859Ab2ALJrm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Jan 2012 04:47:42 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org


----- original Nachricht --------

Betreff: Re: Softing Firmware on gitorious
Gesendet: Do, 12. Jan 2012
Von: Marc Kleine-Budde<mkl@pengutronix.de>

> On 01/12/2012 10:30 AM, Kurt Van Dijck wrote:
> >>> The 5.01 package states the binary blob (and their code) is GPLv2.
> >>> The remainders of the 4.6 package I still have (only the firmware part)
> also
> >>> state it's all released under GPLv2.
> >>
> >> Do you mean the binary blob's source code is available as GPLv2? Do we
> >> have access to the source code? Would be interesting for the Debian
> Kernel.
> > Softing releases a linux driver package, with linux driver code and
> firmware
> > under GPLv2. The firmware is packaged as array's in c files.
> > The sources of the firmware itself are not available.

AFAIK there are also CAN transport protocol implementations or fragments of them part of this firmware.
That's why it's 45kByte+ in some cases - so i bet, we'll never get any source which may be under NDA too.

> 
> IANAL, some people think that a binary firmwarer w/o source code
> available under GPLv2 isn't GPv2.
> 
> However, we can document that in the WHENCE file of the linux firmware
> reporitory.

That's the best way :-)

Regards,
Oliver

