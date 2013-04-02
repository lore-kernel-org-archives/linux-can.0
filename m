From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: drivers/net/can/sja1000/peak_pcmcia.c:626:2: error: implicit
 declaration of function 'ioport_unmap'
Date: Tue, 02 Apr 2013 09:51:16 +0200
Message-ID: <515A8DF4.9030504@pengutronix.de>
References: <5152a96f.mjO7hZyAZ4CJtDg3%fengguang.wu@intel.com> <20130327083110.GB11489@localhost> <20130327094135.GB23796@linux-sh.org> <5152C868.5030801@pengutronix.de> <515A8D1C.5010308@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2UBJTRUGUJHKPPOMDGCSM"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47678 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760595Ab3DBHv0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Apr 2013 03:51:26 -0400
In-Reply-To: <515A8D1C.5010308@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2UBJTRUGUJHKPPOMDGCSM
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 04/02/2013 09:47 AM, Stephane Grosjean wrote:
[...]

>>> This would no doubt be due to the defconfig selecting NO_IOPORT. This=

>>> driver probably needs a HAS_IOPORT depends.
>=20
>> Stephane, can we use pcmcia_map_mem_page() instead of ioport_map() lik=
e
>> in the ems_pcmcia driver?
>>
>> http://lxr.free-electrons.com/source/drivers/net/can/sja1000/ems_pcmci=
a.c#L286

> Ok, I'll have a look to that asap.

Fine.

> Meanwhile, adding the HAS_IOPORT depends in
> drivers/net/can/sja1000/Kconfig does the trick. What do you think about=

> that?

Ack, done, already upstream :)

3fd3349 can: sja1000: limit PEAK PCAN-PC Card to HAS_IOPORT

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2UBJTRUGUJHKPPOMDGCSM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFajfcACgkQjTAFq1RaXHPflQCfQI5zYpP90ga46WL0lJ2oN85F
ytkAni5L2rUaVyD/4jJ8C49Ftedz1sCE
=bqTY
-----END PGP SIGNATURE-----

------enig2UBJTRUGUJHKPPOMDGCSM--
