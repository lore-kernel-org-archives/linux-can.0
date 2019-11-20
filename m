From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/2] can: xilinx_can: Bug fixes on can driver
Date: Wed, 20 Nov 2019 13:42:07 +0100
Message-ID: <e985fd5a-9b0c-f273-d28c-14515dc25e5c@pengutronix.de>
References: <1574251865-19592-1-git-send-email-srinivas.neeli@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="IBnRveo9aJdFcdiGi9iJTFwSZYfwd7ZBU"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1574251865-19592-1-git-send-email-srinivas.neeli@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Neeli <srinivas.neeli@xilinx.com>, michal.simek@xilinx.com, appanad@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, git@xilinx.com, nagasure@xilinx.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IBnRveo9aJdFcdiGi9iJTFwSZYfwd7ZBU
Content-Type: multipart/mixed; boundary="9iSn6PNXonoJmkh2SCDhudzuzakmXwd6G";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Srinivas Neeli <srinivas.neeli@xilinx.com>, michal.simek@xilinx.com,
 appanad@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@xilinx.com, nagasure@xilinx.com
Message-ID: <e985fd5a-9b0c-f273-d28c-14515dc25e5c@pengutronix.de>
Subject: Re: [PATCH 0/2] can: xilinx_can: Bug fixes on can driver
References: <1574251865-19592-1-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1574251865-19592-1-git-send-email-srinivas.neeli@xilinx.com>

--9iSn6PNXonoJmkh2SCDhudzuzakmXwd6G
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/20/19 1:11 PM, Srinivas Neeli wrote:
> This patch series does the following:
> -skip printing error message on deferred probe
> -Fix usage of skb memory

BTW: I'm looking for an official Maintainer for the xlinx_can driver.

The Maintainer will get an entry in the MAINTAINERS file, should test
new patches and give Reviewed-bys.

Is there a volunteer?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--9iSn6PNXonoJmkh2SCDhudzuzakmXwd6G--

--IBnRveo9aJdFcdiGi9iJTFwSZYfwd7ZBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3VNJ8ACgkQWsYho5Hk
nSDL+Af7B2T1tVuUZnMSZKeTT8ucHRcMrQqbCZvAcWsjx2xeQsysLeTm/J9pqN3Q
bFc5VPErjtuswNbeLREKyf1xtbv2aLynThPBG4X3DGYHiM5ML6COI3pX+Mt6k033
01gS9OCWJZ4+o6NxmSCyi02/snYT/uZi8byQeQr5PG2fmdwsDe2KuHXKqeePgQqk
2j1+emJ65pQd7k5Yh2e/gLy1VB1e+t6GSnpQmpWp0Lt0ostRPD1gXodXZu1hRr0d
q4uSn8f+/OuwgnJP2hAVtGAcFnQKhPRjwuKvc7bzj9t9kJMrF+y6ZQaLJkKdicZb
KmCrkMN09/PYMO145MhRa9cZVkSTyw==
=Tknr
-----END PGP SIGNATURE-----

--IBnRveo9aJdFcdiGi9iJTFwSZYfwd7ZBU--
