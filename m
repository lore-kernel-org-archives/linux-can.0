From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Thu, 15 Nov 2012 13:54:20 +0100
Message-ID: <50A4E5FC.5020103@pengutronix.de>
References: <2478881.znSzbTXnK5@uschi> <505777BC.3000705@hartkopp.net> <5058659E.2010804@grandegger.com> <50586A50.5060300@pengutronix.de> <loom.20121114T213201-791@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF03232BEE9FB0585CA2ABEA5"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43087 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767700Ab2KOMy2 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 15 Nov 2012 07:54:28 -0500
In-Reply-To: <loom.20121114T213201-791@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jason White <white_jason_r1@cat.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF03232BEE9FB0585CA2ABEA5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/14/2012 09:48 PM, Jason White wrote:
> Marc Kleine-Budde <mkl <at> pengutronix.de> writes:
>=20
>>
>>
>> We have several customers who asked how to abort pending TX messages,
>> too. Which involves:
>> a) clear the TX-queue in Linux
>> b) clear queue in hardware
>> c) abort currently transmitting CAN frame
>>
>> I think c) would be a usecase of its own, too.
>>
>> Marc
>>
>=20
>=20
> Has there been any more investigation into this tx buffer overflow scen=
ario?
>=20
> I've been working on using SocketCAN interface for the past several mon=
ths. =20
> I have quite a bit of experience with CAN from an embedded perspective =

> (outside of Linux) and even multiple clients accessing a single CAN por=
t. =20
> We have to have a method of flushing the transmit queue because if an E=
CU is=20
> initially alone on the network and goes error passive (no ack), then we=
 want
> to be able to flush the tx queue periodically to prevent stale data on =
the bus.
> Other scenarios have also been listed.
>=20
> Right now we are taking the interface down and then back up and while t=
his=20
> works for a single process using CAN, I don't think it will work well w=
ith=20
> multi-process support.  Would the other processes know that the interfa=
ce=20
> was taken down?  I haven't decided the route we will go, but maybe an=20

If the other process is doing a read, the read will return. I'm not sure
what happens to a write after ifdown/ifup, I think it will fail.

> intermediate layer between SocketCAN and user processes to monitor the =

> flushing.  Does the socket itself have any buffering or are messages=20
> forwarded directly to the driver?
>=20
> Ideally a packet timeout would be implemented in the driver since it kn=
ows=20
> when the last message was transmitted (tx interrupt) and could perform =
the=20
> flush properly.  Has there been any more thought to this scenario?

This is a scenario, I think the first step will be to implement an
"abort currently transmitted frame" callback. Note that not all hardware
supports a tx-complete interrupt. A timeout mechanism can then be
implemented in the framework in a hardware independent way, e.g. if you
extend the currently used can_echo mechanism.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigF03232BEE9FB0585CA2ABEA5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCk5gAACgkQjTAFq1RaXHMpsACggHGlNPLWn2VO1msqVIp4HPsu
YxUAn3twPL2ea2JrLczVSTjEWuYT660Z
=Z4Jz
-----END PGP SIGNATURE-----

--------------enigF03232BEE9FB0585CA2ABEA5--
