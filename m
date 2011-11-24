From: Frantisek Rysanek <rysanek@fccps.cz>
Subject: Re: [RFC PATCH] plx_pci: add Advantech PCI-1680 & UNO-2052 support
Date: Thu, 24 Nov 2011 21:35:03 +0100
Message-ID: <4ECEAA77.1030303@fccps.cz>
References: <4ECAB5E4.6010903@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail2.fccps.cz ([77.104.235.122]:60375 "EHLO mail.fccps.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753301Ab1KXUlD (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 24 Nov 2011 15:41:03 -0500
In-Reply-To: <4ECAB5E4.6010903@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Pavel Cheblakov <P.B.Cheblakov@inp.nsk.su>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Wolfgang Grandegger <wg@grandegger.com>

Dne 21.11.2011 21:34, Oliver Hartkopp napsal(a):
> Add Advantech PCI-1680 & UNO-2052 support for the SJA1000 plx_pci driver.
> 
> Signed-off-by: Frank Rysanek <rysanek@fccps.cz>
> 
> ---
> 
> Hello Frank,
> 
> i found your patch to support the Advantech PCI-1680 & UNO-2052 cards here:
> 
> 	http://www.fccps.cz/download/adv/frr/can-notes.html
> 
> Are you fine with posting the changes on the netdev mailing list to become
> part of the mainline Linux kernel?
>
definitely, that would be excellent :-)
Actually I've tried to submit the patch to linux-netdev, but it didn't
have the GIT-wise bells and whistles and I wasn't surprised that there
was no response...

> PLEASE REVIEW: You added an mdelay(100) in plx_pci_check_sja1000() ...
> 
> Are you sure this long delay is needed in plx_pci_check_sja1000() or should
> we better add a shorter mdelay(10) at the end of plx_pci_reset_common() ??
> 
> Are you sure your setup is not working without the added mdelay(100) ?
>
That's a good question.
I believe I got the time delay of 100 ms from some macro in a "character
device driver" maintained by the people at Peak Systemtechnik - the
macro specifies a "maximum time limit for the SJA1000 to accomplish a
switch into the RESET MODE".
The algorithm used by Peak was more complex than my hardwired delay:
they would wait for the flag (sign of success) in a loop, calling just
schedule() during every fruitless iteration.
And, the wait for the chip to "switch into RESET mode" is not exactly
the same as waiting for the chip to come back after a cold reset.

I added the delay because without it, my two SJA1000 channels would
remain undetected. It worked for me, and it didn't occur to me that
100ms at boot would be a problem - so I didn't bother to try a shorter
delay. As far as I can tell from the datasheet, the SJA1000 does not
seem to contain an MCU core running some "microcode", so I see no reason
why it shouldn't come up within a few clock cycles, rather than a 100 ms.
I'm gonna have to take a look if we happen to have some of those boards
in stock (they keep coming and going), stick one piece into a suitable
PC at my workplace and try to "bisect" an appropriate interval for that
delay...
Or can you suggest some "sign of life" to wait for in a semi-tight loop?

The problem is that at the moment I'm pretty swamped by other
intervening activities, both at work (hunting down other people's
hardware bugs) and in my private life (small children) - I hope to be
able to get this check done in a few days. I'll keep you posted.

> Thanks for your patch,
> Oliver
>
Thanks a lot for *your* time and attention :-)

Frank Rysanek
