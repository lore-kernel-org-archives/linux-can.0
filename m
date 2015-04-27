From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/3] can: flexcan: Add support for non RX-FIFO
 mode and ERRATA ERR005829
Date: Mon, 27 Apr 2015 08:45:34 +0200
Message-ID: <553DDB0E.4060205@pengutronix.de>
References: <1428593056-13701-1-git-send-email-bhupesh.sharma@freescale.com> <1428593056-13701-3-git-send-email-bhupesh.sharma@freescale.com> <55269D84.1070606@pengutronix.de> <BY1PR0301MB1303A2C667A89188E2E9383B82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com> <55269EDC.7040802@pengutronix.de> <BY1PR0301MB1303BCBCB7BBC7A10409D52E82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com> <5526A4EE.8040401@pengutronix.de> <BY1PR0301MB1303410A178296C5EC58560B82FB0@BY1PR0301MB1303.namprd03.prod.outlook.com> <5526A9D7.8000205@pengutronix.de> <BY1PR0301MB1303351EFA537E82A02D2FC682E90@BY1PR0301MB1303.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="oFc9bS3KcfvnJ8n8QKi49QPGLeiCnWON0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37968 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbbD0Gpu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 27 Apr 2015 02:45:50 -0400
In-Reply-To: <BY1PR0301MB1303351EFA537E82A02D2FC682E90@BY1PR0301MB1303.namprd03.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "bhupesh.sharma@freescale.com" <bhupesh.sharma@freescale.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "Sakar.Arora@freescale.com" <Sakar.Arora@freescale.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oFc9bS3KcfvnJ8n8QKi49QPGLeiCnWON0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2015 08:38 AM, bhupesh.sharma@freescale.com wrote:
> Hi Marc,
>=20
> Sorry for the late reply.
>=20
>> On 04/09/2015 06:17 PM, bhupesh.sharma@freescale.com wrote:
>>>> From: Marc Kleine-Budde [mailto:mkl@pengutronix.de] On 04/09/2015
>>>> 05:53 PM, bhupesh.sharma@freescale.com wrote:
>>>>>> Please look at the mainline commit:
>>>>>>
>>>>>> 25e924450fcb can: flexcan: implement workaround for errata
>>>>>> ERR005829
>>>>>
>>>>> Hmm.. This looks like a fairly simple ERRATA to be handled w/o
>> Kconfig.
>>>>> But with the legacy mode support ERRATA, we have completely
>>>>> different RX setups for the legacy and FIFO mode.
>>>>
>>>> Can you give me link to the "ERRATA ERR005829 (A-008965)" descriptio=
n?
>>>>
>>>> The errata ERR005829 is described here
>>>> http://cache.freescale.com/files/32bit/doc/errata/IMX6DQCE.pdf and
>>>> it's fixed by mainline commit:
>>>>
>>>>     25e924450fcb can: flexcan: implement workaround for errata
>>>> ERR005829
>>>>
>>>> Is your "ERRATA ERR005829 (A-008965)" something different?
>>>
>>> Yes. I mixed up the errata numbers in the git log by mistake.
>>>
>>> Its number A-008965 and is related to LS1021A FlexCAN not being able
>>> to support RX-FIFO mode.
>>
>> Do you have a link to the errata? Where's the corresponding kconfig
>> patch? Why do you have to switch on/off the errata by kconfig? Is ther=
e a
>> LS1021A without the bug?
>=20
> The errata list is not available for public access on www.freescale.com=
 so far.
> The next version of LS1021A SoC, is fixing this bug and since both are =
supposed
> to be used by customers, the kconfig trick is required to turn-off this=
 handling
> for one version, while keeping it intact for the other.

Sorry, a compile time switch is not an option here. Please configure it
during runtime via the device tree. This can be done by different
compatibles, one for the broken another one for the fixed SoC.

regards,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--oFc9bS3KcfvnJ8n8QKi49QPGLeiCnWON0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVPdsUAAoJECte4hHFiupU4GkP/0MLQWQao47BgFTYO6JCwD/e
Qj+Kso9m6Pr6+e9r+XUH/tmrL0HWrQ8G69fu3MUcRogDGpwaaPdFURyjhT7FMo+w
TuG6qHfO8fi4n9iAe6RYjRczlOJkZPoqT29z5nfW9Kda0daQfnGsU2xBq71SmZEA
LVAewJcUxSpsFRUIbdL7MJCY6LQ9kUCjJAU+6FKZg6zSJvZAtVi8hzf+aGs9dxLg
cSMX08Ib7sVTEHOuEH/aOAQXA/rsSqqtZqK+PFlaXBB0jKppIkm3wgvVM6Vhr2XJ
RC3JdGwdqlhHH5nefFt9QFXyHYX5nGFqendz6lmUFN8BtCJCfgooPH5Y+7n+06k8
0alhNdKK6xFoxcjU1MLtk7wSRcbv5t7fb2QoJx+MlZ0VqzmAlsggr9hR08r5TwpS
u3/hMb7ZqMD+0ERl0AOPWwPJWL4ue8P55D8Bb17HOxVIy41tKY/WIfblAKI4yKbP
w45v6JyGveR3ll9aNdToAx8S60l+5+Gh/h1RLKBvwlQHEzL+3h6zPw2wOlX09zme
A1KqA34pBbX3JdKqLdwogowiAx01YTBULJ7Im3eQornMThWLVE3MTYOg2CRdlLfP
c9m3sebtLVF5wkpV5GFMPzYxXuDr+JiNseDtrIXrttVPBPkeeQ9fgCe+9yrXTVic
OiczOWeZWIFKwHkKufQx
=0OZW
-----END PGP SIGNATURE-----

--oFc9bS3KcfvnJ8n8QKi49QPGLeiCnWON0--
