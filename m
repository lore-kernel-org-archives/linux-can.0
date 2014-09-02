From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can: flexcan.c: Correctly initialize mailboxes
Date: Tue, 02 Sep 2014 12:59:42 +0200
Message-ID: <5405A31E.1060403@pengutronix.de>
References: <1409133487-23367-1-git-send-email-david@protonic.nl>	<1409133487-23367-2-git-send-email-david@protonic.nl>	<54059ADC.60309@pengutronix.de> <20140902123725.01808f36@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="H1G9ldHKgTXPLmdVC11kF9QMv3rxFW73c"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43246 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbaIBK7r (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Sep 2014 06:59:47 -0400
In-Reply-To: <20140902123725.01808f36@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: wg@grandegger.com, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H1G9ldHKgTXPLmdVC11kF9QMv3rxFW73c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/02/2014 12:37 PM, David Jander wrote:
> On Tue, 02 Sep 2014 12:24:28 +0200
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
>> On 08/27/2014 11:58 AM, David Jander wrote:
>>> Apparently mailboxes may contain random data at startup, causing some=
 of
>>> them being prepared for message reception. This causes overruns being=

>>> missed or even confusing the IRQ check for trasmitted messages, incre=
asing
>>> the transmit counter instead of the error counter.
>>>
>>> Signed-off-by: David Jander <david@protonic.nl>
>>
>> Before patch
>>
>> 0d1862e can: flexcan: fix flexcan_chip_start() on imx6
>>
>> there was a loop clearing the whole cantxfg register space. But this
>> turned out to be bogus, as message buffers 1...7 are reserved by the
>> FIFO engine and we're not allowed to tough them. This lead to some kin=
d
>> of abort on imx6.
>>
>> You may need this patch once you don't make use of the FIFO engine any=
 more.
>=20
> You will need this patch in either case, but indeed, if you use the FIF=
O, you
> should skip the MB's that are shadowed by the FIFO.

ACK

> If you don't clear the rest of the MB's they may still contain random d=
ata and
> the problem remains.
> IMHO 0d1862e is wrong, since buffers are not in reset default values. T=
here is
> no indication of that in the reference manual, and I have observed that=
 they
> are indeed not cleared after reset.

Yes, 0d1862e was not complete, the initialisation was fixes with:

d5a7b40 can: flexcan: flexcan_chip_start: fix regression,
                       mark one MB for TX and abort pending TX

Which sets FLEXCAN_MCR_MAXMB to 8, which is the only mailbox used for tx
and the code of the tx mailbox is set to 0x4 =3D=3D tx, inactive.

This should be enough in FIFO mode, correct?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--H1G9ldHKgTXPLmdVC11kF9QMv3rxFW73c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQFox4ACgkQjTAFq1RaXHMjKgCfcBUW7DDMVPdGOE+eBV4oDMn/
9tkAniCIw3jwugMkttMAoFovlqqg6T8A
=RbHn
-----END PGP SIGNATURE-----

--H1G9ldHKgTXPLmdVC11kF9QMv3rxFW73c--
