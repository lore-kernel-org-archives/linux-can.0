From: Ico Doornekamp <can@zevv.nl>
Subject: Re: CAN libpcap capture endianess
Date: Wed, 11 Sep 2013 20:30:31 +0200
Message-ID: <1378923967-sup-6565@pruts.nl>
References: <1378920814-sup-4559@pruts.nl> <5230B4C9.4070904@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pruts.nl ([82.94.235.106]:46755 "EHLO fe2.pruts.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754840Ab3IKSak (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 11 Sep 2013 14:30:40 -0400
In-reply-to: <5230B4C9.4070904@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>

* On 2013-09-11 20:22:01 +0200, Marc Kleine-Budde wrote:
 
> > Recently I tried the CANopen module in wireshark to sniff on my
> > slcan interface, but the dissector seemed to mix up the endianess of
> > the
> 
> When opening your attached files I don't see any CANopen related
> dissecting happening in my wireshark (Version 1.10.1 (SVN Rev 50926
> from /trunk-1.10), from current Debian testing/jessie). Just normal
> raw CAN frames are displayed.

Since CAN does not have a way to distinguish between sub-protocols, wireshark
has no way to detect the payload as CANopen.  To force wireshark to use the
CANopen dissector, you can change the next level protocol in the preferences
window, as described here:

https://libbits.wordpress.com/2012/05/07/capturing-and-analyzing-can-frames-with-wireshark/

> But you're using a 64 bit system while Yegor uses a 32 bit one
> (according to your notes below).

Indeed, but I believe that should in no way interfere with captured data
endianess.

> Your dump doesn't look correct in my wireshark, it has alternating
> extended and standard frames and the standard frames have identifiers
> of 0x060000 which is not valid.
> 
> Does the command line tool candump show proper frames?

I'll have to look into that tomorrow, at this time I only have access to
the capture file I made earlier.

For the record: my capture was made with the following commands:

slcan_attach /dev/ttyUSB0 -o -s 5
slcand ttyUSB0
ifconfig slcan0 up
wireshark -i slcan0 -w capture.pcap
