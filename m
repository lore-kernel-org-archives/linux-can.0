From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: WARNING in can_rcv
Date: Wed, 17 Jan 2018 18:12:57 +0100
Message-ID: <6cc80296-00d2-c144-b571-e803624cc980@pengutronix.de>
References: <001a11c16b40d795350562e878cc@google.com>
 <a48197ff-9270-8af7-a814-56af53093b3c@pengutronix.de>
 <CACT4Y+b0oUPVr7f973ZgBm9rUog=-mRWDFpcr-EzKaGYRnn8mQ@mail.gmail.com>
 <48c5623e-de78-5cfa-b537-2acf9a44ae51@hartkopp.net>
 <20180117071204.GG15527@zzz.localdomain>
 <dd50dd71-d552-1955-ebab-de1982ec9298@hartkopp.net>
 <359313e4-6280-8c97-a424-4f962b11c907@pengutronix.de>
 <c26d5474-d990-65cb-c7dc-27a694ae5245@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="uupP0gMqu9cwMLvzRgAF8FUjDvqKhuYrA"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60385 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbeAQRN3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Jan 2018 12:13:29 -0500
In-Reply-To: <c26d5474-d990-65cb-c7dc-27a694ae5245@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Eric Biggers <ebiggers3@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, syzbot <syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com>, David Miller <davem@davemloft.net>, linux-can@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uupP0gMqu9cwMLvzRgAF8FUjDvqKhuYrA
Content-Type: multipart/mixed; boundary="3aRLwYYkl0FniwGLyGIBIYcCjwewX58eX";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Eric Biggers <ebiggers3@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
 syzbot <syzbot+4386709c0c1284dca827@syzkaller.appspotmail.com>,
 David Miller <davem@davemloft.net>, linux-can@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
 syzkaller-bugs@googlegroups.com
Message-ID: <6cc80296-00d2-c144-b571-e803624cc980@pengutronix.de>
Subject: Re: WARNING in can_rcv
References: <001a11c16b40d795350562e878cc@google.com>
 <a48197ff-9270-8af7-a814-56af53093b3c@pengutronix.de>
 <CACT4Y+b0oUPVr7f973ZgBm9rUog=-mRWDFpcr-EzKaGYRnn8mQ@mail.gmail.com>
 <48c5623e-de78-5cfa-b537-2acf9a44ae51@hartkopp.net>
 <20180117071204.GG15527@zzz.localdomain>
 <dd50dd71-d552-1955-ebab-de1982ec9298@hartkopp.net>
 <359313e4-6280-8c97-a424-4f962b11c907@pengutronix.de>
 <c26d5474-d990-65cb-c7dc-27a694ae5245@hartkopp.net>
In-Reply-To: <c26d5474-d990-65cb-c7dc-27a694ae5245@hartkopp.net>

--3aRLwYYkl0FniwGLyGIBIYcCjwewX58eX
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 01/17/2018 05:29 PM, Oliver Hartkopp wrote:
>> Is this an Acked-by for both patches?
>>
>=20
> Yes :-)
>=20
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Tnx

> I just did not expect that you wanted to update the patches before=20
> sending ...

Why not :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--3aRLwYYkl0FniwGLyGIBIYcCjwewX58eX--

--uupP0gMqu9cwMLvzRgAF8FUjDvqKhuYrA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpfhBkACgkQHv7KIOw4
HPasUAf/cx535btggBGCBHiLiDW3Y+13hPdFv4BKSui3nI0VlvpNveFJqjP0fbDM
8sJJGYPRrv4CqXCyCDa0lr2BV+emO9Bj1auDb8GhNa/ksi3DjC30iN1AerP/vbsX
7J9C0GwYA7FMlH0HLkzVm2Xn51rUB+gKkTD1v+76LbAaG1GpoHR09E4qMt4RcEB2
puaurktx5RxvuDOhrJUT+ZazZ1qRWBrOAY+DsPV20RRQwk04ofHpW3ZsOElhELRD
4b7SDQua7fhVnerAmGD40OLGZEqJk3kPP80MRyRAWSY4UZ3IT43roOJwGZlhz0k8
GbLjo5A91Z2sx9v1ywCjx5ekRA9FUg==
=1+D3
-----END PGP SIGNATURE-----

--uupP0gMqu9cwMLvzRgAF8FUjDvqKhuYrA--
