From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: janz-ican3: add support for CAL/CANopen firmware
Date: Sat, 2 May 2015 18:42:52 +0200
Message-ID: <5544FE8C.9020100@pengutronix.de>
References: <5543C69C.5060508@gmail.com> <5543E065.6060000@pengutronix.de>
 <20150502164049.GB31242@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="BfBHsU7N4Cg2jffQ9kavAAi1ecM0hx0M4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34373 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbbEBQnE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 2 May 2015 12:43:04 -0400
in-reply-to: <20150502164049.GB31242@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <ira.snyder@gmail.com>
Cc: =?UTF-8?Q?Andreas_Gr=c3=b6ger?= <andreas24groeger@gmail.com>, linux-can@vger.kernel.org, iws@ovro.caltech.edu

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BfBHsU7N4Cg2jffQ9kavAAi1ecM0hx0M4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/02/2015 06:40 PM, Ira W. Snyder wrote:
> On Fri, May 01, 2015 at 10:21:57PM +0200, Marc Kleine-Budde wrote:
>> On 05/01/2015 08:31 PM, Andreas Gr=C3=B6ger wrote:
>>> in our department we are using some older Janz ICAN3-modules in our
>>> dekstop pcs. There we have slightly different carrier boards than the=

>>> janz-cmodio supported in the kernel sources, called CAN-PCI2 with two=

>>> submodules. But the pci configuration regions are identical. So
>>> extending the supported pci devices to the corresponding device ids
>>> is sufficient to get the drivers working. Great.
>>>
>>> I have two minor issues:
>>> * The old ICAN3-modules with firmware 1.28 need more then 250ms for
>>> the restart after reset. I've increased the timeout to 500ms.
>>
>> Should be no problem, as it's a timeout.
>>
>>> * The janz_ican3 module uses the raw can services of the
>>> Janz-firmware, this means firmware must be ICANOS/2. Our
>>> ICAN3-modules are equipped with CAL/CANopen-firmware, so I must use
>>> the appropriate commands for the layer management services.
>>> My proposal: the driver detects the firmware after module reset and
>>> selects the commands matching the firmware. This affects the bus
>>> on/off-command (ican3_set_bus_state) and the configuration of the
>>> bittiming (ican3_set_bittiming). For better diagnostics the detected
>>
>> Is it possible to move the set_bittiming for both firmwares into the
>> ican3_set_bus_state() function? For various reasons I don't like the
>> fact that the bitrate is written into the hardware while the interface=

>> is down.
>>
>>> firmware string is presented as sysfs attribute (fwinfo).
>>
>> Please document the new sysfs entry, see
>> Documentation/ABI/testing/sysfs-platform-at91 as an example. Please be=

>> so kind and document the already existing termination attribute, too.
>>
>>> Currently my system works great. Are there any possibilities to get
>>> my changes into the linux kernel? Here are my changes based on a
>>> linux-3.19.6 vanilla kernel. Is this the right place for my request,
>>> is there any maintainer I can ask? I would be grateful for any help.
>>
>> Ira, can you have a look at the changes and give your Acked-by?
>>
>=20
> Hi Andreas, Hi Marc,
>=20
> The changes look great to me. I no longer work for Caltech, and so I
> don't have access to the hardware to test the changes. They are very
> self contained, and so are unlikely to cause any problems.
>=20
> I have one more nitpick in addition to Marc's, which I added inline
> below.

Good catch.

> Great job on your first patch!

ACK.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--BfBHsU7N4Cg2jffQ9kavAAi1ecM0hx0M4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVRP6PAAoJECte4hHFiupUHX0P/0oQg/3dJjWoQ8dYV0Cgtzwk
KXLpDhVHVHJpc1lXfagxf2IfbgnOzXZ+8hK2LDIiIRFm1NH62bJN3AbQ00310zOw
8UFbXtyCpR38z5dcSkiabo+HOuj469ZauedT0gwoGjyw5UVj76Lf9sKgXDq3Xew7
wSjiY4qeZzo8THNIQq9CgEsbbb4onp+NZU/87URS21Ki51MI5vhllT0HUe/npSrb
AkjfUUZTmnW2W24UxbSSDekj3u9uFYqSbFJJwvun3zltYXy++9W5qtqRWMb6SxqU
BSp34OZzsBnwWxFQ16cy356aXt0yqMU8iEhc+/CXdoVh2s9BOmQIa3mSU2/icQNg
JPVboz3pBMxhuxkev4LbE/h+tEVFjiqD8YAhKszS1oBcg3NaS8WUSgfrFeNdt69P
PvPyhagUB347ojOwXyBsiWnGFMnn+NroA3TJ2EbR3zPz67qMzaRrlza1LyzWbh8m
91D5tZ70/xCgY7wwGhB/7CyefB0TtEF7GyHetf8GFzm8fy/cz26u/niYg/Aa9m7L
uRfMmOt2zt1h/hz8mlXbcAZeCJpXVs5/29JvTJMIp37brSuEmkUfVUd3Qa33OWCU
fEDFMpfgGriz7CsCyh+MVYSAyJHMp6GhNxQn0CR/YFbuIT9FWsD4OZHk8DuHUB73
QFeG/9C4C3fjQrDQcuSj
=ZZZU
-----END PGP SIGNATURE-----

--BfBHsU7N4Cg2jffQ9kavAAi1ecM0hx0M4--
