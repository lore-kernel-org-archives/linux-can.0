From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v5 1/2] can: kvaser_usb: Comply with firmware max
 tx URBs value
Date: Sun, 15 Mar 2015 19:08:23 +0100
Message-ID: <5505CA97.6020503@pengutronix.de>
References: <20150226152011.GA6075@linux> <20150315150338.GA4492@linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2N91Xx0beHDOWlrHRHGiSHmxseQ72fvjP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42221 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbbCOS33 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 15 Mar 2015 14:29:29 -0400
In-Reply-To: <20150315150338.GA4492@linux>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>, Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2N91Xx0beHDOWlrHRHGiSHmxseQ72fvjP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/15/2015 04:03 PM, Ahmed S. Darwish wrote:
> From: Ahmed S. Darwish <ahmed.darwish@valeo.com>
>=20
> Current driver code arbitrarily assumes a max outstanding tx
> value of 16 parallel transmissions. Meanwhile, the device
> firmware provides its actual maximum inside its reply to the
> CMD_GET_SOFTWARE_INFO message.
>=20
> Under heavy tx traffic, if the interleaved transmissions count
> increases above the limit reported by firmware, the firmware
> breaks up badly, reports a massive list of internal errors, and
> the candump traces hardly matches the actual frames sent and
> received.
>=20
> On the other hand, in certain models, the firmware can support
> up to 48 tx URBs instead of just 16, increasing the driver
> throughput by two-fold and reducing the possibility of -ENOBUFs.
>=20
> Thus dynamically set the driver's max tx URBs value according
> to firmware replies.
>=20
> Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>

> @@ -1928,7 +1940,7 @@ static int kvaser_usb_init_one(struct usb_interfa=
ce *intf,
>  		return err;
>  	}
> =20
> -	netdev_dbg(netdev, "device registered\n");
> +	netdev_info(netdev, "device registered\n");

This makes the driver more noisy, I'd like to drop that hunk, okay? No
need to resend.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--2N91Xx0beHDOWlrHRHGiSHmxseQ72fvjP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVBcqbAAoJECte4hHFiupUsesP/1XDvaiZZKFb2bbsfVXauqaN
eRmEpkkfD/Ivvi/dDA4nVV1jdaGlpMfSCR6vkxH8rPpB1A5hBs4vBGhnucB6QBh9
xeqk6jH8yiP22OYI5SVP2tFNoCQ2lZW4FM4haRCsfcDDPLntnun8K27mStQFITeL
fHw3C+2qMhupmJ8+rm0vIZQA3LMtE+91oMDzClyUcsvImAk5XJlgdWTB8VEt4EpW
UV2VyEEYJfdGuXU6JbXxRDfnd2s2Kn9vI8ViCWPx2EYKkY/TL+Uq8aUVRMQnsDoo
pCYG/m9ARBoKZeu+3pLLvmCXGyhRTy8FTPx5rBcSnRWBUyS7PP8XrFAJ+piusH6d
bUWJu0RYlHDL1ImB8Y3G699WSg3BXwK0hi6KCTGQdxOu5yrPoxCdrsgp5TwwbGfq
ZdSfFNHp+a8F2pUxTPdpms7Rcfd+QVoXu931DfgZp/QZn3h6R92BJYp4waNlGiOY
3gShRlEPofCxR/fX2BMJ0wjou06fOuc/+aoXpPzu4pxIBKxyvOG82oYTOgQXPVMr
k8VckAK4vk9snaBk9bX0j1Vf97JBbKQcs/iifAXm3EtrIw8YXRJmD0mXrKYSnBCe
Xq+DyVMlC2a9lTT3uojJOhcR4y5+cLQbVLfYssTGSxSodX2uK7EvEv0m63CibE8m
EcFjmaUnfa1oBJ24zpq7
=qsG8
-----END PGP SIGNATURE-----

--2N91Xx0beHDOWlrHRHGiSHmxseQ72fvjP--
