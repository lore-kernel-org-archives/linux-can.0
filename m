From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: peak_pci: add unused device id. in devices table
Date: Wed, 30 Sep 2015 13:09:44 +0200
Message-ID: <560BC2F8.4040707@pengutronix.de>
References: <1443609755-29854-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="iw2ujWNu3hB6OLLlC0ddhptrKHJ3Lq9gQ"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58263 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932691AbbI3LJz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 30 Sep 2015 07:09:55 -0400
In-Reply-To: <1443609755-29854-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iw2ujWNu3hB6OLLlC0ddhptrKHJ3Lq9gQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/30/2015 12:42 PM, Stephane Grosjean wrote:
> While new PEAK_PCIE_OEM_ID has been defined since 3.17, no correspondin=
g
> entry has been added in the peak_pci_tbl[] of the peak_pci CAN driver.
>=20
> This patch enables now users of the PCAN-PCI Express OEM card to run th=
e
> peak_pci driver too.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

Thnx, added stable on Cc.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--iw2ujWNu3hB6OLLlC0ddhptrKHJ3Lq9gQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWC8L4AAoJEP5prqPJtc/HknwH/0zj6L2fMFuGO8VWZMFmBD6d
hrtZuLLM5xb4rcklu7y7kNdj4FFJeHwfqBu9OUth12d4X3SXZAlGuad2r8Trwuqb
vzP1M6SoFp8YzYY3+xLGY1yhxekDxXHD2Z7cFp9ABpLL7r1oKEqjOeE+zjfE2ljl
pDxounwdvgTyuhh5xgWDRokKnOEmXwOzEF1sWIuw4aNnH8GT5jHCTTkOx/tl/AYB
V17eBrI+vc8v2+FNZoqby63BQ7gLxAjaW6npunuA4Qf9Rxyw5bK173P/LT8zb8rs
zY48ftTtwnpsecylKzAFa7k/6yCwHekyPiATBkC7gDX8yaE0rRm1wqOtHKu4tEc=
=VGfD
-----END PGP SIGNATURE-----

--iw2ujWNu3hB6OLLlC0ddhptrKHJ3Lq9gQ--
