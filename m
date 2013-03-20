From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: j1939 - first steps
Date: Wed, 20 Mar 2013 10:07:41 +0100
Message-ID: <20130320090741.GA420@vandijck-laurijssen.be>
References: <5147756D.1060203@hartkopp.net>
 <20130318214145.GA8685@vandijck-laurijssen.be>
 <51480B13.8030102@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay001.isp.belgacom.be ([195.238.6.51]:58038 "EHLO
	mailrelay001.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750763Ab3CTJHr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Mar 2013 05:07:47 -0400
Content-Disposition: inline
In-Reply-To: <51480B13.8030102@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Tue, Mar 19, 2013 at 07:52:03AM +0100, Oliver Hartkopp wrote:
> On 18.03.2013 22:41, Kurt Van Dijck wrote:
> 
> > On Mon, Mar 18, 2013 at 09:13:33PM +0100, Oliver Hartkopp wrote:
> 
> 
> >> And this (as user):
> >>
> >> ./jsr -v vcan0:0x22
> > you should use 'vcan0:,0x22'.
> > The format is: 'IFACE:<NAME>[,<ADDR>]'
> > 
> 
> 
> ./jsr -?
> jsr: An SAE J1939 send/recv utility
> Usage: jsr [OPTION...] SOURCE [DEST]
> 
>   -v, --verbose		Increase verbosity
>   -p, --priority=VAL	J1939 priority (0..7, default 6)
>   -S, --serialize	Strictly serialize outgoing packets
>   -s, --size		Packet size, default autodetected
> 
>   SOURCE	[IFACE:][NAME|SA][,PGN]
>   DEST			[NAME|SA]
> 
> Tells me something else ;-)

I looked into the parser (can-utils/libj1939.c):
You should have omitted the 0x prefix.
jsr operates in hex (currently) by default.

I'll look for modifying this to be more intuitive.
> 
> Btw. with your hint it works:
> 
> ./jsr -v vcan0:,0x22
Yep, it is equal to './jsr -v vcan0'.
> 1122334455
> 112233
> 123123123123
> 112233445566778899AABBCCDDEEFF112233
> 
> leads to:
> $ candump -ta any
>  (1363674992.322459)  vcan0  18ECFF22   [8]  20 0B 00 02 FF 00 00 00
>  (1363674992.372643)  vcan0  18EBFF22   [8]  01 31 31 32 32 33 33 34
>  (1363674992.422713)  vcan0  18EBFF22   [5]  02 34 35 35 0A
>  (1363674999.306921)  vcan0  1800FF22   [7]  31 31 32 32 33 33 0A
>  (1363675021.549579)  vcan0  18ECFF22   [8]  20 0D 00 02 FF 00 00 00
>  (1363675021.599657)  vcan0  18EBFF22   [8]  01 31 32 33 31 32 33 31
>  (1363675021.649719)  vcan0  18EBFF22   [7]  02 32 33 31 32 33 0A
>  (1363675049.932595)  vcan0  18ECFF22   [8]  20 25 00 06 FF 00 00 00
>  (1363675049.982647)  vcan0  18EBFF22   [8]  01 31 31 32 32 33 33 34
>  (1363675050.032709)  vcan0  18EBFF22   [8]  02 34 35 35 36 36 37 37
>  (1363675050.082781)  vcan0  18EBFF22   [8]  03 38 38 39 39 41 41 42
>  (1363675050.132851)  vcan0  18EBFF22   [8]  04 42 43 43 44 44 45 45
>  (1363675050.182893)  vcan0  18EBFF22   [8]  05 46 46 31 31 32 32 33
>  (1363675050.232954)  vcan0  18EBFF22   [3]  06 33 0A
> 
> First time to see j1939 on my linux box, yeah!
congratulations.
Next step is to use flow control with transport protocol:

$ ./ip addr add dev vcan0 j1939 0x23
$ ./jsr -v vcan0:22,12345 23

And watch the can_id's & timestamps

Kind regards,
Kurt
