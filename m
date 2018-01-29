From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH 3/5] can: xilinx_can: fix recovery from error states not being
 propagated
Date: Mon, 29 Jan 2018 10:44:50 +0000
Message-ID: <151722269077.27204.8452699005718607415@maxwell>
References: <20180126142723.3212-1-anssi.hannula@bitwise.fi>
 <20180126142723.3212-4-anssi.hannula@bitwise.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ve1eur01on0083.outbound.protection.outlook.com ([104.47.1.83]:43008
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751337AbeA2Koz (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 29 Jan 2018 05:44:55 -0500
In-Reply-To: <20180126142723.3212-4-anssi.hannula@bitwise.fi>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Anssi Hannula <anssi.hannula@bitwise.fi>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Michal Simek <michal.simek@xilinx.com>

Hello Anssi

Quoting Anssi Hannula (2018-01-26 14:27:21)
> The xilinx_can driver contains no mechanism for propagating recovery
> from CAN_STATE_ERROR_WARNING and CAN_STATE_ERROR_PASSIVE.
> =

> Add such a mechanism by factoring the handling of
> XCAN_STATE_ERROR_PASSIVE and XCAN_STATE_ERROR_WARNING out of
> xcan_err_interrupt and checking for recovery after RX and TX if the
> interface is in one of those states.
> =

> Tested with the integrated CAN on Zynq-7000 SoC.
> =

> Fixes: b1201e44f50b ("can: xilinx CAN controller support")
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> ---
>  drivers/net/can/xilinx_can.c | 155 +++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 127 insertions(+), 28 deletions(-)
> =

> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index 1bda47a..763408a 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
...

There is a function in drivers/net/can/dev.c that does this:
> +
> +/**
> + * xcan_set_error_state - Set new CAN error state
> + * @ndev:      Pointer to net_device structure
> + * @new_state: The new CAN state to be set
> + * @cf:                Error frame to be populated or NULL
> + *
> + * Set new CAN error state for the device, updating statistics and
> + * populating the error frame if given.
> + */
> +static void xcan_set_error_state(struct net_device *ndev,
> +                                enum can_state new_state,
> +                                struct can_frame *cf)
> +{
> +       struct xcan_priv *priv =3D netdev_priv(ndev);
> +       u32 ecr =3D priv->read_reg(priv, XCAN_ECR_OFFSET);
> +       u32 txerr =3D ecr & XCAN_ECR_TEC_MASK;
> +       u32 rxerr =3D (ecr & XCAN_ECR_REC_MASK) >> XCAN_ESR_REC_SHIFT;
> +
> +       priv->can.state =3D new_state;
> +
> +       if (cf) {
> +               cf->can_id |=3D CAN_ERR_CRTL;
> +               cf->data[6] =3D txerr;
> +               cf->data[7] =3D rxerr;
> +       }
> +
> +       switch (new_state) {
> +       case CAN_STATE_ERROR_PASSIVE:
> +               priv->can.can_stats.error_passive++;
> +               if (cf)
> +                       cf->data[1] =3D (rxerr > 127) ?
> +                                       CAN_ERR_CRTL_RX_PASSIVE :
> +                                       CAN_ERR_CRTL_TX_PASSIVE;
> +               break;
> +       case CAN_STATE_ERROR_WARNING:
> +               priv->can.can_stats.error_warning++;
> +               if (cf)
> +                       cf->data[1] |=3D (txerr > rxerr) ?
> +                                       CAN_ERR_CRTL_TX_WARNING :
> +                                       CAN_ERR_CRTL_RX_WARNING;
> +               break;
> +       case CAN_STATE_ERROR_ACTIVE:
> +               if (cf)
> +                       cf->data[1] |=3D CAN_ERR_CRTL_ACTIVE;
> +               break;
> +       default:
> +               /* non-ERROR states are handled elsewhere */
> +               WARN_ON(1);
> +               break;
> +       }
> +}
...

It's not a big function, but the idea was to try to make this behaviour
consistent between drivers by putting it into a function.

Regards,
Andri
