From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Socketcan-users] AM335x CAN/D_CAN
Date: Wed, 23 May 2012 09:05:09 +0200
Message-ID: <4FBC8C25.3050107@pengutronix.de>
References: <CAHvj1qbb9YJSBLZc1bG6MpEJcjPUtr+37wn3iJUNm_OmpH2SgA@mail.gmail.com> <4FBBE272.5020807@grandegger.com> <331ABD5ECB02734CA317220B2BBEABC13E9C2E10@DBDE01.ent.ti.com> <4FBC8B5D.7000302@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig01F2AB2A55DD3EEFE18282ED"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33558 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab2EWHFX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 May 2012 03:05:23 -0400
In-Reply-To: <4FBC8B5D.7000302@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "AnilKumar, Chimata" <anilkumar@ti.com>, bruce bushby <bruce.bushby@gmail.com>, Linux-CAN <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig01F2AB2A55DD3EEFE18282ED
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/23/2012 09:01 AM, Wolfgang Grandegger wrote:
> On 05/23/2012 08:56 AM, AnilKumar, Chimata wrote:
>> Hi Wolfgang,
>>
>> On Wed, May 23, 2012 at 00:31:06, Wolfgang Grandegger wrote:
>>> Hello,
>>>
>>> I switched the discussion to the new Linux-CAN mailing list.
>>>
>>> On 05/22/2012 05:50 PM, bruce bushby wrote:
>>>> Greetings
>>>>
>>>> I'm hoping a list member would be so kind as to offer some basic
>>>> explanations of how one would use the CAN bus provided by AM335x. I
>>>> understand Linux, but struggle with electronics.
>>>>
>>>> I have read this discussion: http://comments.gmane.org/gmane.linux.c=
an/1142
>>>> What is the difference between C_CAN and D_CAN?
>>>
>>> As I see it, the D_CAN is a more advanced variant of the C_CAN
>>> controller. See also:
>>>
>>> http://www.semiconductors.bosch.de/en/ipmodules/can/canipmodules/c_ca=
n/c_can.asp
>>> http://www.semiconductors.bosch.de/en/ipmodules/can/canipmodules/d_ca=
n/d_can.asp
>>>
>>> Patches to add D_CAN support to the Linux-CAN C_CAN driver have been
>>> posted recently for mainline inclusion and are currently reviewed.
>>
>> Is there a possibility of pushing my driver into 3.5 kernel?
>=20
> Yes, I think we should push it forward, even if the C_CAN part remains
> untested for the moment. IIRC, the patch series is already in a good
> shape. I personally do also not have a board with a C_CAN controller at=

> hand. Marc, what is your opinion?

I don't have any of the *_CAN hardware. But the driver looks quite good.
I'm quite busy at the moment, but currently we've the merge window. I'll
do a review now, anyway. Wolfgang can I have your Acked-by?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig01F2AB2A55DD3EEFE18282ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+8jCwACgkQjTAFq1RaXHO3ewCghfMKHTpllO7B5DGjPLcPPZgb
uuIAn2q09GtlTI/gHQOPrH3+oVBYITe3
=btcy
-----END PGP SIGNATURE-----

--------------enig01F2AB2A55DD3EEFE18282ED--
