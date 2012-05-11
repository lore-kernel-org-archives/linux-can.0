From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 3/4] can: c_can: Move overlay structure to array with
 offset as index
Date: Fri, 11 May 2012 18:54:25 +0200
Message-ID: <4FAD4441.3060308@pengutronix.de>
References: <1336649657-4152-1-git-send-email-anilkumar@ti.com> <1336649657-4152-4-git-send-email-anilkumar@ti.com> <4FAC213B.8030404@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13E9BC78B@DBDE01.ent.ti.com> <4FAD24F0.3070600@grandegger.com> <331ABD5ECB02734CA317220B2BBEABC13E9BC9B9@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF7BA14EBDE3DFE9FE3C3DCC2"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49395 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950Ab2EKQyg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 May 2012 12:54:36 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13E9BC9B9@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF7BA14EBDE3DFE9FE3C3DCC2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/11/2012 05:23 PM, AnilKumar, Chimata wrote:
> On Fri, May 11, 2012 at 20:10:48, Wolfgang Grandegger wrote:
>> On 05/11/2012 01:09 PM, AnilKumar, Chimata wrote:
>>> On Fri, May 11, 2012 at 01:42:43, Marc Kleine-Budde wrote:
>>>> On 05/10/2012 01:34 PM, AnilKumar Ch wrote:
>>>>> c_can uses overlay structure for accessing c_can module registers.
>>>>> With this kind of implementation it is difficult to add one more ip=

>>>>> which is similar to c_can in functionality but different register
>>>>> offsets.
>>>>>
>>>>> This patch changes the overlay structure implementation to an array=

>>>>> with register offset as index. This way we can overcome the above
>>>>> limitation.
>>>>
>>>> The array index implementation looks very nice.
>>>>
>>>> I suggest to use the enum instead of a plain "int reg" in the
>>>> c_can_read_* function arguments.
>>>
>>> That is better compared to int reg, I will change.
>>>
>>>>
>>>> General question: What happend to "iface", like in this hunk below?
>>>
>>> In entire driver iface is used as "0" means IF register bank one. So =
I defined
>>> enum like "C_CAN_IF1_*". If IF register bank 2 is used in the driver =
at that
>>> time we can define "C_CAN_IF2_*" and used appropriately.
>>
>> But switching IF1->IF2 would then be awkward. Anyway, at the moment
>> switching seems not required and therefore there is no need to introdu=
ce
>> another array but...
>>
>>>
>>>>
>>>>>  	while (count && priv->read_reg(priv,
>>>>> -				&priv->regs->ifregs[iface].com_req) &
>>>>> +				C_CAN_IF1_COMREQ_REG) &
>>>>>  				IF_COMR_BUSY) {
>>
>> ... what is then "iface" still good for? I see that the functions stil=
l
>> have that argument.
>>
>> Apart from that the patch series look quite good now.
>=20
> How about this implementation?
>=20
> 1. C_CAN_IF2_* will be added to enum next to C_CAN_IF1_* register flags=

>=20
> 2. Add array fields for C_CAN_IF2_* with coresponding offsets.
>=20
> 3. #define IF_ENUM_REG_LEN	11 (eleven interface registers are present)
>=20
> 4. priv->read_reg(priv, C_CAN_IF1_COMREQ_REG + iface * IF_ENUM_REG_LEN)=
;
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

make this a MACRO, taking iface as an argument

> Ultimately 11 * 3 + 1 + few more lines will be added to the patch.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigF7BA14EBDE3DFE9FE3C3DCC2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+tREUACgkQjTAFq1RaXHNIjwCeJ6fHUbzrpZ6e0C7SpiVxdHzq
yR4Ani3EsrZxxmkHLfaq7a4vL0wIqCQT
=Hoa9
-----END PGP SIGNATURE-----

--------------enigF7BA14EBDE3DFE9FE3C3DCC2--
