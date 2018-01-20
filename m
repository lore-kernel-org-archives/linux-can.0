From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939 ACL
Date: Sat, 20 Jan 2018 22:07:53 +0100
Message-ID: <20180120210753.GA3515@airbook.vandijck-laurijssen.be>
References: <20180118094040.tkfgprblq5zxrzin@pengutronix.de>
 <a27d8272-a796-2261-449e-1407158566c3@smile.fr>
 <b9c1932d-70b8-f5c3-836b-3fb9cd6206a0@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:40673 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756695AbeATVH5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 20 Jan 2018 16:07:57 -0500
Content-Disposition: inline
In-Reply-To: <b9c1932d-70b8-f5c3-836b-3fb9cd6206a0@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Patrick Menschel <menschel.p@posteo.de>
Cc: linux-can@vger.kernel.org

> 
> > Here is an example of Address Claim sequence where device
> > AAAAAAAAAAAAAAAA enters the network and device BBBBBBBBBBBBBBBB
> > already have address 0xAA:
> >
> > (1516110467.317706) can0 18EAFFFE#00EE00 ------------> Device
> > AAAAAAAAAAAAAAAA asks for addresses of all other devices on the network
> > (1516110467.329943) can0 18EEFFAA#BBBBBBBBBBBBBBBB --> Device
> > BBBBBBBBBBBBBBBB says it has address 0xAA
> > (1516110468.568107) can0 18EEFFAA#AAAAAAAAAAAAAAAA --> Device
> > AAAAAAAAAAAAAAAA claims address 0xAA. That is allowed because his
> > device name has an higher priority.
> > (1516110468.576132) can0 18EEFFAB#BBBBBBBBBBBBBBBB --> Device
> > BBBBBBBBBBBBBBBB claims another address.
> >
> Hi,
> 
> it should be pointed out that address claiming has some caveats.
> 
> Like with the CAN ID the NAME with more leading zeros wins thus
> "BBBBBBBBBBBBBBBB" looses to "AAAAAAAAAAAAAAAA" but there is also the
> "arbitrary_address_capable" flag (the last bit) and "AAAAAAAAAAAAAAAA"
> does not have that flag set.
> 
> Thus "AAAAAAAAAAAAAAAA" would claim the source address 0xAA regardless
> of NAME priority.
> "BBBBBBBBBBBBBBBB" has the "arbitrary_address_capable" flag set und can
> solve the source address conflict by moving on to another source address.
> 
> IMHO in case you have a NAME with lower priority but without
> "arbitrary_address_capable" flag, it would actually win against a higher
> priority NAME that has the "arbitrary_address_capable" flag set.

If I'm not mistaken, the 'arbitrary_address_capable' flag is the most
significant bit. Do note that j1939 is written as a little-endian
system. the 64bit NAME should be read little-endian too!

Kurt


