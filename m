From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/2] can: xilinx_can: skip error message on deferred probe
Date: Fri, 22 Nov 2019 15:28:04 +0100
Message-ID: <9f0f491d-74fe-296a-9636-1c0e14a5f77a@pengutronix.de>
References: <1574251865-19592-1-git-send-email-srinivas.neeli@xilinx.com>
 <1574251865-19592-2-git-send-email-srinivas.neeli@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1144861878108670174=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1574251865-19592-2-git-send-email-srinivas.neeli@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Srinivas Neeli <srinivas.neeli@xilinx.com>, wg@grandegger.com, davem@davemloft.net, michal.simek@xilinx.com, appanad@xilinx.com
Cc: netdev@vger.kernel.org, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, nagasure@xilinx.com, git@xilinx.com, Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1144861878108670174==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="g5A6gImkZGJGG7aaAnWYBt0t3a00bGEaR"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g5A6gImkZGJGG7aaAnWYBt0t3a00bGEaR
Content-Type: multipart/mixed; boundary="zKF5itJBYhuodM9eHR8mpx9mqwFKvS9Ue";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Srinivas Neeli <srinivas.neeli@xilinx.com>, wg@grandegger.com,
 davem@davemloft.net, michal.simek@xilinx.com, appanad@xilinx.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@xilinx.com, nagasure@xilinx.com,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>,
 Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Message-ID: <9f0f491d-74fe-296a-9636-1c0e14a5f77a@pengutronix.de>
Subject: Re: [PATCH 1/2] can: xilinx_can: skip error message on deferred probe
References: <1574251865-19592-1-git-send-email-srinivas.neeli@xilinx.com>
 <1574251865-19592-2-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1574251865-19592-2-git-send-email-srinivas.neeli@xilinx.com>

--zKF5itJBYhuodM9eHR8mpx9mqwFKvS9Ue
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 11/20/19 1:11 PM, Srinivas Neeli wrote:
> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>
>=20
> When can clock is provided from the clock wizard, clock wizard driver
       ^^^

The code looks like the "bus" clock is probed here, not the "can" clock.

> may not be available when can driver probes resulting to the error
> message "bus clock not found error".
>=20
> As this error message is not very useful to the end user, skip printing=

> in the case of deferred probe.
>=20
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>=

> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>  drivers/net/can/xilinx_can.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.=
c
> index 4a96e2dd7d77..c5f05b994435 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -1772,7 +1772,8 @@ static int xcan_probe(struct platform_device *pde=
v)
> =20
>  	priv->bus_clk =3D devm_clk_get(&pdev->dev, devtype->bus_clk_name);
              ^^^^^^^
>  	if (IS_ERR(priv->bus_clk)) {
> -		dev_err(&pdev->dev, "bus clock not found\n");
> +		if (PTR_ERR(priv->bus_clk) !=3D -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "bus clock not found\n");
>  		ret =3D PTR_ERR(priv->bus_clk);
>  		goto err_free;
>  	}
>=20

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--zKF5itJBYhuodM9eHR8mpx9mqwFKvS9Ue--

--g5A6gImkZGJGG7aaAnWYBt0t3a00bGEaR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3X8HUACgkQWsYho5Hk
nSD4HQgAgR9+bLGXtcs6cw/zcnm2GQ53RpJYiq5L/4IxwiQz5boWpbcceLPs9yfA
S/0lbOaO9GPUFpPMkll/bUX0RcKqUbmwfjuN4R5URSnx71f2BaLLYrZnIRMF1r9E
1dDEvGCwOoFW3Uepp2f6mXMSBhLdq6ceCkL2V1uT4Q/n9EckX2Fmzk/HzOX5RGrt
2o9xvJokfgp1Jw4GVyuLCFjZGdAeRPZeGW2PphIh6ozT/Y5mBWor6aQ3H1Xc/FGf
pb54OlJ6FhtNwB31VacOeq1B0G3GHtlEGgXx7JaZdkI3YMHAUQB6lMByT4Fw03w7
2HoMDNNi+ri8NWx7zzXTEGhImyPRMw==
=EXc+
-----END PGP SIGNATURE-----

--g5A6gImkZGJGG7aaAnWYBt0t3a00bGEaR--


--===============1144861878108670174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1144861878108670174==--
