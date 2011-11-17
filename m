From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [Socketcan-users] Fwd:  sja1000 BasicCAN mode
Date: Thu, 17 Nov 2011 17:28:46 +0100
Message-ID: <20111117162846.GG366@e-circ.dyndns.org>
References: <CAF8b2jKKnpUeq_x8O6V4RfdAK741HuPKTqc=3fNRU6C2SDAJ4A@mail.gmail.com>
 <20111115082136.GB331@e-circ.dyndns.org>
 <B3B3BE5A55ED7743A83865E234A22B1D1B91F2BDC5@SBSPORT.portnet.local>
 <CAF8b2j+8co5T-P0CgPPeq7ViJ4DO4JrTLGj-4Y9bSpKHT7SWyQ@mail.gmail.com>
 <CAF8b2jJ+eqUMEPekbPy9jwRk=5cMtmF0T3TUrj7qex=LT=LoZg@mail.gmail.com>
 <20111117161120.GE366@e-circ.dyndns.org>
 <4EC53531.8050707@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:27806 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223Ab1KQQ2v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Nov 2011 11:28:51 -0500
Content-Disposition: inline
In-Reply-To: <4EC53531.8050707@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Yuriy Kiselev <kiselev.yuriy@gmail.com>, socketcan-users@lists.berlios.de, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Thu, Nov 17, 2011 at 05:24:17PM +0100, Oliver Hartkopp wrote:
> On 17.11.2011 17:11, Kurt Van Dijck wrote:
>=20
> > On Thu, Nov 17, 2011 at 07:58:09PM +0400, Yuriy Kiselev wrote:
> >> 2011/11/15 Heinz-J=C3=BCrgen Oertel <oe@port.de>
> >>
> >> Yes, BasicCAN mode is for specific designed devices. My device has=
 only
> >> 5-bits address bus and I can't use PeliCAN mode.
> > Still, properly attached SJA1000 is better used in PELICAN mode. I'=
m sure
> > you agree.
> >=20
> > But I see your point.
> > Must your hardware be supported by SJA1000?
> > Or by a completely seperate 82c200 driver?
> > You probably can start from the SJA1000.
>=20
>=20
> AFAIK the SJA1000 driver only uses 32 byte of address space - so 5 bi=
t are ok!
>=20
> Even if the address space of the SJA1000 can be 128 bytes in PeliCAN =
mode,
> these addresses beyond register 31 are usually not in use.
> Registers 32 - 127 only contain a view into the internal registers an=
d FIFOs
> nobody is using, as the FIFO is also implemented in the standard RX/T=
X frame
> registers.
>=20
> Please check the SJA1000 spec, page 21/22 (PeliCAN address space layo=
ut)

Not having checked the number 32, you're completely right in that the u=
pper part
of the register map is never accessed.

Regards,
Kurt
