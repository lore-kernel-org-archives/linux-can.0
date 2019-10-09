From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] net: can: xilinx_can: Fix flags field initialization for
 axi can
Date: Wed, 9 Oct 2019 09:54:05 +0200
Message-ID: <3c2561b8-e000-6806-d8ec-0e3162256884@pengutronix.de>
References: <1570606187-30935-1-git-send-email-appana.durga.rao@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2465404676231025263=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1570606187-30935-1-git-send-email-appana.durga.rao@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, wg@grandegger.com, davem@davemloft.net, michal.simek@xilinx.com, anssi.hannula@bitwise.fi
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2465404676231025263==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="NbeugTb5NOyzNTbzLQ7ijx5aylvtxlhL7"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NbeugTb5NOyzNTbzLQ7ijx5aylvtxlhL7
Content-Type: multipart/mixed; boundary="3DNHAcZaSiHUxGiTGrNdgWkeeEAUazueV";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
 wg@grandegger.com, davem@davemloft.net, michal.simek@xilinx.com,
 anssi.hannula@bitwise.fi
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <3c2561b8-e000-6806-d8ec-0e3162256884@pengutronix.de>
Subject: Re: [PATCH] net: can: xilinx_can: Fix flags field initialization for
 axi can
References: <1570606187-30935-1-git-send-email-appana.durga.rao@xilinx.com>
In-Reply-To: <1570606187-30935-1-git-send-email-appana.durga.rao@xilinx.com>

--3DNHAcZaSiHUxGiTGrNdgWkeeEAUazueV
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 10/9/19 9:29 AM, Appana Durga Kedareswara rao wrote:
> AXI CANIP doesn't support tx fifo empty interrupt feature(TXFEMP),
> update the flags filed in the driver for AXI CAN case accordingly.
>=20
> Fixes: 3281b380ec9f ("can: xilinx_can: Fix flags field initialization f=
or axi can and canps")
> Reported-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.co=
m>

Included in linux-can.

thanks,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--3DNHAcZaSiHUxGiTGrNdgWkeeEAUazueV--

--NbeugTb5NOyzNTbzLQ7ijx5aylvtxlhL7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2dkh0ACgkQWsYho5Hk
nSAKcgf/R6XDRK7dHqEqpiGyYTWZcVW4jLMda+2jBqiNSf7H0g9JvPApXLNMMJyu
arWrKcWMDVkYjL31zoqmaeSjbrQ1/KV4OmMAPr5ox937nYGcYYVk4eeJMjeGWYaU
fysA9cGnOy8l0SJyFL4jUiouury4zd0/ZPQzOmPGBde9SmsSq2cQ2BebpXo7UeIO
WPT8GO98RR9pMnVGDjXWKzN8FUR+kqhDAOHL+5jJO5nnu+lzWMsjcMgvzcguRGJh
5FGD6KtAP3rlIiRwxw0p4UAek4qNCizG4dfzi2LPIvb4gYiuB7J9nAy9snEaDh3V
pkUvLSlwJXLj7HPM7raECUhmJMD/fw==
=l153
-----END PGP SIGNATURE-----

--NbeugTb5NOyzNTbzLQ7ijx5aylvtxlhL7--


--===============2465404676231025263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2465404676231025263==--
