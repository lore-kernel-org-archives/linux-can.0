From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: bit-timing and sample point
Date: Thu, 14 Apr 2016 14:57:22 +0200
Message-ID: <570F93B2.1010804@pengutronix.de>
References: <570E205B.7030900@pengutronix.de>
 <20160414102608.GC16018@airbook.vandijck-laurijssen.be>
 <570F7547.8030805@pengutronix.de>
 <20160414121932.GA7409@airbook.vandijck-laurijssen.be>
 <570F8DCA.4090701@pengutronix.de>
 <KL1PR06MB10312DC099D9EE3A19B6B872C3970@KL1PR06MB1031.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="LMAMTtD8rgS1k7x7Mgp1aHInLmkoidtMp"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40118 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755008AbcDNM5e (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Apr 2016 08:57:34 -0400
In-Reply-To: <KL1PR06MB10312DC099D9EE3A19B6B872C3970@KL1PR06MB1031.apcprd06.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LMAMTtD8rgS1k7x7Mgp1aHInLmkoidtMp
Content-Type: multipart/mixed; boundary="5mG89qkchw0dpo5R6D80v8Rl7mOJMeFQT"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
 linux-can <linux-can@vger.kernel.org>
Message-ID: <570F93B2.1010804@pengutronix.de>
Subject: Re: bit-timing and sample point
References: <570E205B.7030900@pengutronix.de>
 <20160414102608.GC16018@airbook.vandijck-laurijssen.be>
 <570F7547.8030805@pengutronix.de>
 <20160414121932.GA7409@airbook.vandijck-laurijssen.be>
 <570F8DCA.4090701@pengutronix.de>
 <KL1PR06MB10312DC099D9EE3A19B6B872C3970@KL1PR06MB1031.apcprd06.prod.outlook.com>
In-Reply-To: <KL1PR06MB10312DC099D9EE3A19B6B872C3970@KL1PR06MB1031.apcprd06.prod.outlook.com>

--5mG89qkchw0dpo5R6D80v8Rl7mOJMeFQT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/14/2016 02:46 PM, Ramesh Shanmugasundaram wrote:
>> Thanks for your thoughts I'll use algorithm 2 then.
>=20
> If not done already, is it worth comparing the algorithm for
> dbitrates (fd case) too as same code is used?

The reworked algorithm will not pick worse values than the original one.
However, I'll update the tool for dbitrates. Are there any common
dbitrates? The array if common bitrates is:

> static unsigned int common_bitrates[] =3D {
> 	1000000,
> 	800000,
> 	500000,
> 	250000,
> 	125000,
> 	100000,
> 	50000,
> 	20000,
> 	10000,
> };

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--5mG89qkchw0dpo5R6D80v8Rl7mOJMeFQT--

--LMAMTtD8rgS1k7x7Mgp1aHInLmkoidtMp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXD5OyAAoJED07qiWsqSVqP6gIAL7ALic4TfwxXuGxqSxbDL6A
xzeBNw45RYCL/doLN+4cjWZ42wMyd8ZRlecyZmdUtsbIgYy3FLg9WkoyzPBH4WNp
mxWtTqF/Rg0tqWi7LniF3k2obNerrcZdE13B7HrvYek0JRjJ6L8y8KgSNrnfcZhQ
1o3AZEHNOWJ7PIul04+ujHJCBs5L3aSKSm7xLMYbCcjL3QEPJnUnsN3iQS3upSZS
ZkU8z+17iYGx4F3XkRNg+iMIFaQQTD9RP2D5Ii4ywlgRVnjdtpHQF5GA/YVzRbQd
+8bMBGPHajxB98FfPi/tXFf3QAAiZE03SK9BlW4zH70Hr3j4rLCbFzwgn0xww5Q=
=eS07
-----END PGP SIGNATURE-----

--LMAMTtD8rgS1k7x7Mgp1aHInLmkoidtMp--
