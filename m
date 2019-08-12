From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/5] can: xilinx_can: defer the probe if clock is not
 found
Date: Mon, 12 Aug 2019 11:03:02 +0200
Message-ID: <144fdbc7-982a-f50d-3bf1-dd9ee2ad282c@pengutronix.de>
References: <1565594914-18999-1-git-send-email-appana.durga.rao@xilinx.com>
 <1565594914-18999-2-git-send-email-appana.durga.rao@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="51D0MuM3ytfH1LDWHaqy6DV3mBVWaOrIZ"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1565594914-18999-2-git-send-email-appana.durga.rao@xilinx.com>
Sender: netdev-owner@vger.kernel.org
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, wg@grandegger.com, davem@davemloft.net, michal.simek@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--51D0MuM3ytfH1LDWHaqy6DV3mBVWaOrIZ
Content-Type: multipart/mixed; boundary="RsHBNlp1OJyfsXm7JxAsUbJhWddkinLpv";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
 wg@grandegger.com, davem@davemloft.net, michal.simek@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>
Message-ID: <144fdbc7-982a-f50d-3bf1-dd9ee2ad282c@pengutronix.de>
Subject: Re: [PATCH 1/5] can: xilinx_can: defer the probe if clock is not
 found
References: <1565594914-18999-1-git-send-email-appana.durga.rao@xilinx.com>
 <1565594914-18999-2-git-send-email-appana.durga.rao@xilinx.com>
In-Reply-To: <1565594914-18999-2-git-send-email-appana.durga.rao@xilinx.com>

--RsHBNlp1OJyfsXm7JxAsUbJhWddkinLpv
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 8/12/19 9:28 AM, Appana Durga Kedareswara rao wrote:
> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>
>=20
> It's not always the case that clock is already available when can
> driver get probed at the first time, e.g. the clock is provided by
> clock wizard which may be probed after can driver. So let's defer
> the probe when devm_clk_get() call fails and give it chance to
> try later.

Technically the patch changes the error message to not being printed in
case of EPROBE_DEFER. This patch doesn't change any behaviour apart from
that. Please adjust the patch description accordingly.

Marc

>=20
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>=

> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  drivers/net/can/xilinx_can.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.=
c
> index bd95cfa..ac175ab 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -1791,7 +1791,8 @@ static int xcan_probe(struct platform_device *pde=
v)
>  	/* Getting the CAN can_clk info */
>  	priv->can_clk =3D devm_clk_get(&pdev->dev, "can_clk");
>  	if (IS_ERR(priv->can_clk)) {
> -		dev_err(&pdev->dev, "Device clock not found.\n");
> +		if (PTR_ERR(priv->can_clk) !=3D -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Device clock not found.\n");
>  		ret =3D PTR_ERR(priv->can_clk);
>  		goto err_free;
>  	}
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--RsHBNlp1OJyfsXm7JxAsUbJhWddkinLpv--

--51D0MuM3ytfH1LDWHaqy6DV3mBVWaOrIZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1RK0YACgkQWsYho5Hk
nSCcWAf/TTxEXEPqm/i50bMWWrbMFTugughoNEEJHhereVPzdx/gi2Rcoi78mJds
pRfNsMx6sX7VcnZfoIIIs9l46hELfcywm25y6bQRN0Hr/VKeVpxiNreGDWvmUCVB
IthAFEact5CBS/Be4OfGRrVx0tlKCqjAGm2oi2wkq++/PQKyKcSjcIDdlMRGHLyu
3Zr5bDLDF9PY3Ln2lKf7zRJoV27Y4xXTCnwk9PiIv+mY0Hrn9Lt3HXSeH2Wqc8d9
2lvLJsYYj1qzd5JaqYV7KkjPPS175Mg4O4TV/lUCmfYvBkCGogbn2W7EwYGCUjOT
sbRLpnSphQJ9m9p2apZGlXNvDcUEpQ==
=HnQW
-----END PGP SIGNATURE-----

--51D0MuM3ytfH1LDWHaqy6DV3mBVWaOrIZ--
