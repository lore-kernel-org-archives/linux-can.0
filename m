From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: Any chance to get the Vector CANcardXL working with SocketCAN?
Date: Wed, 26 Feb 2014 15:37:51 +0100
Message-ID: <20140226143751.GC25369@vandijck-laurijssen.be>
References: <D91D9A33E1E2B046B8FBA4F6EDF45FD53D056D5D@kgtz-mb01.ds.fh-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay006.isp.belgacom.be ([195.238.6.172]:2678 "EHLO
	mailrelay006.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750954AbaBZOiB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 26 Feb 2014 09:38:01 -0500
Content-Disposition: inline
In-Reply-To: <D91D9A33E1E2B046B8FBA4F6EDF45FD53D056D5D@kgtz-mb01.ds.fh-kl.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sascha =?utf-8?B?TcO8bnpiZXJn?= <samu0007@stud.fh-kl.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hey,

I wrote the softing driver because of the need to reuse our
bunch of softing PCMCIA cards.
See my comments below ...

On Tue, Feb 25, 2014 at 01:52:36PM +0000, Sascha M=C3=BCnzberg wrote:
> Hello,
>=20
> I wonder if I could get the CANcardXL from Vector working with Socket=
CAN.=20
> Reading the info for the kernel module 'softing_cs' gave me some hope=
=2E=20
> However, I did not succeed. Here are some details about the hardware:
>=20
> -----

> Type: CANcardXL
> Controller: Phillips SJA 1000 (another small pice of hope, since soft=
ing_cs.c=20
>                                                explicitly lists a 'Ve=
ctor-CANcard-SJA')
> Transceiver: CANcab 251 opto (Highspeed)
>=20
> wusel:~/# pccardctl ident
>=20
> Socket 0:
> product info: "VECTOR
> ", "CANcardXL
> ", "", ""
> manfid: 0x02e6, 0x0100
> -----

I found on
http://vector.com/vi_cancardxl_en.html
that the board has an Atmel ARM7 cpu.
The firmware of the softing driver is targeted for Infineon C166 series
of cpu's.
So, first conclusion is: there's no firmware for that device.
You can load the first 2 firmware blobs, but those are just written
in the cards iomem space and read back, without target acknowledge.
That seems to succeed, so at least the same amount of RAM is present th=
ere.

I have no idea to even investigate if it could work...

Kind regards,
Kurt
