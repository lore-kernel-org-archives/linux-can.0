From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: SocketCAN stops read after RX overflow, is it normal?
Date: Mon, 12 Oct 2015 11:15:40 +0200
Message-ID: <561B7A3C.20500@pengutronix.de>
References: <55E6CCC8.7010908@picquet.fr> <55E80C74.8060600@pengutronix.de>
 <561B69B2.9010804@picquet.fr> <561B7556.3050206@pengutronix.de>
 <561B7781.4040906@picquet.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="SBN10PoD5WI0WfPAwNKwrIwUOxFNxNhSP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36355 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbbJLJPs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 12 Oct 2015 05:15:48 -0400
In-Reply-To: <561B7781.4040906@picquet.fr>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Guillaume Picquet <guillaume@picquet.fr>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SBN10PoD5WI0WfPAwNKwrIwUOxFNxNhSP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2015 11:04 AM, Guillaume Picquet wrote:
> Le 12/10/2015 10:54, Marc Kleine-Budde a =C3=A9crit :
>> On 10/12/2015 10:05 AM, Guillaume Picquet wrote:
>>> I've received a patched firmware from my provider, tested it and so f=
ar
>>> so good.
>> Good to hear that. Can you send the patches or at91_can.c to the list?=

> It's your patch I gave my provider.
>=20
> https://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can-next.git/com=
mit/?h=3Dat91-next&id=3D7234e9dee7d0df75de7ae14443a2306435750594

Ah, good to hear that this works for your usecase aswell. Can I add your
Tested-by Tag to the patch?

>>> I've connected 2 devices (AT91 based) at 1Mb/s.
>>> So far more than 470000000 frames received so far.
>>>   From the user-space point of view it's much better.
>>> Now the only way to know if rx overflow occur is to set SO_RXQ_OVFL
>>> flag, use recvmsg and check ancillary data.
>> No, that's not correct. With SO_RXQ_OVFL you'll detect overflows of th=
e
>> socket. When there are overflows in the hardware the rx overrun in per=

>> device statistics will be increased (see ifconfig) output.
> Ok good to know.
> So your saying that if I receive nothing on a socket with CAN_ERR_MASK =

> set 0x1FFFFFFFU it means that the hardware is handling CAN traffic well=
 !

Yes.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--SBN10PoD5WI0WfPAwNKwrIwUOxFNxNhSP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWG3o8AAoJEP5prqPJtc/HZXoH/2Wsq8lkxLIItAZa7zlJn8YK
5iH4iesaE98Zi5RBJu0teXOYg29npRTdh+2qrpM8fISZHPi0zLjsmKRSkVFIPGaE
k+fstkRsKfZlw8LRbwtcwk8suCt6rt7ks+h6nn5gCJyiF7ZbHiUEaphxOElBMBF6
wfNWPc9z5t15q1loXYzrHPWIinmSsuaMDJCl+nQvcyr0ZC379dsyamlTp+5ixJYO
JORNnr8mLZs99fG60bMe+bMT/DBfcgJyjlaphEqWJk55L9w02BrGcr95blBmcLaw
3RaXGNTyeNkl0VS4Bh7+SmuzbEYuiIJ5pLsZOXjoeQgZN+cturf0CKvbM4IZi6g=
=PwSU
-----END PGP SIGNATURE-----

--SBN10PoD5WI0WfPAwNKwrIwUOxFNxNhSP--
