From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] socketcan: provide GPL2 notion for the headers
Date: Tue, 12 Jun 2012 09:21:03 +0200
Message-ID: <4FD6EDDF.6080902@pengutronix.de>
References: <1339484312-4281-1-git-send-email-yegorslists@googlemail.com> <1339484312-4281-2-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAA85FFBB86B10E469E6C3CE7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46995 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab2FLHVP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Jun 2012 03:21:15 -0400
In-Reply-To: <1339484312-4281-2-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com
Cc: linux-can@vger.kernel.org, wg@grandegger.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAA85FFBB86B10E469E6C3CE7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/12/2012 08:58 AM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>

Please don't add the FSF's address.

> --- a/include/linux/can.h
> +++ b/include/linux/can.h
> @@ -3,11 +3,22 @@
>   *
>   * Definitions for CAN network layer (socket addr / CAN frame / CAN fi=
lter)
>   *
> + * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
>   * Authors: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
>   *          Urs Thuermann   <urs.thuermann@volkswagen.de>
> - * Copyright (c) 2002-2007 Volkswagen Group Electronic Research
> - * All rights reserved.
>   *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307=
 USA
>   */
> =20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigAA85FFBB86B10E469E6C3CE7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/W7eUACgkQjTAFq1RaXHMMAgCdHJlx1XrdC6hgGh2eJ38/t1FV
pbQAn3f5FqIP2HKHf9YUo1DxOyxOHXTt
=/cV6
-----END PGP SIGNATURE-----

--------------enigAA85FFBB86B10E469E6C3CE7--
