From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/3] can: flexcan: Add support for non RX-FIFO
 mode and ERRATA ERR005829
Date: Thu, 09 Apr 2015 18:33:27 +0200
Message-ID: <5526A9D7.8000205@pengutronix.de>
References: <1428593056-13701-1-git-send-email-bhupesh.sharma@freescale.com> <1428593056-13701-3-git-send-email-bhupesh.sharma@freescale.com> <55269D84.1070606@pengutronix.de> <BY1PR0301MB1303A2C667A89188E2E9383B82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com> <55269EDC.7040802@pengutronix.de> <BY1PR0301MB1303BCBCB7BBC7A10409D52E82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com> <5526A4EE.8040401@pengutronix.de> <BY1PR0301MB1303410A178296C5EC58560B82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="g8BaVdPi99P92EwBjoLt40obBXJkWbxL4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46799 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737AbbDIQdl (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Apr 2015 12:33:41 -0400
In-Reply-To: <BY1PR0301MB1303410A178296C5EC58560B82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "bhupesh.sharma@freescale.com" <bhupesh.sharma@freescale.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "Sakar.Arora@freescale.com" <Sakar.Arora@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g8BaVdPi99P92EwBjoLt40obBXJkWbxL4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/09/2015 06:17 PM, bhupesh.sharma@freescale.com wrote:
>> -----Original Message-----
>> From: Marc Kleine-Budde [mailto:mkl@pengutronix.de]
>> On 04/09/2015 05:53 PM, bhupesh.sharma@freescale.com wrote:
>>>> Please look at the mainline commit:
>>>>
>>>> 25e924450fcb can: flexcan: implement workaround for errata ERR005829=

>>>
>>> Hmm.. This looks like a fairly simple ERRATA to be handled w/o Kconfi=
g.
>>> But with the legacy mode support ERRATA, we have completely different=

>>> RX setups for the legacy and FIFO mode.
>>
>> Can you give me link to the "ERRATA ERR005829 (A-008965)" description?=

>>
>> The errata ERR005829 is described here
>> http://cache.freescale.com/files/32bit/doc/errata/IMX6DQCE.pdf and it'=
s
>> fixed by mainline commit:
>>
>>     25e924450fcb can: flexcan: implement workaround for errata ERR0058=
29
>>
>> Is your "ERRATA ERR005829 (A-008965)" something different?
>=20
> Yes. I mixed up the errata numbers in the git log by mistake.
>=20
> Its number A-008965 and is related to LS1021A FlexCAN not being
> able to support RX-FIFO mode.

Do you have a link to the errata? Where's the corresponding kconfig
patch? Why do you have to switch on/off the errata by kconfig? Is there
a LS1021A without the bug?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--g8BaVdPi99P92EwBjoLt40obBXJkWbxL4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVJqnaAAoJECte4hHFiupUBOIP/0eq5oUQJZs6AvT7aatKGsSZ
g6dY2CZLkK4iPChG7hVSh8bKKtsyiSqbkc7PSwd95c1GNjL0m3jOkzjKN7APeP7a
FUQRWl8ck3f3NBJAAGBMBmS9AGfJt7sr3seWiULgatR9poD7e9kaFDzK/no75mkW
BsizQNDsT9zHf6WiKMJ6pLR4gyAOB03kJ5fKgRJTeFrdxW9PzDOv2+k00LlNHpmM
JANpPjijuavBQrRUKVYfmE8q3fn3O/lvvxGsrSb8zkP6cgro7rTI29IDbREzmFjH
sM4QuVa7+UjuC0rcN3N8nC/w1xPZudS7o5iPnvvV7zwFNvI9Fe86OGoDyG113zg3
bYOaoxjc6LoAn/lMRd1qkSZiNlcjDsATLKb4Vt0LKFvDielqkMq4G4HKEtAJzJmc
m+mWS9t3gVrsBszlz8fhD5nT1qYbuwSYAWEnZcLgcXsxK9mbBY0+fPaBvN4kLQf+
aBuNyxwbq5veWWpmqYapfqVUX+g6qBXWhRKuihLr7jo2O17UycXjyncxIBVFiubF
jt0sEJSvL+tP6RtDu1y4I6oz78IPhMUw7UWVGwjpkxX4NxBgzLasdJWj6thEOz73
YpjUDdSvxdegFdc93jOk/F3wl/GMBeyJNWzMywaPsua117Wb+/XYIyDH63qvTauy
qzmT6VfSuqgZAtswpb4Q
=YdDe
-----END PGP SIGNATURE-----

--g8BaVdPi99P92EwBjoLt40obBXJkWbxL4--
