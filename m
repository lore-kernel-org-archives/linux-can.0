From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4 2/2] can: m_can: add Bosch M_CAN controller support
Date: Tue, 15 Jul 2014 11:21:57 +0200
Message-ID: <53C4F2B5.7050704@pengutronix.de>
References: <1405338041-19945-1-git-send-email-b29396@freescale.com> <1405338041-19945-2-git-send-email-b29396@freescale.com> <53C3C97A.7080102@pengutronix.de> <20140715033324.GC21584@shlinux1.ap.freescale.net> <53C4D872.9060707@pengutronix.de> <20140715082637.GA2601@shlinux1.ap.freescale.net> <53C4EA68.5090606@pengutronix.de> <20140715090719.GA3374@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IbkQSVi6T7AiP2lnsO3uJDOPD091WPEvK"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48369 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757709AbaGOJWN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Jul 2014 05:22:13 -0400
In-Reply-To: <20140715090719.GA3374@shlinux1.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, socketcan@hartkopp.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com, varkabhadram@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IbkQSVi6T7AiP2lnsO3uJDOPD091WPEvK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/15/2014 11:07 AM, Dong Aisheng wrote:
> On Tue, Jul 15, 2014 at 10:46:32AM +0200, Marc Kleine-Budde wrote:
>> On 07/15/2014 10:26 AM, Dong Aisheng wrote:
>>>>>>> +static void m_can_read_fifo(const struct net_device *dev, struct=
 can_frame *cf,
>>>>>>> +			    u32 rxfs)
>>>>>>> +{
>>>>>>> +	struct m_can_priv *priv =3D netdev_priv(dev);
>>>>>>> +	u32 flags, fgi;
>>>>>>> +
>>>>>>> +	/* calculate the fifo get index for where to read data */
>>>>>>> +	fgi =3D (rxfs & RXFS_FGI_MASK) >> RXFS_FGI_OFF;
>>>>>>> +	flags =3D m_can_fifo_read(priv, fgi, 0x0);
>>>>>>                                            ^^^
>>>>>>
>>>>>> Can you introduce an enum for the offsets, please adjust the signa=
ture
>>>>>> of m_can_fifo_read() accordingly.
>>>>>>
>>>>>
>>>>> I wonder enum may not be suitable.
>>>>> The Rx Buffer and FIFO Element is as follows:
>>>>>    31 24 23 16 15 8 7 0
>>>>> R0 ESI XTD RTR ID[28:0]
>>>>
>>>> M_CAN_FIFO_ID
>>>>
>>>>> R1 ANMF FIDX[6:0] res EDL BRS DLC[3:0] RXTS[15:0]
>>>>
>>>> M_CAN_FIFO_DLC
>>>>
>>>>> R2 DB3[7:0] DB2[7:0] DB1[7:0] DB0[7:0]
>>>>> R3 DB7[7:0] DB6[7:0] DB5[7:0] DB4[7:0]
>>>>
>>>> M_CAN_FIFO_DATA0
>>>> M_CAN_FIFO_DATA1
>>>>
>>>
>>> You mean as follows?
>>> enum m_can_fifo {
>>>         M_CAN_FIFO_ID =3D 0,
>>>         M_CAN_FIFO_DLC,
>> =3D 0x4,
>>>         M_CAN_FIFO_DATA0,
>> =3D 0x8,
>>>         M_CAN_FIFO_DATA1,
>> =3D 0xc,
>>> };
>>>
>>> static inline u32 m_can_fifo_read(const struct m_can_priv *priv,
>>>                                   u32 fgi, enum m_can_fifo fifo)
>>> {
>>>         return readl(priv->mram_base + priv->mcfg[MRAM_RXF0].off +
>>>                      fgi * RXF0_ELEMENT_SIZE + fifo * 0x4);
>>> }
>>
>> without the * 0x4
>>
>>> id =3D m_can_fifo_read(priv, fgi, M_CAN_FIFO_ID);
>>>
>>> The problem is when adding long frames support, it becomes:
>>> enum m_can_fifo {
>>>         M_CAN_FIFO_ID =3D 0,
>>>         M_CAN_FIFO_DLC,
>>>         M_CAN_FIFO_DATA0,
>>>         M_CAN_FIFO_DATA1,
>>>         ....
>>>         M_CAN_FIFO_DATA15,
>>> };
>>
>> #define M_CAN_FIFO_DATA(n)
>> 	(enum m_can_fifo)(M_CAN_FIFO_DATA_0 + (n) << 2)
>>
>=20
> This is a bit strange using and we may still have to define other M_CAN=
_FIFO_DATAx
> to avoid the enum value exceeds the defined range.
> enum m_can_fifo {
>         M_CAN_FIFO_ID =3D 0,
>         M_CAN_FIFO_DLC =3D 0x4,
>         M_CAN_FIFO_DATA0 =3D 0x8,
>         M_CAN_FIFO_DATA1 =3D 0xc,
> 	....
>         M_CAN_FIFO_DATA15 =3D 0xc,
> };
>=20
> However, actually we will not use them at all after introducing M_CAN_F=
IFO_DATA(n).
> If that, why we still need define them in enum?
>=20
> Comparing to this way, why not simply just do as follows:
> #define M_CAN_FIFO_ID		0x0
> #define M_CAN_FIFO_DLC		0x4
> #define M_CAN_FIFO_DATA(n)	(0x8 + (n) << 2)
>=20
> What do you think?

Looks good.

>=20
>>> But it's useless because we may not use enum to read fifo data anymor=
e.
>>> It's not suitable to read fifo one by one:
>>> m_can_fifo_read(priv, fgi, M_CAN_FIFO_DATA0);
>>> m_can_fifo_read(priv, fgi, M_CAN_FIFO_DATA1);
>>> ..
>>> m_can_fifo_read(priv, fgi, M_CAN_FIFO_DATA15);
>>>
>>>
>>> Instead, we may read data according to real dlc value within a for lo=
op like:
>>> #define M_CAN_FIFO(n)   (n * 0x4)
>>> id =3D m_can_fifo_read(priv, fgi, M_CAN_FIFO(0));
>>> dlc =3D m_can_fifo_read(priv, fgi, M_CAN_FIFO(1));
>>> for (i =3D 0; dlc > 0; dlc -=3D 0x4, i++) {
>>>         ....
>>>         data[i] =3D m_can_fifo_read(priv, fgi, M_CAN_FIFO(i + 2));
>>> }
>>
>> id =3D m_can_fifo_read(priv, fgi, M_CAN_FIFO_ID);
>> dlc =3D m_can_fifo_read(priv, fgi, M_CAN_FIFO_DLC);
>> for (i =3D 0; i <=3D dlc; i++)
>> 	data[i] =3D m_can_fifo_read(priv, fgi, M_CAN_FIFO_DATA(i));
>=20
> Does it work?
> The dlc is in bytes while m_can_fifo_read is read in words.

Doh! probably not :) But should work with something like this:

int len =3D DIV_ROUND_UP(dlc, 4);

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--IbkQSVi6T7AiP2lnsO3uJDOPD091WPEvK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlPE8rUACgkQjTAFq1RaXHNplQCeNYxRP47UhsmVoWHK2yvs+aXQ
yVMAn0kMFlGx2kcuxycQsBnHDqB+1DuA
=iqDg
-----END PGP SIGNATURE-----

--IbkQSVi6T7AiP2lnsO3uJDOPD091WPEvK--
