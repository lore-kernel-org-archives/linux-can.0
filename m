From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: AW: Receiving messages issue
Date: Tue, 25 Jun 2013 15:36:37 +0200
Message-ID: <51C99CE5.7070708@pengutronix.de>
References: <zarafa.51c94a17.775f.288b4f8e69a3abab@v14647.1blu.de> <56720.79.205.48.80.1372161611.squirrel@webmail.rdts.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2GNOUFBUSATCLWRNOMDNU"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53069 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab3FYNgp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 25 Jun 2013 09:36:45 -0400
In-Reply-To: <56720.79.205.48.80.1372161611.squirrel@webmail.rdts.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: info@gerhard-bertelsmann.de
Cc: Michael Luxen <mluxen@gmx.net>, Luka Rahne <luka.rahne@gmail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2GNOUFBUSATCLWRNOMDNU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/25/2013 02:00 PM, Gerhard Bertelsmann wrote:
>>> On 06/24/2013 02:26 PM, Luka Rahne wrote:
>>>> I am using MCP2515 with  i.MX27
>>>
>>> MCP2515 is the second worst CAN hardware I know. Only MCP2510 is wors=
e.

> IMHO the controller isn't bad - it's the host interface (SPI).

I see the CAN controller as a black box, I don't care if it doesn't
perform under Linux due to the host interface or the fact that it has a
rather shallow FIFO.

> The MCP2515 based capes are using the BB SPI bus. As already stated bef=
ore,
> the CAN controller is not read-out fast enough. Root cause of this is m=
ainly
> the latency between MCP2515 interrupt and the SPI commands. I have seen=

> this on different platforms: there are gaps sometimes in the 100usec ra=
nge.
> The BBB is fast but there will be still gaps between MCP2515 attention =
needed
> and SPI transfers and on heavy loaded links there will be reordered pac=
kets
> or packet losts.
> One solution could be running the SPI with higher priority. Second one =
would
> be to tie SPI and MCP2515 driver together, but this is a quite dirty ha=
ck.

You probably don't want to do this.

> But the Beaglebone-CPU has a nifty thing: the PRUSS - 2x200 MHz CPUs
> independantly running from the main CPU. Coupling one or more MCP2515s
> to the appropiate pins could be easily served. The PRUSS doesn't have a=

> hardware SPI interface, but with old school bitbanging you could get  a=
ll
> CAN packets even on fully loaded 1MBit link.

You can port the existing CAN driver (note it's GPL'ed) or write a new
one for the PRUSS and design a proper memory mapped interface interface
to the CPU.

> There is shared memory region between main and PRUSS CPU. Both CPU
> domains could generate an interrupt for the other domain. So the data
> could be easily exchanged - without any lost or reordered packets.

> BTW: Which structure would be the best for this kind of data transfer ?=


IANAL: If you design the PRUSS firmware to be compatible to an existing
driver e.g. a SJA10000 you don't have to write a new driver under Linux.
However I'm not sure about the legal consequences of this.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2GNOUFBUSATCLWRNOMDNU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHJnOUACgkQjTAFq1RaXHO0iwCeLAAWFali+uMaWY7mACarCwv5
2q4AnjRuLL6TA4vo1AGxN1Vgc5/wpuI6
=E1so
-----END PGP SIGNATURE-----

------enig2GNOUFBUSATCLWRNOMDNU--
