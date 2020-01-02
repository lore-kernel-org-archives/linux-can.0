From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
Date: Thu, 2 Jan 2020 17:16:15 +0100
Message-ID: <19a2019d-da91-082d-b533-5513748f604a@pengutronix.de>
References: <20191209192440.998659-1-sean@geanix.com>
 <d58b9d08-dbd8-b73e-dae1-286c1a3ce8f2@pengutronix.de>
 <973df29f-c930-c6b2-17c4-3e3b468f3bf0@geanix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Gus2kdPU7NEdZpzLLlT2Yzd5W7h5PPhGy"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <973df29f-c930-c6b2-17c4-3e3b468f3bf0@geanix.com>
Sender: stable-owner@vger.kernel.org
To: Sean Nyekjaer <sean@geanix.com>, linux-can@vger.kernel.org
Cc: dmurphy@ti.com, martin@geanix.com, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Gus2kdPU7NEdZpzLLlT2Yzd5W7h5PPhGy
Content-Type: multipart/mixed; boundary="em2waUGH8Yze3JqQSAEFSPXlv69CydNm6";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Sean Nyekjaer <sean@geanix.com>, linux-can@vger.kernel.org
Cc: dmurphy@ti.com, martin@geanix.com, stable@vger.kernel.org
Message-ID: <19a2019d-da91-082d-b533-5513748f604a@pengutronix.de>
Subject: Re: [PATCH v2 1/2] can: m_can: tcan4x5x: put the device out of
 standby before register access
References: <20191209192440.998659-1-sean@geanix.com>
 <d58b9d08-dbd8-b73e-dae1-286c1a3ce8f2@pengutronix.de>
 <973df29f-c930-c6b2-17c4-3e3b468f3bf0@geanix.com>
In-Reply-To: <973df29f-c930-c6b2-17c4-3e3b468f3bf0@geanix.com>

--em2waUGH8Yze3JqQSAEFSPXlv69CydNm6
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 1/2/20 5:09 PM, Sean Nyekjaer wrote:
> Sorry if this was a bit of mess :)
> Version 6 of this patch is already applied....
> https://www.spinics.net/lists/linux-can/msg03186.html

I know, and I just send it out in a pull request. :D

> Do you want me to add more error handling than this?

So far I've no more comments, besides the ones I've send earlier today:

https://lkml.org/lkml/2020/1/2/197
https://lkml.org/lkml/2020/1/2/229
https://lkml.org/lkml/2020/1/2/296

If you want to contribute, please coordinate with Dan here. I think
we'll roll the changes via can-next.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--em2waUGH8Yze3JqQSAEFSPXlv69CydNm6--

--Gus2kdPU7NEdZpzLLlT2Yzd5W7h5PPhGy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl4OF08ACgkQWsYho5Hk
nSBRPQgArz65f8ckxt3zQ/IaOVuM72TEVaBy9vBFnIxU8a+A00swcxe8Zzd7oLUE
j+t+xj3SKLQWhTQRJWQOzXlcjU1Qr/gXLncswi97B1esB7JDRxn3vZzQTQbsYjha
VnCiYmjFbMgCjIpm1/ZPFSZFQsebQzh1UqmB+BkU819H2YSt1YwnjZpkcY+emwXd
gw+wX3O+m8H9DkzHbUSfSr1+5eSYc/qZhRTA/wYBQ3zm8uQA49ez0nXNOrVggCai
3cS7pR3iIAyiTNS5d8tJ/3KGm11gJnZLjRlGo5GDIup3XdaQOHxCsEGwhECkrEmb
ebT4S5kUi7VsHOR0icN3rJhnnGETtg==
=Q7a6
-----END PGP SIGNATURE-----

--Gus2kdPU7NEdZpzLLlT2Yzd5W7h5PPhGy--
