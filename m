From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: peak_pci: add unused device id. in devices table
Date: Wed, 30 Sep 2015 13:14:58 +0200
Message-ID: <560BC432.2050104@pengutronix.de>
References: <1443609755-29854-1-git-send-email-s.grosjean@peak-system.com>
 <560BC2F8.4040707@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="FEQW2jfDPfdLsr9rFsNane8iCiAHsgK9X"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51766 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326AbbI3LPI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 Sep 2015 07:15:08 -0400
In-Reply-To: <560BC2F8.4040707@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FEQW2jfDPfdLsr9rFsNane8iCiAHsgK9X
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/30/2015 01:09 PM, Marc Kleine-Budde wrote:
> On 09/30/2015 12:42 PM, Stephane Grosjean wrote:
>> While new PEAK_PCIE_OEM_ID has been defined since 3.17, no correspondi=
ng
>> entry has been added in the peak_pci_tbl[] of the peak_pci CAN driver.=

>>
>> This patch enables now users of the PCAN-PCI Express OEM card to run t=
he
>> peak_pci driver too.
>>
>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
>=20
> Thnx, added stable on Cc.

Doh. This somehow got lost.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--FEQW2jfDPfdLsr9rFsNane8iCiAHsgK9X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWC8QyAAoJEP5prqPJtc/HfYIH/RRNcF3FbSgJTF28hToS7eGo
IoBNTRfiKwZ9edBt3+zEDTVDTmJYsAmkRyRTWTPzA2sL11kCpJl0nNDwkq+GGNT6
gkxAysTDkYKodzqHNNXAXnRr7goFjBFb7lnn38xZfI3QKV6rlfhJbCBoHpnx2zyw
/83hS/fs/wFe6o1xfr5cQlmxutvecfdbU26fe46/xDkhTw4b26xsqatgDWa5L4+w
cwLtDRJynLsINk+I2PfRArdKxH04SGJMza4qILwYu7GhWhLmcdZK/3mitIH6cgx2
JTeDXApkPToWz8EH6vvQYTven//NYp9Sz/LSD9DdIUp9y2qw4/+VHiJqmkBRFNo=
=Ha1E
-----END PGP SIGNATURE-----

--FEQW2jfDPfdLsr9rFsNane8iCiAHsgK9X--
