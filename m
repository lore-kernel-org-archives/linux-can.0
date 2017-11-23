From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 1/4] Documentation : can : flexcan : Add big-endian
 property to device tree
Date: Thu, 23 Nov 2017 13:30:40 +0100
Message-ID: <e7846f79-f790-5ce2-727c-0b2e0a085aaa@pengutronix.de>
References: <1511430935-29783-1-git-send-email-pankaj.bansal@nxp.com>
 <f859951e-072f-499b-5e86-1aaeb789a549@pengutronix.de>
 <AM0PR0402MB3940CFEA5C70EE517E553CDBF1210@AM0PR0402MB3940.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7sTvNF2wWEC4mpTOhwNvmvIcMVQ1HqAq1"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AM0PR0402MB3940CFEA5C70EE517E553CDBF1210-mYCQpYF9suc3mfjNbz3WnI3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>, "wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org" <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Varun Sethi <V.Sethi-3arQi8VN3Tc@public.gmane.org>, Poonam Aggrwal <poonam.aggrwal-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7sTvNF2wWEC4mpTOhwNvmvIcMVQ1HqAq1
Content-Type: multipart/mixed; boundary="lh7U3UnGj1tqTu3q6UNHrjUBDInBp9mHn";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Pankaj Bansal <pankaj.bansal-3arQi8VN3Tc@public.gmane.org>,
 "wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org" <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>,
 "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
 "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Varun Sethi <V.Sethi-3arQi8VN3Tc@public.gmane.org>, Poonam Aggrwal <poonam.aggrwal-3arQi8VN3Tc@public.gmane.org>
Message-ID: <e7846f79-f790-5ce2-727c-0b2e0a085aaa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 1/4] Documentation : can : flexcan : Add big-endian
 property to device tree
References: <1511430935-29783-1-git-send-email-pankaj.bansal-3arQi8VN3Tc@public.gmane.org>
 <f859951e-072f-499b-5e86-1aaeb789a549-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
 <AM0PR0402MB3940CFEA5C70EE517E553CDBF1210-mYCQpYF9suc3mfjNbz3WnI3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
In-Reply-To: <AM0PR0402MB3940CFEA5C70EE517E553CDBF1210-mYCQpYF9suc3mfjNbz3WnI3W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>

--lh7U3UnGj1tqTu3q6UNHrjUBDInBp9mHn
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/23/2017 01:08 PM, Pankaj Bansal wrote:
>> This and the other series have to be applied in the correct order, oth=
erwise
>> you break bisectability when removing the "fsl,p1010-flexcan"
>> from the mx{25,35,53} devicetree before adding the compatible to the d=
river.
>> Maybe merge these two series?
>>
>=20
> Can we merge these 2 series ? one set of changes are in net/can
> directory which is managed in can-next branch. Other set of changes
> are in device tree which is managed in dt-next branch. I thought both
> these branches are independently updated and then all these branches=20
> are merged in linux-next.

They are independently managed, but the changes are not independent.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--lh7U3UnGj1tqTu3q6UNHrjUBDInBp9mHn--

--7sTvNF2wWEC4mpTOhwNvmvIcMVQ1HqAq1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloWv3AACgkQHv7KIOw4
HPbdRQf+J3HjPgfFam+WulPCNrxYbEu6WfGy/hIKE3ENBVVJ6M6p1Lp6HFZg5+Jb
2n4es5rafw4/dr+bKwfDiV/+DBqxW371p+NU1vp7ucY7h4vNw5dj1WTRvi+rBCRm
GUg6WhE8UAm2EWxHp/bj1UL9HOkDcRJCr+CXl9rBfHYf8dz+NeIMSr6+Rnc0VhuH
hNV/db16WX7fFeCJsUzgYHjOhzxHUmA+tGsEbJ/TuwTGr/o9J41rUYnzbzWN4HJq
UCgi5jooqBiNbn5ZZK+afukRQuLMOzH/tu7A+HE7lno0gjTXUr/PF5uL/mqptE1p
X99yW189nnoWe+4XdPQlg9jtCUDXyQ==
=iB6L
-----END PGP SIGNATURE-----

--7sTvNF2wWEC4mpTOhwNvmvIcMVQ1HqAq1--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
