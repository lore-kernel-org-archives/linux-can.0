From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can: m_can: add Bosch M_CAN controller support
Date: Thu, 03 Jul 2014 11:20:27 +0200
Message-ID: <53B5205B.2060206@pengutronix.de>
References: <1403863246-18822-1-git-send-email-b29396@freescale.com> <1403863246-18822-2-git-send-email-b29396@freescale.com> <53ADB1E8.1030504@hartkopp.net> <20140630082622.GB25689@shlinux1.ap.freescale.net> <53B4473B.2050003@hartkopp.net> <53B459C3.6070807@pengutronix.de> <20140703034839.GA20450@shlinux1.ap.freescale.net> <53B50271.8070307@pengutronix.de> <20140703084803.GA11012@shlinux1.ap.freescale.net> <53B51CA4.3060203@pengutronix.de> <20140703090957.GA26480@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="McWt7dqme4G9Rc4DvAfP9mQ08TVpBEb2V"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50231 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754853AbaGCJUp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Jul 2014 05:20:45 -0400
In-Reply-To: <20140703090957.GA26480@shlinux1.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dong Aisheng <b29396@freescale.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, wg@grandegger.com, devicetree@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--McWt7dqme4G9Rc4DvAfP9mQ08TVpBEb2V
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2014 11:09 AM, Dong Aisheng wrote:
> On Thu, Jul 03, 2014 at 11:04:36AM +0200, Marc Kleine-Budde wrote:
>> On 07/03/2014 10:48 AM, Dong Aisheng wrote:
>>> On Thu, Jul 03, 2014 at 09:12:49AM +0200, Marc Kleine-Budde wrote:
>>>> On 07/03/2014 05:48 AM, Dong Aisheng wrote:
>>>>> On Wed, Jul 02, 2014 at 09:13:07PM +0200, Marc Kleine-Budde wrote:
>>>>>> On 07/02/2014 07:54 PM, Oliver Hartkopp wrote:
>>>>>>> I'm not really familiar with the naming concept in device trees.
>>>>>>>
>>>>>>> What is your opinion about the remarks below?
>>>>>>
>>>>>> The entries in the DT, at least on freescale baords, follow the na=
ming
>>>>>> scheme of the reference manual. E.g. on the mx25 it's can1 and can=
2:
>>>>>>
>>>>>>     can1: can@43f88000 { ... }
>>>>>>     can2: can@43f8c000 { ... }
>>>>>>
>>>>>> And on the mx28, its:
>>>>>>
>>>>>>     can0: can@80032000 { ... }
>>>>>>     can1: can@80034000 { ... }
>>>>>>
>>>>>> Because the imx25 datasheet uses a "1" based counting scheme, whil=
e the
>>>>>> imx28 uses a "0" based one.
>>>>>>
>>>>>> So it's best practise to follow the naming and numbering scheme of=
 the
>>>>>> hardware reference manual.....and if you have access to the
>>>>>> documentation of the m_can core, use clock names of the m_can core=
 for
>>>>>> the clock-names property.
>>>>>>
>>>>>
>>>>> Based on my knowledge, device tree allows define phandle name accor=
ding to
>>>>> the real device name of HW according spec while the device node nam=
e should
>>>>> be general(e.g can@80032000 rather than flexcan@80032000).
>>>>> For imx6sx, there are already following entries in
>>>>> arch/arm/boot/dts/imx6sx.dtsi
>>>>> flexcan1: can@02090000 {...}
>>>>> flexcan2: can@02094000 {...}
>>>>> So i'd prefer to define as:
>>>>> m_can1: canfd@020e8000 {...}
>>>>> m_can2: canfd@020f0000 {...}
>>>>>
>>>>>
>>>>> One problem is there're can alias already.
>>>>> aliases {
>>>>> 	can0 =3D &flexcan1;
>>>>> 	can1 =3D &flexcan2;
>>>>> 	...
>>>>> }
>>>>> I'm not sure adding can2&can3 for mcan is properly:
>>>>> aliases {
>>>>> 	can0 =3D &flexcan1;
>>>>> 	can1 =3D &flexcan2;
>>>>> 	can2 =3D &m_can1;
>>>>> 	can3 =3D &m_can2;
>>>>> 	...
>>>>> }
>>>>> Since the m_can driver does not need to use aliases,
>>>>> so i will not add them.
>>>>
>>>> IMHO It's fine too add the can{2,3} aliases to m_can, too.
>>>>
>>>
>>> I think the main problem for doing this way is that the meaning of id=

>>> return by of_alias_get_id may be not persistent.
>>> e.g
>>> For MX6SX
>>> aliases {
>>> 	can0 =3D &flexcan1;
>>> 	can1 =3D &flexcan2;
>>> 	can2 =3D &m_can1;
>>> 	can3 =3D &m_can2;
>>> 	...
>>> }
>>>
>>> For other platform, it could be:
>>> aliases {
>>> 	can0 =3D &m_can1;
>>> 	can1 =3D &m_can2;
>>> 	...
>>> }
>>> It's hard for driver to use.
>>
>> The driver doesn't make use of it, does it?
>>
>>> And actually the M_CAN driver does not need to use the alias.
>>> So i wonder if it makes sense to add the alias for m_can devices
>>> like that.
>>
>> For example the imx53 has two different SPI units, in the alias sectio=
n
>> we see:
>>
>>                 spi0 =3D &ecspi1;
>>                 spi1 =3D &ecspi2;
>>                 spi2 =3D &cspi;
>=20
> Thanks for the info.
> I'm not clear what's our purpose adding alias like this?
> Can you help explain it a bit?

You can use the alias in your dts to refer to the node instead of the
more complicate name. Further you bring a order to all devices of the
same type and you can make use of the number in the alias for other
purposes, which is however not used for CAN afaik.

> Do we need adding alias for all exist devices?

Have a look at the existing imx*.dtsi files. If there are already
aliases for a given device type, then it makes sense to add new devices
of that type to the alias aswell.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--McWt7dqme4G9Rc4DvAfP9mQ08TVpBEb2V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlO1IFsACgkQjTAFq1RaXHNHpACfc8ePUdtEtJRcRYJiASkANCN2
EcYAn1xFuhQ9n0rn632FC85LJSCvZznY
=Us47
-----END PGP SIGNATURE-----

--McWt7dqme4G9Rc4DvAfP9mQ08TVpBEb2V--
