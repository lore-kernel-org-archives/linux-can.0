From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 00/10] tx/rx LED trigger support
Date: Tue, 22 Jan 2013 22:39:22 +0100
Message-ID: <50FF070A.7090103@pengutronix.de>
References: <1355853064-18144-1-git-send-email-fabio.baltieri@gmail.com> <50F5BEEF.1060208@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2EKEUXMDFSNTJKCQNXOMR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47147 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512Ab3AVVja (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Jan 2013 16:39:30 -0500
In-Reply-To: <50F5BEEF.1060208@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: linux-can@vger.kernel.org, Kurt Van Dijck <kurt.van.dijck@eia.be>, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Bernd Krumboeck <b.krumboeck@gmail.com>, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2EKEUXMDFSNTJKCQNXOMR
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/15/2013 09:41 PM, Marc Kleine-Budde wrote:
> On 12/18/2012 06:50 PM, Fabio Baltieri wrote:
>> Hi All,
>>
>> this is the v2 of the canbus LED series.
>>
>> Changes from v1:
>> - moved all framework patches before driver ones
>> - added usb_8dev driver patch to the series (based on v9 version)
>> - added by S-o-b to all patches in this series
>>
>> The last usb_8dev patch requires Bernd's patch.  A part from this the
>> set applies cleanly on current mainline.
>=20
> Applied 1-9, skipping usb_8dev, as the driver has some problems with
> unplugging under load.

Applied patch 10/10.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2EKEUXMDFSNTJKCQNXOMR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD/BwoACgkQjTAFq1RaXHPRsACfQeVPzFT+eB+P18sU3nsB0R1L
hW4AoIWhVhFBrA4IsNwzWak8kzxyfZuf
=+KLe
-----END PGP SIGNATURE-----

------enig2EKEUXMDFSNTJKCQNXOMR--
