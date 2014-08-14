From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/1] net: can: sja1000: Validate initialization state
 in start method
Date: Thu, 14 Aug 2014 12:18:00 +0200
Message-ID: <53EC8CD8.2040703@pengutronix.de>
References: <1407501050-16156-1-git-send-email-mirza.krak@hostmobility.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="FqWms73JQ2OhogPprHuUt0NTJoALdXVho"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42812 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbaHNKSD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Aug 2014 06:18:03 -0400
In-Reply-To: <1407501050-16156-1-git-send-email-mirza.krak@hostmobility.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mirza Krak <mirza.krak@hostmobility.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FqWms73JQ2OhogPprHuUt0NTJoALdXVho
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2014 02:30 PM, Mirza Krak wrote:
> When sja1000 is not compiled as module the SJA1000 chip is only
> initialized during device registration on kernel boot. Should the chip
> get a hardware reset there is no way to reinitialize it without re-
> booting the Linux kernel.

Not good. :/

However, you can manually unbind the device from the driver:

> =E2=9E=9C (pts/0) mkl@hermippe:drivers/sja1000_plx_pci ll
> total 0
> lrwxrwxrwx 1 root root    0 Aug 14 12:15 0000:01:02.0 -> ../../../../de=
vices/pci0000:00/0000:00:1e.0/0000:01:02.0
> --w------- 1 root root 4096 Aug 14 12:15 bind
> lrwxrwxrwx 1 root root    0 Aug 14 12:15 module -> ../../../../module/p=
lx_pci
> --w------- 1 root root 4096 Aug 14 12:15 new_id
> --w------- 1 root root 4096 Aug 14 12:15 remove_id
> --w------- 1 root root 4096 Aug 14 12:15 uevent
> --w------- 1 root root 4096 Aug 14 12:15 unbind
> =E2=9E=9C (pts/0) mkl@hermippe:drivers/sja1000_plx_pci echo 0000:01:02.=
0 | sudo tee unbind

And then rebind it:

> =E2=9E=9C (pts/0) mkl@hermippe:drivers/sja1000_plx_pci echo 0000:01:02.=
0 | sudo tee bind

> This patch adds a check in sja1000_start if the chip is initialized, if=

> not we initialize it.

Applied to can.

Thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--FqWms73JQ2OhogPprHuUt0NTJoALdXVho
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlPsjNgACgkQjTAFq1RaXHOkkgCggDxVds2NaUTNvlM6Z0B8JCz3
EYEAn1sSl7n32YmnbRl8WXOtVejdJX5B
=rYBK
-----END PGP SIGNATURE-----

--FqWms73JQ2OhogPprHuUt0NTJoALdXVho--
