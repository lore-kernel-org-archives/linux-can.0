From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 28 Jun 2012 13:29:19 +0200
Message-ID: <4FEC400F.8010506@pengutronix.de>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org> <1340853701-4488-3-git-send-email-shawn.guo@linaro.org> <4FEC329C.7070004@pengutronix.de> <20120628112111.GC22990@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig20D738577CC6EC46F32DA595"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59388 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219Ab2F1L3a (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 07:29:30 -0400
In-Reply-To: <20120628112111.GC22990@S2101-09.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig20D738577CC6EC46F32DA595
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/28/2012 01:21 PM, Shawn Guo wrote:
> On Thu, Jun 28, 2012 at 12:31:56PM +0200, Marc Kleine-Budde wrote:
>> Hmm I'm wondering if transceiver or phy is the correct name here. In
>> platform_data it's called transceiver_switch.
>=20
> The transceiver_switch in platform_data names a function, while we are
> naming a couple gpios which happen to be access in that function.  It
> looks all correct to me.

I mean which name is more precise, do these gpio enable/standy a "phy"
or a "transceiver". For example:
http://www.nxp.com/documents/application_note/AN00094.pdf, this document
says: TJA1041/1041A high speed CAN transceiver.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig20D738577CC6EC46F32DA595
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/sQBIACgkQjTAFq1RaXHOytwCcCyddOM00qmqbfn7Js9s6D5hf
wmoAn3h4ngGEZYh6vfJisTEv0XnyqFeP
=fuvT
-----END PGP SIGNATURE-----

--------------enig20D738577CC6EC46F32DA595--
