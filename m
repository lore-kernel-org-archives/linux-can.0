From: Ico Doornekamp <can@zevv.nl>
Subject: Re: CAN libpcap capture endianess
Date: Thu, 12 Sep 2013 10:47:02 +0200
Message-ID: <1378975140-sup-5236@pruts.nl>
References: <1378920814-sup-4559@pruts.nl> <5230C662.6010502@pengutronix.de> <1378929884-sup-7223@pruts.nl> <5230CE58.3020604@pengutronix.de> <1378968239-sup-1257@pruts.nl> <5231748A.2080009@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pruts.nl ([82.94.235.106]:36232 "EHLO fe2.pruts.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753667Ab3ILIrK (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 12 Sep 2013 04:47:10 -0400
In-reply-to: <5231748A.2080009@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>, yegorslists@googlemail.com

* On 2013-09-12 10:00:10 +0200, Marc Kleine-Budde wrote:
 
> ...but your CAN frames don't look correct in wireshark. I suggest you
> bring up the command line tools and use candump to display the raw CAN
> frames. Raw CAN frames, as they enter the application, are in host
> order. To be precise the can_id is in host order, as all other members
> are u8. "data" is an array of 8 x u8, which is in fact big endian
> ordered, if you want to access it with 2x32 or 64 bit.
> 
> > struct can_frame {
> >         canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
> >         __u8    can_dlc; /* frame payload length in byte (0 .. CAN_MAX_DLEN) */
> >         __u8    data[CAN_MAX_DLEN] __attribute__((aligned(8)));
> > };

I just did this. candump shows this:

  slcan0  58A   [8]  4B 12 20 04 D6 00 00 00

The raw data is shown in wireshark as

  8a 05 00 00 08 00 00 00  4b 12 20 04 d6 00 00 00

The CAN dissector parses this as identifier 0x0a050000 with the
'extended' flag set , which seems to have the wrong endianess.

The CANopen dissector also interprets the identifier with wrong endian
order, and is thus not able to decode the rest of the packet.

If I'm not mistaking, both the CAN and CANopen dissector in wireshark
are thus assuming wrong endianess. I'll check the source and see if I
can come up with a proper patch for the wireshark team.

Thank you for your feedback,

Ico
