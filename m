From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: j1939 - first steps
Date: Tue, 19 Mar 2013 07:52:03 +0100
Message-ID: <51480B13.8030102@hartkopp.net>
References: <5147756D.1060203@hartkopp.net> <20130318214145.GA8685@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:21201 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756450Ab3CSGwG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 19 Mar 2013 02:52:06 -0400
In-Reply-To: <20130318214145.GA8685@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 18.03.2013 22:41, Kurt Van Dijck wrote:

> On Mon, Mar 18, 2013 at 09:13:33PM +0100, Oliver Hartkopp wrote:


>> And this (as user):
>>
>> ./jsr -v vcan0:0x22
> you should use 'vcan0:,0x22'.
> The format is: 'IFACE:<NAME>[,<ADDR>]'
> 


./jsr -?
jsr: An SAE J1939 send/recv utility
Usage: jsr [OPTION...] SOURCE [DEST]

  -v, --verbose		Increase verbosity
  -p, --priority=VAL	J1939 priority (0..7, default 6)
  -S, --serialize	Strictly serialize outgoing packets
  -s, --size		Packet size, default autodetected

  SOURCE	[IFACE:][NAME|SA][,PGN]
  DEST			[NAME|SA]

Tells me something else ;-)

Btw. with your hint it works:

./jsr -v vcan0:,0x22
1122334455
112233
123123123123
112233445566778899AABBCCDDEEFF112233

leads to:
$ candump -ta any
 (1363674992.322459)  vcan0  18ECFF22   [8]  20 0B 00 02 FF 00 00 00
 (1363674992.372643)  vcan0  18EBFF22   [8]  01 31 31 32 32 33 33 34
 (1363674992.422713)  vcan0  18EBFF22   [5]  02 34 35 35 0A
 (1363674999.306921)  vcan0  1800FF22   [7]  31 31 32 32 33 33 0A
 (1363675021.549579)  vcan0  18ECFF22   [8]  20 0D 00 02 FF 00 00 00
 (1363675021.599657)  vcan0  18EBFF22   [8]  01 31 32 33 31 32 33 31
 (1363675021.649719)  vcan0  18EBFF22   [7]  02 32 33 31 32 33 0A
 (1363675049.932595)  vcan0  18ECFF22   [8]  20 25 00 06 FF 00 00 00
 (1363675049.982647)  vcan0  18EBFF22   [8]  01 31 31 32 32 33 33 34
 (1363675050.032709)  vcan0  18EBFF22   [8]  02 34 35 35 36 36 37 37
 (1363675050.082781)  vcan0  18EBFF22   [8]  03 38 38 39 39 41 41 42
 (1363675050.132851)  vcan0  18EBFF22   [8]  04 42 43 43 44 44 45 45
 (1363675050.182893)  vcan0  18EBFF22   [8]  05 46 46 31 31 32 32 33
 (1363675050.232954)  vcan0  18EBFF22   [3]  06 33 0A

First time to see j1939 on my linux box, yeah!

Best regards,
Oliver

