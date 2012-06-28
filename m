From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] net: flexcan: add transceiver switch gpios support
Date: Thu, 28 Jun 2012 14:10:21 +0200
Message-ID: <4FEC49AD.1000609@pengutronix.de>
References: <1340853701-4488-1-git-send-email-shawn.guo@linaro.org> <1340853701-4488-3-git-send-email-shawn.guo@linaro.org> <4FEC329C.7070004@pengutronix.de> <20120628112111.GC22990@S2101-09.ap.freescale.net> <4FEC400F.8010506@pengutronix.de> <20120628114108.GD22990@S2101-09.ap.freescale.net> <20120628120835.GA3402@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBDDB95F1DFE53ECF0BAF601D"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49110 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336Ab2F1MKd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jun 2012 08:10:33 -0400
In-Reply-To: <20120628120835.GA3402@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Shawn Guo <shawn.guo@linaro.org>, Hui Wang <jason77.wang@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBDDB95F1DFE53ECF0BAF601D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/28/2012 02:08 PM, Kurt Van Dijck wrote:
> On Thu, Jun 28, 2012 at 07:41:10PM +0800, Shawn Guo wrote:
>> On Thu, Jun 28, 2012 at 01:29:19PM +0200, Marc Kleine-Budde wrote:
>>> I mean which name is more precise, do these gpio enable/standy a "phy=
"
>>> or a "transceiver". For example:
>>> http://www.nxp.com/documents/application_note/AN00094.pdf, this docum=
ent
>>> says: TJA1041/1041A high speed CAN transceiver.
>>>
>> Isn't term "phy" (physical interface) generally meant to be the same
>> thing as "transceiver"?  I just happened to like the shorter one as
>> what Hui did in his patch.
>=20
> 'trx' seemed the right abbreviation
> http://www.acronymfinder.com/TRX.html
>=20
> thanks to Oliver, in his email on May 9th.

I was about to propose CamelCase to keep the variable names shorter:

bool transceiverStbyActiveLow;

scnr, Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigBDDB95F1DFE53ECF0BAF601D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/sSbAACgkQjTAFq1RaXHMBAwCfRwmSwE0m8a/2HafQOkNVp/V+
4/gAnA9poWyxjmNLAmOVySXJhTqv8OYi
=LJlY
-----END PGP SIGNATURE-----

--------------enigBDDB95F1DFE53ECF0BAF601D--
