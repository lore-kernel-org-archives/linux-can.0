From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH RFC v2] can: complete initial namespace support
Date: Fri, 14 Apr 2017 14:51:01 +0200
Message-ID: <68210962-4791-088a-817d-d49d93c10344@pengutronix.de>
References: <20170410124144.14438-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="qGhI8p169NTbIx5P94tOHeodNJ2vme5iV"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60967 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751235AbdDNMvK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Apr 2017 08:51:10 -0400
In-Reply-To: <20170410124144.14438-1-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: dev@kicherer.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qGhI8p169NTbIx5P94tOHeodNJ2vme5iV
Content-Type: multipart/mixed; boundary="25t0dow6NgSoTu2mc5rSaTnOj7mRIVBco";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: dev@kicherer.org
Message-ID: <68210962-4791-088a-817d-d49d93c10344@pengutronix.de>
Subject: Re: [PATCH RFC v2] can: complete initial namespace support
References: <20170410124144.14438-1-socketcan@hartkopp.net>
In-Reply-To: <20170410124144.14438-1-socketcan@hartkopp.net>

--25t0dow6NgSoTu2mc5rSaTnOj7mRIVBco
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2017 02:41 PM, Oliver Hartkopp wrote:
> The statistics and its proc output was not implemented as per-net in th=
e
> initial network namespace support by Mario Kicherer (8e8cda6d737d).
> This patch adds the per-net statistics and fixes a memory leak due to t=
he
> missing kfree of can_rx_alldev_list in can_pernet_exit().
>=20
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

I've split the memleak fix into a seperate patch - added both to can-next=
=2E

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--25t0dow6NgSoTu2mc5rSaTnOj7mRIVBco--

--qGhI8p169NTbIx5P94tOHeodNJ2vme5iV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAljwxbUACgkQHv7KIOw4
HPaF+Qf9EGGf50TfzAOmT2ZGUcdW71rLJcGNF6eoAAUMZrAkYFBaoe9fqNPlxMrG
cI4R1ly56NVS2fzlu25Q44nZTWWqf4BnclD/QgG5Yv+9JJBZ9YrwmrVAAGhmio0W
KQyFn1dfkPFLFj27TLRr6eN3UyWvfalS1w75amdaaql5P20Cmqm2B6GVkhYHGQnz
dYGz4rXCampMYPdphqU+9CzCtYh/9BSLjHE2S0RADP+WnML44tXstZ4ygPIxZK34
71rBtXEleyRhb52uiGPQArxkUDXhNMR1QCgZsgfvK0BNDogdLjSkG/TjwRTJaSRy
im6DS0lkaNlw7OLV9zGJTNzSDx799A==
=cqqm
-----END PGP SIGNATURE-----

--qGhI8p169NTbIx5P94tOHeodNJ2vme5iV--
