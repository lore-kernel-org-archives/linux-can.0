From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3] can: kvaser_usb: handle rx msg correctly
Date: Wed, 15 May 2013 12:05:31 +0200
Message-ID: <51935DEB.8080805@pengutronix.de>
References: <CAJW3KNWxa_a727sgi_EO7nMBVbyVrCz0V3wCJBfvhz0ubbqCfA@mail.gmail.com> <517A968D.20508@pengutronix.de> <20130430214044.GA22921@thinkoso.home> <51824189.8090402@pengutronix.de> <20130502180610.GA14242@thinkoso.home> <20130502185710.GA1041@thinkoso.home> <518388AD.3050902@pengutronix.de> <20130507200523.GA2514@thinkoso.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2BFTUFSWEMFFIVRPXPAJX"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40317 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924Ab3EOKFm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 May 2013 06:05:42 -0400
In-Reply-To: <20130507200523.GA2514@thinkoso.home>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>
Cc: Jonas Peterson <jonas.peterson@gmail.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2BFTUFSWEMFFIVRPXPAJX
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On 05/07/2013 10:05 PM, Olivier Sobrie wrote:
> From: Jonas Peterson <jonas.peterson@gmail.com>
>=20
> Unlike Kvaser Leaf light devices, some other Kvaser devices (like USBca=
n
> Pro, USBcan R) receive CAN messages in CMD_LOG_MESSAGE frames. This
> patch adds support for it.
>=20
> Signed-off-by: Jonas Peterson <jonas.peterson@gmail.com>
> Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
> ---
> v3:
>  - add KVASER_EXTENDED_FRAME define
>  - call kvaser_usb_rx_error() in kvaser_usb_rx_can_msg when the frame i=
s
>    a CMD_LOG_MESSAGE and flag MSG_FLAG_ERROR_FRAME is set.
>=20
> By reading the patch again I saw that I mixed up kvaser_usb_rx_can_msg =
and
                                                                     ^^^

Do you want to merge kvaser_usb_rx_can_msg() or kvaser_usb_rx_can_err()?

> kvaser_usb_rx_error when I cleaned the patch... If fixed that in this
> version.
> I should maybe merge these two functions to avoid confusion...

If you want to merge kvaser_usb_rx_can_err() and kvaser_usb_rx_error()
it would make sense, to have the error handling functionality in one
function. I haven't looked at the code, though.

However, this would be a separate patch. I'm applying this patch as it
is to can/master with linux-stable on Cc.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2BFTUFSWEMFFIVRPXPAJX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGTXe4ACgkQjTAFq1RaXHPx0ACfRuZXbiaP9XRhWMvS/Upz1cbg
jG0AniK0KamHOM3o4p2ZDc9iHfzK3qM7
=g414
-----END PGP SIGNATURE-----

------enig2BFTUFSWEMFFIVRPXPAJX--
