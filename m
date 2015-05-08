From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Raw CAN socket support in LXC?
Date: Fri, 8 May 2015 13:54:35 +0200
Message-ID: <554CA3FB.6070307@pengutronix.de>
References: <554C6FDE.6080706@actia.se> <554C73C8.5070705@pengutronix.de>
 <554C7790.1000302@actia.se> <554C79D4.8000901@pengutronix.de>
 <554C9B67.1030201@actia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="OV4IBuLejqH4mI2w7X2iE2hOvuuLd7E96"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35136 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbbEHLyr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 May 2015 07:54:47 -0400
in-reply-to: <554C9B67.1030201@actia.se>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Ernberg <john.ernberg@actia.se>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: =?UTF-8?Q?Adam_Engstr=c3=b6m?= <adam.engstrom@actia.se>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OV4IBuLejqH4mI2w7X2iE2hOvuuLd7E96
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/08/2015 01:17 PM, John Ernberg wrote:
> On 2015-05-08 10:54, Marc Kleine-Budde wrote:
>> On 05/08/2015 10:45 AM, John Ernberg wrote:
>>> Our main use-case is to prevent a possible misbehaving application to=

>>> bring down the entire system through memory leaks, crashes etc.
>>> At this time we have not considered any filtering or blocking of dire=
ctions.
>> Can you see the your CAN interface inside of the LXC container? Or are=

>> the RAW sockets the problem?
>>
>> Marc
>>
>> btw: you can use systemd to do memory limiting, too. It makes use of t=
he
>> same feature in the kernel (cgroups).
>>
> Hi
>=20
> With the experimenting I have been able to do on an Ubuntu 14.04 LTS=20
> computer, I cannot find any CAN or virtual CAN interfaces inside the=20
> container.
> When I change the config to specifically forward CAN interfaces, like t=
his:
> lxc.network.type =3D can
> lxc.network.link =3D lxcbr0
> lxc.network.flags =3D up
> lxc.network.hwaddr =3D 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00

You're probably following an ethernet example here, right? So let's
first figure out, that lxc does in the background and see how this
translates into the CAN world.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--OV4IBuLejqH4mI2w7X2iE2hOvuuLd7E96
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVTKP7AAoJECte4hHFiupUNAoP/jh46X5rq/iOEuEvgvKIpduW
f5vVp04udEEhxeNqZkhawYDPsAZZ6OM38C+Il3FnujbGdlDasvAJ5TBKLohYOGNv
Uz0hetL1cPgb8ATcttDf6+8AGRbmWmsr3eiic8yRuzd/MQFH7JKuJDMe4Ctblmdk
3mrVhAG9nr/DtwWpIbCnMVtu8tzZx+QZGnrUykNOaicun3vLpEOfHYYkdz1ihmSX
oYSQCouItr3nwfewOiOxBYc+4QoP8QIcqaCzG/U97l0k1lx5bDg9jKDYoQtCSygZ
RBrOfmYwwfOeAKQEEHnG8LDL+30SLIL8YljfpERu6HSmJe21yfizNXOn6f9LkNb6
Ba3ESmzH1f5usGRF3L6yBRCuroFqYQyjsoz36maRt8yO+dj9hZ+kHocPdpIFaxI2
omlH4qDNQR5WbdfBOnCJJW3pswU4o0QPi9G479PpueKGhCVJvAtKNqBydT0b1Kd2
Qv2rnHdJUY12acFEVAioQjK6YzuuGGW2OPpoZ5DAyP+bKzp0szNxNGCfsGCkc+ZH
cIWpHkMGFdeKXpmt2BcUYATgKdXDIeBcDXSi4R86yHDB8qxuvZ+1jQR1RBS6BA/U
F1ngATTN4BvFxaDnsaJcni6slqrztvJTpHhpfS5Gnq90cD0DMcaSmgRhgartATR6
QNEhj+kEC1tjf2WJhWZx
=Y8Kg
-----END PGP SIGNATURE-----

--OV4IBuLejqH4mI2w7X2iE2hOvuuLd7E96--
