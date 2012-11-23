From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] kvaser_usb: fix "dma on the stack" errors
Date: Fri, 23 Nov 2012 15:08:08 +0100
Message-ID: <50AF8348.6080701@pengutronix.de>
References: <20121123134027.GA32098@hposo> <1353678883-23136-1-git-send-email-olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1AC991CBB89EAEC8B51EA79C"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32768 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982Ab2KWOIP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 23 Nov 2012 09:08:15 -0500
In-Reply-To: <1353678883-23136-1-git-send-email-olivier@sobrie.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegge <wg@grandegger.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1AC991CBB89EAEC8B51EA79C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/23/2012 02:54 PM, Olivier Sobrie wrote:
> The dma buffer given to usb_bulk_msg() must be allocated and not on
> the stack.
> See Documentation/DMA-API-HOWTO.txt section "What memory is DMA'able?"
>=20
> Signed-off-by: Olivier Sobrie <olivier@sobrie.be>

Thanks, I've squashed it into the original patch and pushed to
linux-can-next/for-davem

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig1AC991CBB89EAEC8B51EA79C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlCvg0wACgkQjTAFq1RaXHOZpgCeOdVwenQnGJpid/M8jLfag6/i
LfcAoIt0AobHXJbhN1KSZUALHqmGjvPE
=y2c8
-----END PGP SIGNATURE-----

--------------enig1AC991CBB89EAEC8B51EA79C--
