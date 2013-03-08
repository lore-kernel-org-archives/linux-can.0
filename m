From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Informations About CAN API of the Linux Kernel
Date: Fri, 08 Mar 2013 09:55:41 +0100
Message-ID: <5139A78D.9060005@pengutronix.de>
References: <2B7D120CFC15DC438D721B998AD9D9E9097105AB@SEGOTNC5180-N2.vcn.ds.volvo.net> <513763CC.1070507@pengutronix.de> <20130307124012.GC603@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2FINEVHNOCTMRXWQSFXXU"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49022 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451Ab3CHIzu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 Mar 2013 03:55:50 -0500
In-Reply-To: <20130307124012.GC603@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sako Youssouf <youssouf.sako@renault-trucks.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2FINEVHNOCTMRXWQSFXXU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Kurt,

On 03/07/2013 01:40 PM, Kurt Van Dijck wrote:
> On Wed, Mar 06, 2013 at 04:42:04PM +0100, Marc Kleine-Budde wrote:
>> On 03/06/2013 03:51 PM, Sako Youssouf wrote:
>>> I'm an engineer of a French company, Renault Trucks Defense. We are=20
>>> Militaries cars makers. We are currently testing the CAN API of=20
>>> Linux. I found your article "SocketCAN - The official CAN API of the =

>>> Linux kernel" on internet and after reading it I have some=20
>>> questions.
>>
>>
> [...]
>>> And a last question, do you have information about when the Linux
>>> API for SAE J1939 will be available?
>>
>> Kurt (Cc'ed) can probably comment on this.
>=20
> The J1939 API that is available on gitorious[1] is waiting for acceptan=
ce.
> The API has not changed for almost a year now, and is working.
> The J1939 API is quite different from raw CAN, since J1939 adds an
> addressing scheme. This makes it hard for non-J1939 users to
> judge about the usefullness of the API.
> Therefore, it's important that users of the J1939 stack share their
> opinion about it.
> Therefore, also your opinion matters and may contribute to the acceptan=
ce.
> If you find the J1939 stack usefull of course :-)

Would it be possible to add the j1939 support to staging? I mean from
the technical and from the political (is staging reserved for drivers
only?) point of view.

regards,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2FINEVHNOCTMRXWQSFXXU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE5p5EACgkQjTAFq1RaXHO9TQCgickP3/M7bgp0W67B2NShZQxz
gZYAn1GhU7Kk0NS1vGaJkSYq5avax7D0
=BhfI
-----END PGP SIGNATURE-----

------enig2FINEVHNOCTMRXWQSFXXU--
