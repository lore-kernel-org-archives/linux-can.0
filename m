From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [patch] can: c_can: checking IS_ERR() instead of NULL
Date: Fri, 01 Aug 2014 11:15:05 +0200
Message-ID: <53DB5A99.2050805@pengutronix.de>
References: <20140801085344.GA31702@mwanda> <53DB5770.7040808@pengutronix.de> <20140801091336.GK4804@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Pf0p7oJwQQ55KWFmw9Xk9AeFjjukApSfN"
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20140801091336.GK4804@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, George Cherian <george.cherian@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Thor Thayer <tthayer@altera.com>, Pavel Machek <pavel@denx.de>, Mugunthan V N <mugunthanvnm@ti.com>, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, Wolfram Sang <wsa@sang-engineering.com>, linux-can@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pf0p7oJwQQ55KWFmw9Xk9AeFjjukApSfN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/01/2014 11:13 AM, Dan Carpenter wrote:
> On Fri, Aug 01, 2014 at 11:01:36AM +0200, Marc Kleine-Budde wrote:
>=20
>>> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can=
/c_can/c_can_platform.c
>>> index 5dede6e..109cb44 100644
>>> --- a/drivers/net/can/c_can/c_can_platform.c
>>> +++ b/drivers/net/can/c_can/c_can_platform.c
>>> @@ -280,7 +280,7 @@ static int c_can_plat_probe(struct platform_devic=
e *pdev)
>>> =20
>>>  		priv->raminit_ctrlreg =3D devm_ioremap(&pdev->dev, res->start,
>>>  						     resource_size(res));
>>> -		if (IS_ERR(priv->raminit_ctrlreg) || priv->instance < 0)
>>> +		if (!priv->raminit_ctrlreg || priv->instance < 0)
>>
>> What about using PTR_ERR_OR_ZERO()?
>=20
> No.  It doesn't ever return a PTR_ERR().  Checking for that would just
> introduce a new static checker warning (signs of confusion may indicate=

> buggy code).

Okay, thanks for the clarification.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Pf0p7oJwQQ55KWFmw9Xk9AeFjjukApSfN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPbWp0ACgkQjTAFq1RaXHMqtACeOPtjs7PSSX/tOmwbczmiiFUL
RnwAn31X8p0S1v/AMUESwKvZ1ZkZW8N2
=HWfW
-----END PGP SIGNATURE-----

--Pf0p7oJwQQ55KWFmw9Xk9AeFjjukApSfN--
