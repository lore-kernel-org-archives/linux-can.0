From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/3] can: c_can: Add support for Bosch D_CAN controller
Date: Tue, 24 Apr 2012 10:36:26 +0200
Message-ID: <4F96660A.1030408@pengutronix.de>
References: <1334915902-30253-1-git-send-email-anilkumar@ti.com> <4F965FF6.2020201@pengutronix.de> <4F9664E9.6000403@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB5ACF25DEBDB3B7DCB47D090"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54732 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932065Ab2DXIgg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Apr 2012 04:36:36 -0400
In-Reply-To: <4F9664E9.6000403@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: AnilKumar Ch <anilkumar@ti.com>, linux-can@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB5ACF25DEBDB3B7DCB47D090
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/24/2012 10:31 AM, Wolfgang Grandegger wrote:
> On 04/24/2012 10:10 AM, Marc Kleine-Budde wrote:
>> On 04/20/2012 11:58 AM, AnilKumar Ch wrote:
>>> This patch adds the support for D_CAN controller driver to the existi=
ng
>>> C_CAN driver.
>>>
>>> Bosch D_CAN controller is a full-CAN implementation which is complian=
t
>>> to CAN protocol version 2.0 part A and B. Bosch D_CAN user manual can=
 be
>>> obtained from: http://www.semiconductors.bosch.de/media/en/pdf/
>>> ipmodules_1/can/d_can_users_manual_111.pdf
>>>
>>> The following are the design choices made while adding D_CAN to C_CAN=

>>> driver:
>>> A new overlay structure is added for d_can controller and care is tak=
en
>>> to make sure its member names match with equavalent c_can structure
>>> members (even if the d_can specification calls them slightly differen=
tly).
>>> Note that d_can controller has more registers, so structure members o=
f
>>> d_can are more than those in c_can.
>>>
>>> A new set if read/write macros are used to access the registers commo=
n
>>> between c_can and d_can. To get the basic d_can functionality working=

>>> it is sufficient to access just these registers.
>>
>> I don't like macros. I've two further possible solutions:
>=20
> Yes, I don't like that part either, also because of the
>=20
>   "if (priv->dev_type =3D=3D DEV_TYPE_D_CAN)"
>=20
> for each read/write access.
>=20
>> a) Access the registers via an array. The array index is a "virtual"
>>    register, the array's value the physical offset within the c_can or=

>>    d_can controller.
>=20
> I was thinking about that as well but using absolute addresses. This
> would avoid further calculations for 16/32 bit aligned accesses.

Yes, this way we might get rid of this calculation, too.

>> b) AFAICS you need more than three registers to get the CAN core
>>    working. Another possibility is to implement an accessor function
>>   for each register.
>=20
> ... offsetof() might be useful for this approach.

Please elaborate.

>> Other, hopefully better, solutions are open for discussion.
>=20
> The solutions above are not really elegant, but so far I do not have
> better ideas.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigB5ACF25DEBDB3B7DCB47D090
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+WZg4ACgkQjTAFq1RaXHMv+gCeIcO2S5aFVyJc7MjphYpvwdJg
tf0An0Mw/SMAVU67lhfHuYmX7JJD+/YS
=ZNtj
-----END PGP SIGNATURE-----

--------------enigB5ACF25DEBDB3B7DCB47D090--
