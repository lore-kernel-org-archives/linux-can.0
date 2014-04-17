From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can: kvaser_usb: add retries/timeout to kvaser_usb_wait_msg()
Date: Thu, 17 Apr 2014 22:19:42 +0200
Message-ID: <5350375E.3030605@pengutronix.de>
References: <1397159063-12790-1-git-send-email-olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uiPdgdg6EJv8XxmAx4PKtDw3KjU1qtg1c"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49583 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbaDQUTx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Apr 2014 16:19:53 -0400
In-Reply-To: <1397159063-12790-1-git-send-email-olivier@sobrie.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uiPdgdg6EJv8XxmAx4PKtDw3KjU1qtg1c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2014 09:44 PM, Olivier Sobrie wrote:
> On some Kvaser hardware, the firmware returns extra messages after the
> request for card info. For instance on a Leaf Light v2:
>   --> CMD_GET_CARD_INFO
>   <-- CMD_USB_THROTTLE
>   <-- CMD_GET_CARD_INFO2
>   <-- CMD_GET_CARD_INFO_REQ
> When it happens, the probing function fails because we only read
> the first usb message.
>=20
> To overcome this issue, we add a mechanism of retries to the
> kvaser_usb_wait_msg() function.
>=20
> I tested this patch with the following hardware:
>  - Kvaser Leaf Light
>  - Kvaser Leaf Light v2
>  - Kvaser USBCan R
>=20
> This patch is necessary for the Leaf Light v2 hardware.
>=20
> Signed-off-by: Olivier Sobrie <olivier@sobrie.be>

Applied all 3 to net-next/master

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--uiPdgdg6EJv8XxmAx4PKtDw3KjU1qtg1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlNQN14ACgkQjTAFq1RaXHPZiACfTW1kUKSYgu2WWNsw+dD1z182
oeIAni6nt0I0vpTymz6uXQCi6T4YYqjO
=8u7Z
-----END PGP SIGNATURE-----

--uiPdgdg6EJv8XxmAx4PKtDw3KjU1qtg1c--
