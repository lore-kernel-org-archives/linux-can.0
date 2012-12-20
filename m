From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can: c_can: Correct register alignment info passing
 through DT
Date: Thu, 20 Dec 2012 14:59:50 +0100
Message-ID: <50D319D6.1060201@pengutronix.de>
References: <cover.1355996839.git.amit.virdi@st.com> <4fb69be55045aa390e73c56b215a4b4afb091d1a.1355996839.git.amit.virdi@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig87840CAD52BCC11C64A82DC9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36511 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab2LTN76 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 20 Dec 2012 08:59:58 -0500
In-Reply-To: <4fb69be55045aa390e73c56b215a4b4afb091d1a.1355996839.git.amit.virdi@st.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Amit Virdi <amit.virdi@st.com>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, bhupesh.sharma@st.com, anilkumar@ti.com, spear-devel@list.st.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig87840CAD52BCC11C64A82DC9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/20/2012 11:05 AM, Amit Virdi wrote:
> Depending upon the integration of the C_CAN controller in the SoC, the
> registers may be aligned to 16-bit or 32-bit boundary. The device tree
> support added to the driver assumes this information can be passed
> through 'flags' in the platform resources, however current DT
> implementation provides no such provision.
>=20
> So passing the information explicitly through the optional parameter
> 'reg_alignment' in the device tree.

Please put devicetree-discuss for dt related topics on Cc. Have a look
at Documentation/devicetree/bindings for existing bindings. E.g. there
already is reg-io-width.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig87840CAD52BCC11C64A82DC9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDTGdYACgkQjTAFq1RaXHMT+gCfVTS2gwA1CzrTWitn14T76ppO
j2QAnAj1cXbKlkSniWcCgG28LcyQ6xAE
=DwPU
-----END PGP SIGNATURE-----

--------------enig87840CAD52BCC11C64A82DC9--
