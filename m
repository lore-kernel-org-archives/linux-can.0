From: Aisheng DONG <aisheng.dong@nxp.com>
Subject: RE: [PATCH net-next] can: flexcan: flexcan_chip_start(): fix the
 error return code in flexcan_setup_stop_mode()
Date: Tue, 4 Dec 2018 12:32:09 +0000
Message-ID: <AM0PR04MB42112B975149B031A0ECA71F80AF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1543904780-30235-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1543904780-30235-1-git-send-email-weiyongjun1@huawei.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

> -----Original Message-----
> From: Wei Yongjun [mailto:weiyongjun1@huawei.com]
> Sent: Tuesday, December 4, 2018 2:26 PM
> To: Wolfgang Grandegger <wg@grandegger.com>; Marc Kleine-Budde
> <mkl@pengutronix.de>; Aisheng DONG <aisheng.dong@nxp.com>
> Cc: Wei Yongjun <weiyongjun1@huawei.com>; linux-can@vger.kernel.org;
> netdev@vger.kernel.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH net-next] can: flexcan: flexcan_chip_start(): fix the err=
or return
> code in flexcan_setup_stop_mode()
>=20
> The error return code PTR_ERR(gpr_np) is always 0 since gpr_np is equal t=
o
> NULL in this error handling case. Fix it by return -ENOENT.
>=20
> Fixes: de3578c198c6 ("can: flexcan: add self wakeup support")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/net/can/flexcan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c index
> 0f36eaf..f412d84 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -1432,7 +1432,7 @@ static int flexcan_setup_stop_mode(struct
> platform_device *pdev)
>  	gpr_np =3D of_find_node_by_phandle(phandle);
>  	if (!gpr_np) {
>  		dev_dbg(&pdev->dev, "could not find gpr node by phandle\n");
> -		return PTR_ERR(gpr_np);
> +		return -ENOENT;

Good catch.

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

>  	}
>=20
>  	priv =3D netdev_priv(dev);
>=20
>=20
