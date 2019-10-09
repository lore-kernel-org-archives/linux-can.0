From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: pull-request: can-next 2019-10-07
Date: Wed, 9 Oct 2019 09:40:38 +0200
Message-ID: <1196c661-5145-4931-031b-13b16249d632@pengutronix.de>
References: <2ffa00e7-d447-9216-587d-30396a47ca64@pengutronix.de>
 <20191008120953.515a3dbd@cakuba.netronome.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="VUbsAWRtBp9W8DFzy5mWxLdBxWS0jO2sD"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191008120953.515a3dbd@cakuba.netronome.com>
Sender: netdev-owner@vger.kernel.org
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, Bastian Stender <bst@pengutronix.de>, Elenita Hinds <ecathinds@gmail.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Maxime Jayat <maxime.jayat@mobile-devices.fr>, Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <ore@pengutronix.de>, David Jander <david@protonic.nl>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VUbsAWRtBp9W8DFzy5mWxLdBxWS0jO2sD
Content-Type: multipart/mixed; boundary="GfjgU16etsgk1AHcE1guZ0fzL3X7cKcIC";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kernel@pengutronix.de,
 linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>,
 Bastian Stender <bst@pengutronix.de>, Elenita Hinds <ecathinds@gmail.com>,
 Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
 Maxime Jayat <maxime.jayat@mobile-devices.fr>,
 Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel
 <ore@pengutronix.de>, David Jander <david@protonic.nl>
Message-ID: <1196c661-5145-4931-031b-13b16249d632@pengutronix.de>
Subject: Re: pull-request: can-next 2019-10-07
References: <2ffa00e7-d447-9216-587d-30396a47ca64@pengutronix.de>
 <20191008120953.515a3dbd@cakuba.netronome.com>
In-Reply-To: <20191008120953.515a3dbd@cakuba.netronome.com>

--GfjgU16etsgk1AHcE1guZ0fzL3X7cKcIC
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 10/8/19 9:09 PM, Jakub Kicinski wrote:
> On Mon, 7 Oct 2019 16:38:14 +0200, Marc Kleine-Budde wrote:
>> Hello David,
>>
>> this is a pull request for net-next/master consisting of 12 patches.
>>
>> The first patch is by Andy Shevchenko for the mcp251x driver and remov=
es
>> the legacy platform data from all in-tree users and the driver.
>>
>> The next two patches target the peak_canfd driver, the first one is by=

>> me and fixes several checkpatch warnings, the second one is by Stephan=
e
>> Grosjean and adds hardware timestamps to the rx skbs.
>>
>> Followed by two patches for the xilinx_can driver. Again the first is =
by
>> me and fixes checkpatch warnings, the second one is by Anssi Hannula a=
nd
>> avoids non-requested bus error frames, which improves performance.
>>
>> Pankaj Sharma's patch for the m_can driver adds support for the one sh=
ot
>> mode.
>>
>> YueHaibing provides a patch for the grcan driver to use
>> devm_platform_ioremap_resource() to simplify code.
>>
>> Joakim Zhang provides a similar patch for the flexcan driver.
>>
>> The last 4 patches are by me and target the rx-offload infrastructure.=

>> The first 3 fix checkpatch warnings, the last one removes a no-op
>> function.
>=20
> Hi Marc,
>=20
> I think the correction should have been s/Substract/Subtract/,
> sorry for the nit pick.

Thanks for noticing that. checkpatch wasn't complaining about my new
typo though :)

> Would you be able to fix that up or do you prefer to do a follow up?

As another patch from the pull request is broken, I've asked David to
not merge it. I've squashed your fix into the original patch.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--GfjgU16etsgk1AHcE1guZ0fzL3X7cKcIC--

--VUbsAWRtBp9W8DFzy5mWxLdBxWS0jO2sD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2djvYACgkQWsYho5Hk
nSDg8wf/YBpCDX9enE+SKB1cCRgc+Am6QaAyPuHl1lX1Je+gIr3GOs88ZDkP8HKS
MfkGbvbkh8ntJlRzZ/6q8yJjIscYmcYlV0Ev14yzvKHJBru2Vn9DXU+uRA8UHhnO
BoZMnBnac5bJS75sJO+BJI96A50YXoQY1pOC0IA/VkTiruV1XrP11q8Vsif7C6KW
3LO+bkIdCzvBUYJyZeUwZ+sgT2J4Z8CEk7GcngGfzKxfs3CBMBbaYPRWHm7KVEiJ
KdKHVEcTo9foBjZQnC5A4MXYEM53HQHfe+df6HzPaJfs4iStfgGVy68pHoLmtyWP
aOvIJdWLoCPdJwAEDFcyIJsV7AhMHA==
=hw2I
-----END PGP SIGNATURE-----

--VUbsAWRtBp9W8DFzy5mWxLdBxWS0jO2sD--
