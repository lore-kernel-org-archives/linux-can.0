From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: peak_pci: device channels chained list issue (cont.)
Date: Tue, 31 Jan 2012 23:12:02 +0100
Message-ID: <4F286732.30901@pengutronix.de>
References: <1322214204-1121-1-git-send-email-wg@grandegger.com> <1322214204-1121-3-git-send-email-wg@grandegger.com> <4ED0FEC5.3070108@hartkopp.net> <4ED34CAD.7040000@essax.com> <4ED351A8.8000102@grandegger.com> <4ED37885.8080909@essax.com> <4ED3B198.2040308@hartkopp.net> <4ED4A2EC.40103@grandegger.com> <4EDBC05D.8070109@essax.com> <4EDBC25D.50405@grandegger.com> <4EDE8435.5080100@essax.com> <4EDF6D54.2060503@grandegger.com> <4EE1E26B.6090308@grandegger.com> <4EE4F76E.3000506@essax.com> <4EE5C824.2050704@grandegger.com> <4EE5E321.8050104@essax.com> <4EE5EBBF.6080007@grandegger.com> <4EF22625.5000109@essax.com> <4EF2FA3F.3010308@grandegger.com> <4EF46FEB.3000200@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig60EA0AAB4953EF1E95EAFCEC"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57875 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916Ab2AaWMH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 31 Jan 2012 17:12:07 -0500
In-Reply-To: <4EF46FEB.3000200@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: s.grosjean@peak-system.com
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig60EA0AAB4953EF1E95EAFCEC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Stephane,

On 12/23/2011 01:11 PM, Grosjean Stephane wrote:
> Hi Wolfgang,
>=20
> Well consider this patch instead (local "prev_dev" removed since not
> useful)

What about this patch? Is this the final fix of the "device channels
chained list issue"? If it is, I want to apply it before adding more
features to the driver.

Can you please resend this patch, this one has spaces instead of tabs.
(The patches from today are fine.)

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig60EA0AAB4953EF1E95EAFCEC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8oZzQACgkQjTAFq1RaXHON0gCfZoQA1y0qVBLD7mXKmBEZN3rl
6BIAn2d8V/ggNftKGZcAT2sgQQjKB4Eh
=bqC7
-----END PGP SIGNATURE-----

--------------enig60EA0AAB4953EF1E95EAFCEC--
