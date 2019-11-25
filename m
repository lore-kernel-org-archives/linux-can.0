From: Appana Durga Kedareswara Rao <appanad@xilinx.com>
Subject: RE: [PATCH 1/2] can: xilinx_can: skip error message on deferred probe
Date: Mon, 25 Nov 2019 03:58:14 +0000
Message-ID: <MN2PR02MB640088D5A6812ED36864C55CDC4A0@MN2PR02MB6400.namprd02.prod.outlook.com>
References: <1574251865-19592-1-git-send-email-srinivas.neeli@xilinx.com>
 <1574251865-19592-2-git-send-email-srinivas.neeli@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1574251865-19592-2-git-send-email-srinivas.neeli@xilinx.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "davem@davemloft.net" <davem@davemloft.net>, Michal Simek <michals@xilinx.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, git <git@xilinx.com>, Naga Sureshkumar Relli <nagasure@xilinx.com>, Venkatesh Yadav Abbarapu <VABBARAP@xilinx.com>, Srinivas Neeli <sneeli@xilinx.com>
List-Id: linux-can.vger.kernel.org

Hi,

> -----Original Message-----
> From: Srinivas Neeli <srinivas.neeli@xilinx.com>
> Sent: Wednesday, November 20, 2019 5:41 PM
> To: wg@grandegger.com; mkl@pengutronix.de; davem@davemloft.net;
> Michal Simek <michals@xilinx.com>; Appana Durga Kedareswara Rao
> <appanad@xilinx.com>
> Cc: linux-can@vger.kernel.org; netdev@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git
> <git@xilinx.com>; Naga Sureshkumar Relli <nagasure@xilinx.com>;
> Venkatesh Yadav Abbarapu <VABBARAP@xilinx.com>; Srinivas Neeli
> <sneeli@xilinx.com>
> Subject: [PATCH 1/2] can: xilinx_can: skip error message on deferred prob=
e
>=20
> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>
>=20
> When can clock is provided from the clock wizard, clock wizard driver may
> not be available when can driver probes resulting to the error message "b=
us
> clock not found error".
>=20
> As this error message is not very useful to the end user, skip printing i=
n the
> case of deferred probe.
>=20
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

@Srinivas Neeli: Please send v2 with improved commit message as Marc sugges=
ted, feel free to add=20
Reviewed-by: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com> in =
v2.=20

Regards,
Kedar.
> ---
>  drivers/net/can/xilinx_can.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c =
index
> 4a96e2dd7d77..c5f05b994435 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -1772,7 +1772,8 @@ static int xcan_probe(struct platform_device
> *pdev)
>=20
>  	priv->bus_clk =3D devm_clk_get(&pdev->dev, devtype->bus_clk_name);
>  	if (IS_ERR(priv->bus_clk)) {
> -		dev_err(&pdev->dev, "bus clock not found\n");
> +		if (PTR_ERR(priv->bus_clk) !=3D -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "bus clock not found\n");
>  		ret =3D PTR_ERR(priv->bus_clk);
>  		goto err_free;
>  	}
> --
> 2.7.4
