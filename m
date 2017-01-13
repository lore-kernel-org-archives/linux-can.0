From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
Date: Fri, 13 Jan 2017 15:00:42 +0100
Message-ID: <aa642d9e-28a1-6494-5ad0-e7ae534a95da@pengutronix.de>
References: <1484136978-3823-1-git-send-email-s.grosjean@peak-system.com>
 <1484136978-3823-5-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="TEbWwh5Okqk1fJiJav0upH1IPs3ePwGTr"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:56249 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751445AbdAMOAx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Jan 2017 09:00:53 -0500
In-Reply-To: <1484136978-3823-5-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TEbWwh5Okqk1fJiJav0upH1IPs3ePwGTr
Content-Type: multipart/mixed; boundary="DdiQnmBroI9SXefm6kW5KgjuTcMSBRki8";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <aa642d9e-28a1-6494-5ad0-e7ae534a95da@pengutronix.de>
Subject: Re: [PATCH v3 4/4] can: peak: add support for PEAK PCAN-PCIe FD
 CAN-FD boards
References: <1484136978-3823-1-git-send-email-s.grosjean@peak-system.com>
 <1484136978-3823-5-git-send-email-s.grosjean@peak-system.com>
In-Reply-To: <1484136978-3823-5-git-send-email-s.grosjean@peak-system.com>

--DdiQnmBroI9SXefm6kW5KgjuTcMSBRki8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 01:16 PM, Stephane Grosjean wrote:
> This patch adds the support of the PCAN-PCI Express FD boards made
> by PEAK-System, for computers using the PCI Express slot.
>=20
> The PCAN-PCI Express FD has one or two CAN FD channels, depending
> on the model. A galvanic isolation of the CAN ports protects
> the electronics of the card and the respective computer against
> disturbances of up to 500 Volts. The PCAN-PCI Express FD can be operate=
d
> with ambient temperatures in a range of -40 to +85 =C2=B0C.
>=20
> Such boards run an extented version of the CAN-FD IP running into USB
> CAN-FD interfaces from PEAK-System, so this patch adds several new comm=
ands
> and their corresponding data types to the PEAK CAN-FD common definition=
s
> header file too.
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>

The access of tx_pages_free seems not be be synchronized. It's accessed
from IRQ context and from the xmit function. See more comments inline.

> ---
>  v3:
>  - remove unused flags field from struct pciefd_can
>  - use memset() to reset 64-bits area instead of *(u64 *) cast
>  - use dmam_alloc_coherent() and dmam_free_coheren()
>  - state handling has been separated from err skb building
>  - peak_canfd_start_xmit() now stops netif queue when there is not enou=
gh room
>    left to save one more CANFD msgs in the Tx DMA pages (no CAN msg los=
t)
>  - remove the IFF_ECHO flag from ndev flags (no tx-complete interrupt a=
vailable)
>  - use common namespace (*Hz defines have been removed)
>  - pciefd_irq_handler(): remove useless cast
>  - ipciefd_write_cmd(): pre- and pos- cmd processing has been moved int=
o
>    specific pre_cmd() and post_cmd() callbacks
>  - every "#ifdef CONFIG_xxx" has been changed into "IS_ENABLED(CONFIG_x=
xx)"
>  - add missing fallthough comment
>  - peak_pciefd_probe(): use of devm_kzalloc() instead of kmalloc()
>  - peak_pciefd_probe(): hw_ver_* have been removed from struct pciefd_b=
oard
>  - peak_pciefd_probe(): non "standard" for loop converted into a while(=
) one
>  - peak_pciefd_remove(): remove one extra space character
>  - peak_pciefd_remove(): remove useless pointer test against NULLity
>  - peak_canfd.h: convert PUCAN_STMSG_xxx() defines into pucan_status_xx=
x()
>    inline functions
>=20
>  drivers/net/can/Kconfig                       |   1 +
>  drivers/net/can/Makefile                      |   1 +
>  drivers/net/can/peak_canfd/Kconfig            |  13 +
>  drivers/net/can/peak_canfd/Makefile           |   5 +
>  drivers/net/can/peak_canfd/peak_canfd.c       | 723 ++++++++++++++++++=
++++
>  drivers/net/can/peak_canfd/peak_canfd_user.h  |  50 ++
>  drivers/net/can/peak_canfd/peak_pciefd_main.c | 851 ++++++++++++++++++=
++++++++
>  include/linux/can/dev/peak_canfd.h            |  65 ++
>  8 files changed, 1709 insertions(+)
>  create mode 100644 drivers/net/can/peak_canfd/Kconfig
>  create mode 100644 drivers/net/can/peak_canfd/Makefile
>  create mode 100644 drivers/net/can/peak_canfd/peak_canfd.c
>  create mode 100644 drivers/net/can/peak_canfd/peak_canfd_user.h
>  create mode 100644 drivers/net/can/peak_canfd/peak_pciefd_main.c
>=20
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index 22570ea..aa20b69 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -142,6 +142,7 @@ source "drivers/net/can/cc770/Kconfig"
>  source "drivers/net/can/ifi_canfd/Kconfig"
>  source "drivers/net/can/m_can/Kconfig"
>  source "drivers/net/can/mscan/Kconfig"
> +source "drivers/net/can/peak_canfd/Kconfig"
>  source "drivers/net/can/rcar/Kconfig"
>  source "drivers/net/can/sja1000/Kconfig"
>  source "drivers/net/can/softing/Kconfig"
> diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
> index 7a85495..6f68bee 100644
> --- a/drivers/net/can/Makefile
> +++ b/drivers/net/can/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_CAN_IFI_CANFD)	+=3D ifi_canfd/
>  obj-$(CONFIG_CAN_JANZ_ICAN3)	+=3D janz-ican3.o
>  obj-$(CONFIG_CAN_MSCAN)		+=3D mscan/
>  obj-$(CONFIG_CAN_M_CAN)		+=3D m_can/
> +obj-$(CONFIG_CAN_PEAK_PCIEFD)	+=3D peak_canfd/
>  obj-$(CONFIG_CAN_SJA1000)	+=3D sja1000/
>  obj-$(CONFIG_CAN_SUN4I)		+=3D sun4i_can.o
>  obj-$(CONFIG_CAN_TI_HECC)	+=3D ti_hecc.o
> diff --git a/drivers/net/can/peak_canfd/Kconfig b/drivers/net/can/peak_=
canfd/Kconfig
> new file mode 100644
> index 0000000..84b3097
> --- /dev/null
> +++ b/drivers/net/can/peak_canfd/Kconfig
> @@ -0,0 +1,13 @@
> +config CAN_PEAK_PCIEFD
> +	depends on PCI
> +	tristate "PEAK-System PCAN-PCIe FD cards"
> +	---help---
> +	  This driver adds support for the PEAK-System PCI Express FD
> +	  CAN-FD cards family.
> +	  These 1x or 2x CAN-FD channels cards offer CAN 2.0 a/b as well as
> +	  CAN-FD access to the CAN bus. Besides the nominal bitrate of up to
> +	  1 Mbit/s, the data bytes of CAN-FD frames can be transmitted with
> +	  up to 12 Mbit/s. A galvanic isolation of the CAN ports protects the=

> +	  electronics of the card and the respective computer against
> +	  disturbances of up to 500 Volts. The PCAN-PCI Express FD can be
> +	  operated with ambient temperatures in a range of -40 to +85 =C2=B0C=
=2E
> diff --git a/drivers/net/can/peak_canfd/Makefile b/drivers/net/can/peak=
_canfd/Makefile
> new file mode 100644
> index 0000000..3dc7a6a
> --- /dev/null
> +++ b/drivers/net/can/peak_canfd/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for the PEAK-System CAN-FD IP module drivers
> +#
> +obj-$(CONFIG_CAN_PEAK_PCIEFD) +=3D peak_pciefd.o
> +peak_pciefd-y :=3D peak_pciefd_main.o peak_canfd.o
> diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/=
peak_canfd/peak_canfd.c
> new file mode 100644
> index 0000000..dd15900
> --- /dev/null
> +++ b/drivers/net/can/peak_canfd/peak_canfd.c
> @@ -0,0 +1,723 @@
> +/*
> + * Copyright (C) 2007, 2011 Wolfgang Grandegger <wg@grandegger.com>
> + * Copyright (C) 2012 Stephane Grosjean <s.grosjean@peak-system.com>
> + *
> + * Copyright (C) 2016  PEAK System-Technik GmbH
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the version 2 of the GNU General Public Licen=
se
> + * as published by the Free Software Foundation
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/can.h>
> +#include <linux/can/dev.h>
> +
> +#include "peak_canfd_user.h"
> +
> +/* bittiming ranges of the PEAK-System PC CAN-FD interfaces */
> +static const struct can_bittiming_const peak_canfd_nominal_const =3D {=

> +	.name =3D "peak_canfd",
> +	.tseg1_min =3D 1,
> +	.tseg1_max =3D (1 << PUCAN_TSLOW_TSGEG1_BITS),
> +	.tseg2_min =3D 1,
> +	.tseg2_max =3D (1 << PUCAN_TSLOW_TSGEG2_BITS),
> +	.sjw_max =3D (1 << PUCAN_TSLOW_SJW_BITS),
> +	.brp_min =3D 1,
> +	.brp_max =3D (1 << PUCAN_TSLOW_BRP_BITS),
> +	.brp_inc =3D 1,
> +};
> +
> +static const struct can_bittiming_const peak_canfd_data_const =3D {
> +	.name =3D "peak_canfd",
> +	.tseg1_min =3D 1,
> +	.tseg1_max =3D (1 << PUCAN_TFAST_TSGEG1_BITS),
> +	.tseg2_min =3D 1,
> +	.tseg2_max =3D (1 << PUCAN_TFAST_TSGEG2_BITS),
> +	.sjw_max =3D (1 << PUCAN_TFAST_SJW_BITS),
> +	.brp_min =3D 1,
> +	.brp_max =3D (1 << PUCAN_TFAST_BRP_BITS),
> +	.brp_inc =3D 1,
> +};
> +
> +static struct peak_canfd_priv *pucan_init_cmd(struct peak_canfd_priv *=
priv)
> +{
> +	priv->cmd_len =3D 0;
> +	return priv;
> +}
> +
> +static void *pucan_add_cmd(struct peak_canfd_priv *priv, int cmd_op)
> +{
> +	struct pucan_command *cmd;
> +
> +	if (priv->cmd_len + sizeof(*cmd) > priv->cmd_maxlen)
> +		return NULL;
> +
> +	cmd =3D priv->cmd_buffer + priv->cmd_len;
> +
> +	/* reset all unused bit to default */
> +	memset(cmd, 0, sizeof(*cmd));
> +
> +	cmd->opcode_channel =3D pucan_cmd_opcode_channel(priv->index, cmd_op)=
;
> +	priv->cmd_len +=3D sizeof(*cmd);
> +
> +	return cmd;
> +}
> +
> +static int pucan_write_cmd(struct peak_canfd_priv *priv)
> +{
> +	int err;
> +
> +	if (priv->pre_cmd) {
> +		err =3D priv->pre_cmd(priv);
> +		if (err)
> +			return err;
> +	}
> +
> +	err =3D priv->write_cmd(priv);
> +	if (err)
> +		return err;
> +
> +	if (priv->post_cmd)
> +		err =3D priv->post_cmd(priv);
> +
> +	return err;
> +}
> +
> +/* uCAN commands interface functions */
> +static int pucan_set_reset_mode(struct peak_canfd_priv *priv)
> +{
> +	pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_RESET_MODE);
> +	return pucan_write_cmd(priv);
> +}
> +
> +static int pucan_set_normal_mode(struct peak_canfd_priv *priv)
> +{
> +	int err;
> +
> +	pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_NORMAL_MODE);
> +	err =3D pucan_write_cmd(priv);
> +	if (!err)
> +		priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +
> +	return err;
> +}
> +
> +static int pucan_set_listen_only_mode(struct peak_canfd_priv *priv)
> +{
> +	int err;
> +
> +	pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_LISTEN_ONLY_MODE);
> +	err =3D pucan_write_cmd(priv);
> +	if (!err)
> +		priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +
> +	return err;
> +}
> +
> +static int pucan_set_timing_slow(struct peak_canfd_priv *priv,
> +				 const struct can_bittiming *pbt)
> +{
> +	struct pucan_timing_slow *cmd;
> +
> +	cmd =3D pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_TIMING_SLOW);
> +
> +	cmd->sjw_t =3D PUCAN_TSLOW_SJW_T(pbt->sjw - 1,
> +				priv->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES);
> +	cmd->tseg1 =3D PUCAN_TSLOW_TSEG1(pbt->prop_seg + pbt->phase_seg1 - 1)=
;
> +	cmd->tseg2 =3D PUCAN_TSLOW_TSEG2(pbt->phase_seg2 - 1);
> +	cmd->brp =3D cpu_to_le16(PUCAN_TSLOW_BRP(pbt->brp - 1));
> +
> +	cmd->ewl =3D 96;	/* default */
> +
> +	netdev_dbg(priv->ndev,
> +		   "nominal: brp=3D%u tseg1=3D%u tseg2=3D%u sjw=3D%u\n",
> +		   le16_to_cpu(cmd->brp), cmd->tseg1, cmd->tseg2, cmd->sjw_t);
> +
> +	return pucan_write_cmd(priv);
> +}
> +
> +static int pucan_set_timing_fast(struct peak_canfd_priv *priv,
> +				 const struct can_bittiming *pbt)
> +{
> +	struct pucan_timing_fast *cmd;
> +
> +	cmd =3D pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_TIMING_FAST);
> +
> +	cmd->sjw =3D PUCAN_TFAST_SJW(pbt->sjw - 1);
> +	cmd->tseg1 =3D PUCAN_TFAST_TSEG1(pbt->prop_seg + pbt->phase_seg1 - 1)=
;
> +	cmd->tseg2 =3D PUCAN_TFAST_TSEG2(pbt->phase_seg2 - 1);
> +	cmd->brp =3D cpu_to_le16(PUCAN_TFAST_BRP(pbt->brp - 1));
> +
> +	netdev_dbg(priv->ndev,
> +		   "data: brp=3D%u tseg1=3D%u tseg2=3D%u sjw=3D%u\n",
> +		   le16_to_cpu(cmd->brp), cmd->tseg1, cmd->tseg2, cmd->sjw);
> +
> +	return pucan_write_cmd(priv);
> +}
> +
> +static int pucan_set_std_filter(struct peak_canfd_priv *priv, u8 row, =
u32 mask)
> +{
> +	struct pucan_std_filter *cmd;
> +
> +	cmd =3D pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_SET_STD_FILTER)=
;
> +
> +	/* all the 11-bits CAN ID values are represented by one bit in a
> +	 * 64 rows array of 32 bits: the upper 6 bits of the CAN ID select th=
e
> +	 * row while the lowest 5 bits select the bit in that row.
> +	 *
> +	 * bit	filter
> +	 * 1	passed
> +	 * 0	discarded
> +	 */
> +
> +	/* select the row */
> +	cmd->idx =3D row;
> +
> +	/* set/unset bits in the row */
> +	cmd->mask =3D cpu_to_le32(mask);
> +
> +	return pucan_write_cmd(priv);
> +}
> +
> +static int pucan_tx_abort(struct peak_canfd_priv *priv, u16 flags)
> +{
> +	struct pucan_tx_abort *cmd;
> +
> +	cmd =3D pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_TX_ABORT);
> +
> +	cmd->flags =3D cpu_to_le16(flags);
> +
> +	return pucan_write_cmd(priv);
> +}
> +
> +static int pucan_clr_err_counters(struct peak_canfd_priv *priv)
> +{
> +	struct pucan_wr_err_cnt *cmd;
> +
> +	cmd =3D pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_WR_ERR_CNT);
> +
> +	cmd->sel_mask =3D cpu_to_le16(PUCAN_WRERRCNT_TE | PUCAN_WRERRCNT_RE);=

> +	cmd->tx_counter =3D 0;
> +	cmd->rx_counter =3D 0;
> +
> +	return pucan_write_cmd(priv);
> +}
> +
> +static int pucan_set_options(struct peak_canfd_priv *priv, u16 opt_mas=
k)
> +{
> +	struct pucan_options *cmd;
> +
> +	cmd =3D pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_SET_EN_OPTION);=

> +
> +	cmd->options =3D cpu_to_le16(opt_mask);
> +
> +	return pucan_write_cmd(priv);
> +}
> +
> +static int pucan_clr_options(struct peak_canfd_priv *priv, u16 opt_mas=
k)
> +{
> +	struct pucan_options *cmd;
> +
> +	cmd =3D pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_CLR_DIS_OPTION)=
;
> +
> +	cmd->options =3D cpu_to_le16(opt_mask);
> +
> +	return pucan_write_cmd(priv);
> +}
> +
> +static int pucan_setup_rx_barrier(struct peak_canfd_priv *priv)
> +{
> +	pucan_add_cmd(pucan_init_cmd(priv), PUCAN_CMD_RX_BARRIER);
> +
> +	return pucan_write_cmd(priv);
> +}
> +
> +/* handle the reception of one CAN frame */
> +static int pucan_handle_can_rx(struct peak_canfd_priv *priv,
> +			       struct pucan_rx_msg *msg)
> +{
> +	struct net_device_stats *stats =3D &priv->ndev->stats;
> +	struct canfd_frame *cf;
> +	struct sk_buff *skb;
> +	const u16 rx_msg_flags =3D le16_to_cpu(msg->flags);
> +
> +	if (rx_msg_flags & PUCAN_MSG_EXT_DATA_LEN) {
> +		/* CANFD frame case */
> +		skb =3D alloc_canfd_skb(priv->ndev, &cf);
> +		if (!skb)
> +			return -ENOMEM;
> +
> +		if (rx_msg_flags & PUCAN_MSG_BITRATE_SWITCH)
> +			cf->flags |=3D CANFD_BRS;
> +
> +		if (rx_msg_flags & PUCAN_MSG_ERROR_STATE_IND)
> +			cf->flags |=3D CANFD_ESI;
> +
> +		cf->len =3D can_dlc2len(get_canfd_dlc(pucan_msg_get_dlc(msg)));
> +	} else {
> +		/* CAN 2.0 frame case */
> +		skb =3D alloc_can_skb(priv->ndev, (struct can_frame **)&cf);
> +		if (!skb)
> +			return -ENOMEM;
> +
> +		cf->len =3D get_can_dlc(pucan_msg_get_dlc(msg));
> +	}
> +
> +	cf->can_id =3D le32_to_cpu(msg->can_id);
> +
> +	if (rx_msg_flags & PUCAN_MSG_EXT_ID)
> +		cf->can_id |=3D CAN_EFF_FLAG;
> +
> +	if (rx_msg_flags & PUCAN_MSG_RTR)
> +		cf->can_id |=3D CAN_RTR_FLAG;
> +	else
> +		memcpy(cf->data, msg->d, cf->len);
> +
> +	stats->rx_bytes +=3D cf->len;
> +	stats->rx_packets++;
> +	netif_rx(skb);
> +
> +	return 0;
> +}
> +
> +/* handle rx/tx error counters notification */
> +static int pucan_handle_error(struct peak_canfd_priv *priv,
> +			      struct pucan_error_msg *msg)
> +{
> +	priv->bec.txerr =3D msg->tx_err_cnt;
> +	priv->bec.rxerr =3D msg->rx_err_cnt;
> +
> +	return 0;
> +}
> +
> +/* handle status notification */
> +static int pucan_handle_status(struct peak_canfd_priv *priv,
> +			       struct pucan_status_msg *msg)
> +{
> +	struct net_device *ndev =3D priv->ndev;
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +
> +	/* this STATUS is the CNF of the RX_BARRIER: Tx path can be setup */
> +	if (pucan_status_is_rx_barrier(msg)) {
> +		if (priv->enable_tx_path) {
> +			int err =3D priv->enable_tx_path(priv);
> +
> +			if (err)
> +				return err;
> +		}
> +
> +		netif_start_queue(ndev);

I think this must be wake_queue()

> +		return 0;
> +	}
> +
> +	skb =3D alloc_can_err_skb(ndev, &cf);
> +
> +	/* test state error bits according to their priority */
> +	if (pucan_status_is_busoff(msg)) {
> +		netdev_dbg(ndev, "Bus-off entry status\n");
> +		priv->can.state =3D CAN_STATE_BUS_OFF;
> +		priv->can.can_stats.bus_off++;
> +		can_bus_off(ndev);
> +		if (skb)
> +			cf->can_id |=3D CAN_ERR_BUSOFF;
> +
> +	} else if (pucan_status_is_passive(msg)) {
> +		netdev_dbg(ndev, "Error passive status\n");
> +		priv->can.state =3D CAN_STATE_ERROR_PASSIVE;
> +		priv->can.can_stats.error_passive++;
> +		if (skb) {
> +			cf->can_id |=3D CAN_ERR_CRTL;
> +			cf->data[1] =3D (priv->bec.txerr > priv->bec.rxerr) ?
> +					CAN_ERR_CRTL_TX_PASSIVE :
> +					CAN_ERR_CRTL_RX_PASSIVE;
> +			cf->data[6] =3D priv->bec.txerr;
> +			cf->data[7] =3D priv->bec.rxerr;
> +		}
> +
> +	} else if (pucan_status_is_warning(msg)) {
> +		netdev_dbg(ndev, "Error warning status\n");
> +		priv->can.state =3D CAN_STATE_ERROR_WARNING;
> +		priv->can.can_stats.error_warning++;
> +		if (skb) {
> +			cf->can_id |=3D CAN_ERR_CRTL;
> +			cf->data[1] =3D (priv->bec.txerr > priv->bec.rxerr) ?
> +					CAN_ERR_CRTL_TX_WARNING :
> +					CAN_ERR_CRTL_RX_WARNING;
> +			cf->data[6] =3D priv->bec.txerr;
> +			cf->data[7] =3D priv->bec.rxerr;
> +		}
> +
> +	} else if (priv->can.state !=3D CAN_STATE_ERROR_ACTIVE) {
> +		/* back to ERROR_ACTIVE */
> +		netdev_dbg(ndev, "Error active status\n");
> +		can_change_state(ndev, cf, CAN_STATE_ERROR_ACTIVE,
> +				 CAN_STATE_ERROR_ACTIVE);
> +	} else {
> +		kfree_skb(skb);
> +		return 0;
> +	}
> +
> +	if (!skb) {
> +		stats->rx_dropped++;
> +		return -ENOMEM;
> +	}
> +
> +	stats->rx_packets++;
> +	stats->rx_bytes +=3D cf->can_dlc;
> +	netif_rx(skb);
> +
> +	return 0;
> +}
> +
> +/* handle uCAN Rx overflow notification */
> +static int pucan_handle_cache_critical(struct peak_canfd_priv *priv)
> +{
> +	struct net_device_stats *stats =3D &priv->ndev->stats;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +
> +	stats->rx_over_errors++;
> +	stats->rx_errors++;
> +
> +	skb =3D alloc_can_err_skb(priv->ndev, &cf);
> +	if (!skb) {
> +		stats->rx_dropped++;
> +		return -ENOMEM;
> +	}
> +
> +	cf->can_id |=3D CAN_ERR_CRTL;
> +	cf->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
> +
> +	cf->data[6] =3D priv->bec.txerr;
> +	cf->data[7] =3D priv->bec.rxerr;
> +
> +	stats->rx_bytes +=3D cf->can_dlc;
> +	stats->rx_packets++;
> +	netif_rx(skb);
> +
> +	return 0;
> +}
> +
> +/* handle a single uCAN message */
> +int peak_canfd_handle_msg(struct peak_canfd_priv *priv,
> +			  struct pucan_rx_msg *msg)
> +{
> +	u16 msg_type =3D le16_to_cpu(msg->type);
> +	int msg_size =3D le16_to_cpu(msg->size);
> +	int err;
> +
> +	if (!msg_size || !msg_type) {
> +		/* null packet found: end of list */
> +		goto exit;
> +	}
> +
> +	switch (msg_type) {
> +	case PUCAN_MSG_CAN_RX:
> +		err =3D pucan_handle_can_rx(priv, (struct pucan_rx_msg *)msg);
> +		break;
> +	case PUCAN_MSG_ERROR:
> +		err =3D pucan_handle_error(priv, (struct pucan_error_msg *)msg);
> +		break;
> +	case PUCAN_MSG_STATUS:
> +		err =3D pucan_handle_status(priv, (struct pucan_status_msg *)msg);
> +		break;
> +	case PUCAN_MSG_CACHE_CRITICAL:
> +		err =3D pucan_handle_cache_critical(priv);
> +		break;
> +	default:
> +		err =3D 0;
> +	}
> +
> +	if (err < 0)
> +		return err;
> +
> +exit:
> +	return msg_size;
> +}
> +
> +/* handle a list of rx_count messages from rx_msg memory address */
> +int peak_canfd_handle_msgs_list(struct peak_canfd_priv *priv,
> +				struct pucan_rx_msg *msg_list, int msg_count)
> +{
> +	void *msg_ptr =3D msg_list;
> +	int i, msg_size;
> +
> +	for (i =3D 0; i < msg_count; i++) {
> +		msg_size =3D peak_canfd_handle_msg(priv, msg_ptr);
> +
> +		/* a null packet can be found at the end of a list */
> +		if (msg_size <=3D 0)
> +			break;
> +
> +		msg_ptr +=3D msg_size;
> +	}
> +
> +	if (msg_size < 0)
> +		return msg_size;
> +
> +	return i;
> +}
> +
> +static int peak_canfd_start(struct peak_canfd_priv *priv)
> +{
> +	int err;
> +
> +	err =3D pucan_clr_err_counters(priv);
> +	if (err)
> +		goto err_exit;
> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +		err =3D pucan_set_listen_only_mode(priv);
> +	else
> +		err =3D pucan_set_normal_mode(priv);
> +
> +err_exit:
> +	return err;
> +}
> +
> +static void peak_canfd_stop(struct peak_canfd_priv *priv)
> +{
> +	int err;
> +
> +	/* go back to RESET mode */
> +	err =3D pucan_set_reset_mode(priv);
> +	if (err) {
> +		netdev_err(priv->ndev,
> +			   "channel %u reset failed\n", priv->index);
> +	} else {
> +		/* abort last Tx */
> +		pucan_tx_abort(priv, PUCAN_TX_ABORT_FLUSH);
> +	}
> +}
> +
> +static int peak_canfd_set_mode(struct net_device *ndev, enum can_mode =
mode)
> +{
> +	struct peak_canfd_priv *priv =3D netdev_priv(ndev);
> +
> +	switch (mode) {
> +	case CAN_MODE_START:
> +		peak_canfd_start(priv);
> +		netif_wake_queue(ndev);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int peak_canfd_get_berr_counter(const struct net_device *ndev,
> +				       struct can_berr_counter *bec)
> +{
> +	struct peak_canfd_priv *priv =3D netdev_priv(ndev);
> +
> +	*bec =3D priv->bec;
> +	return 0;
> +}
> +
> +static int peak_canfd_open(struct net_device *ndev)
> +{
> +	struct peak_canfd_priv *priv =3D netdev_priv(ndev);
> +	int i, err =3D 0;
> +
> +	err =3D open_candev(ndev);
> +	if (err) {
> +		netdev_err(ndev, "open_candev() failed, error %d\n", err);
> +		goto err_exit;
> +	}
> +
> +	err =3D pucan_set_reset_mode(priv);
> +	if (err)
> +		goto err_close;
> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
> +		if (priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
> +			err =3D pucan_clr_options(priv, PUCAN_OPTION_CANDFDISO);
> +		else
> +			err =3D pucan_set_options(priv, PUCAN_OPTION_CANDFDISO);
> +
> +		if (err)
> +			goto err_close;
> +	}
> +
> +	/* set option: get rx/tx error counters */
> +	err =3D pucan_set_options(priv, PUCAN_OPTION_ERROR);
> +	if (err)
> +		goto err_close;
> +
> +	/* accept all standard CAN ID */
> +	for (i =3D 0; i <=3D PUCAN_FLTSTD_ROW_IDX_MAX; i++)
> +		pucan_set_std_filter(priv, i, 0xffffffff);
> +
> +	err =3D peak_canfd_start(priv);
> +	if (err)
> +		goto err_close;
> +
> +	/* receiving the RB status says when Tx path is ready */
> +	err =3D pucan_setup_rx_barrier(priv);
> +	if (!err)
> +		goto err_exit;
> +
> +err_close:
> +	close_candev(ndev);
> +err_exit:
> +	return err;
> +}
> +
> +static int peak_canfd_set_bittiming(struct net_device *ndev)
> +{
> +	struct peak_canfd_priv *priv =3D netdev_priv(ndev);
> +
> +	return pucan_set_timing_slow(priv, &priv->can.bittiming);
> +}
> +
> +static int peak_canfd_set_data_bittiming(struct net_device *ndev)
> +{
> +	struct peak_canfd_priv *priv =3D netdev_priv(ndev);
> +
> +	return pucan_set_timing_fast(priv, &priv->can.data_bittiming);
> +}
> +
> +static int peak_canfd_close(struct net_device *ndev)
> +{
> +	struct peak_canfd_priv *priv =3D netdev_priv(ndev);
> +
> +	netif_stop_queue(ndev);
> +	peak_canfd_stop(priv);
> +	close_candev(ndev);
> +
> +	return 0;
> +}
> +
> +static netdev_tx_t peak_canfd_start_xmit(struct sk_buff *skb,
> +					 struct net_device *ndev)
> +{
> +	struct peak_canfd_priv *priv =3D netdev_priv(ndev);
> +	struct net_device_stats *stats =3D &ndev->stats;
> +	struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
> +	struct pucan_tx_msg *msg;
> +	u16 msg_size, msg_flags;
> +	int room_left;
> +	u8 can_dlc;
> +
> +	if (can_dropped_invalid_skb(ndev, skb))
> +		return NETDEV_TX_OK;
> +
> +	msg_size =3D ALIGN(sizeof(*msg) + cf->len, 4);
> +	msg =3D priv->alloc_tx_msg(priv, msg_size, &room_left);
> +
> +	/* should never happen */
> +	if (!msg) {
> +		netdev_err(ndev, "Abnormal NULL msg (CAN frame lost)\n");
> +		stats->rx_dropped++;

tx?

> +		netif_stop_queue(ndev);
> +		return NETDEV_TX_OK;

NETDEV_TX_BUSY

> +	}
> +
> +	msg->size =3D cpu_to_le16(msg_size);
> +	msg->type =3D cpu_to_le16(PUCAN_MSG_CAN_TX);
> +	msg_flags =3D 0;
> +
> +	if (cf->can_id & CAN_EFF_FLAG) {
> +		msg_flags |=3D PUCAN_MSG_EXT_ID;
> +		msg->can_id =3D cpu_to_le32(cf->can_id & CAN_EFF_MASK);
> +	} else {
> +		msg->can_id =3D cpu_to_le32(cf->can_id & CAN_SFF_MASK);
> +	}
> +
> +	can_dlc =3D can_len2dlc(cf->len);

it's overwritten later

> +
> +	if (can_is_canfd_skb(skb)) {
> +		/* CAN FD frame format */
> +		can_dlc =3D can_len2dlc(cf->len);
> +
> +		msg_flags |=3D PUCAN_MSG_EXT_DATA_LEN;
> +
> +		if (cf->flags & CANFD_BRS)
> +			msg_flags |=3D PUCAN_MSG_BITRATE_SWITCH;
> +
> +		if (cf->flags & CANFD_ESI)
> +			msg_flags |=3D PUCAN_MSG_ERROR_STATE_IND;
> +	} else {
> +		/* CAN 2.0 frame format */
> +		can_dlc =3D cf->len;
> +
> +		if (cf->can_id & CAN_RTR_FLAG)
> +			msg_flags |=3D PUCAN_MSG_RTR;
> +	}
> +
> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
> +		msg_flags |=3D PUCAN_MSG_LOOPED_BACK;
> +
> +	msg->flags =3D cpu_to_le16(msg_flags);
> +	msg->channel_dlc =3D PUCAN_MSG_CHANNEL_DLC(priv->index, can_dlc);
> +	memcpy(msg->d, cf->data, cf->len);
> +
> +	priv->write_tx_msg(priv);
> +
> +	stats->tx_bytes +=3D can_dlc;
> +	stats->tx_packets++;
> +
> +	/* free the useless skb */
> +	kfree_skb(skb);
> +
> +	/* stop network tx queue if not enough room to save one more msg */
> +	if (room_left < (sizeof(*msg) + CANFD_MAX_DLEN))
> +		netif_stop_queue(ndev);
> +
> +	return NETDEV_TX_OK;
> +}
> +
> +static const struct net_device_ops peak_canfd_netdev_ops =3D {
> +	.ndo_open =3D peak_canfd_open,
> +	.ndo_stop =3D peak_canfd_close,
> +	.ndo_start_xmit =3D peak_canfd_start_xmit,
> +	.ndo_change_mtu =3D can_change_mtu,
> +};
> +
> +struct net_device *alloc_peak_canfd_dev(int sizeof_priv, int echo_skb_=
max,
> +					int index)
> +{
> +	struct net_device *ndev;
> +	struct peak_canfd_priv *priv;
> +
> +	/* allocate the candev object */
> +	ndev =3D alloc_candev(sizeof_priv, echo_skb_max);
> +	if (!ndev)
> +		return NULL;
> +
> +	priv =3D netdev_priv(ndev);
> +
> +	/* complete now socket-can initialization side */
> +	priv->can.state =3D CAN_STATE_STOPPED;
> +	priv->can.bittiming_const =3D &peak_canfd_nominal_const;
> +	priv->can.data_bittiming_const =3D &peak_canfd_data_const;
> +
> +	priv->can.do_set_mode =3D peak_canfd_set_mode;
> +	priv->can.do_get_berr_counter =3D peak_canfd_get_berr_counter;
> +	priv->can.do_set_bittiming =3D peak_canfd_set_bittiming;
> +	priv->can.do_set_data_bittiming =3D peak_canfd_set_data_bittiming;
> +
> +	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK |
> +				CAN_CTRLMODE_LISTENONLY |
> +				CAN_CTRLMODE_3_SAMPLES |
> +				CAN_CTRLMODE_FD |
> +				CAN_CTRLMODE_FD_NON_ISO |
> +				CAN_CTRLMODE_BERR_REPORTING;
> +
> +	priv->ndev =3D ndev;
> +	priv->index =3D index;
> +	priv->cmd_len =3D 0;
> +
> +	ndev->netdev_ops =3D &peak_canfd_netdev_ops;
> +	ndev->dev_id =3D index;
> +
> +	return ndev;
> +}
> diff --git a/drivers/net/can/peak_canfd/peak_canfd_user.h b/drivers/net=
/can/peak_canfd/peak_canfd_user.h
> new file mode 100644
> index 0000000..7bf1dba
> --- /dev/null
> +++ b/drivers/net/can/peak_canfd/peak_canfd_user.h
> @@ -0,0 +1,50 @@
> +/*
> + * CAN driver for PEAK System micro-CAN based adapters
> + *
> + * Copyright (C) 2003-2011 PEAK System-Technik GmbH
> + * Copyright (C) 2011-2013 Stephane Grosjean <s.grosjean@peak-system.c=
om>
> + *
> + * This program is free software; you can redistribute it and/or modif=
y it
> + * under the terms of the GNU General Public License as published
> + * by the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful, but=

> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * General Public License for more details.
> + */
> +#ifndef PEAK_CANFD_USER_H
> +#define PEAK_CANFD_USER_H
> +
> +#include <linux/can/dev/peak_canfd.h>
> +
> +/* data structure private to each uCAN interface */
> +struct peak_canfd_priv {
> +	struct can_priv can;		/* socket-can private data */
> +	struct net_device *ndev;	/* network device */
> +	int index;			/* channel index */
> +
> +	struct can_berr_counter bec;	/* rx/tx err counters */
> +
> +	int cmd_len;
> +	void *cmd_buffer;
> +	int cmd_maxlen;
> +
> +	int (*pre_cmd)(struct peak_canfd_priv *priv);
> +	int (*write_cmd)(struct peak_canfd_priv *priv);
> +	int (*post_cmd)(struct peak_canfd_priv *priv);
> +
> +	int (*enable_tx_path)(struct peak_canfd_priv *priv);
> +	void *(*alloc_tx_msg)(struct peak_canfd_priv *priv, u16 msg_size,
> +			      int *room_left);
> +	int (*write_tx_msg)(struct peak_canfd_priv *priv);
> +};
> +
> +struct net_device *alloc_peak_canfd_dev(int sizeof_priv, int index,
> +					int echo_skb_max);

Why do you have this peak_canfd abstraction here? Are there more HW
using this chip?
> +
> +int peak_canfd_handle_msg(struct peak_canfd_priv *priv,
> +			  struct pucan_rx_msg *msg);
> +int peak_canfd_handle_msgs_list(struct peak_canfd_priv *priv,
> +				struct pucan_rx_msg *rx_msg, int rx_count);
> +#endif
> diff --git a/drivers/net/can/peak_canfd/peak_pciefd_main.c b/drivers/ne=
t/can/peak_canfd/peak_pciefd_main.c
> new file mode 100644
> index 0000000..d041724
> --- /dev/null
> +++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
> @@ -0,0 +1,851 @@
> +/*
> + * Copyright (C) 2007, 2011 Wolfgang Grandegger <wg@grandegger.com>
> + * Copyright (C) 2012 Stephane Grosjean <s.grosjean@peak-system.com>
> + *
> + * Derived from the PCAN project file driver/src/pcan_pci.c:
> + *
> + * Copyright (C) 2001-2006  PEAK System-Technik GmbH
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the version 2 of the GNU General Public Licen=
se
> + * as published by the Free Software Foundation
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/netdevice.h>
> +#include <linux/delay.h>
> +#include <linux/pci.h>
> +#include <linux/io.h>
> +#include <linux/can.h>
> +#include <linux/can/dev.h>
> +
> +#include "peak_canfd_user.h"
> +
> +MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");
> +MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCIe FD family car=
ds");
> +MODULE_SUPPORTED_DEVICE("PEAK PCAN PCIe FD CAN cards");
> +MODULE_LICENSE("GPL v2");
> +
> +#define PCIEFD_DRV_NAME		"peak_pciefd"
> +
> +#define PEAK_PCI_VENDOR_ID	0x001c	/* The PCI device and vendor IDs */
> +#define PEAK_PCIEFD_ID		0x0013	/* for PCIe slot cards */
> +
> +/* PEAK PCIe board access description */
> +#define PCIEFD_BAR0_SIZE		(64 * 1024)
> +#define PCIEFD_RX_DMA_SIZE		(4 * 1024)
> +#define PCIEFD_TX_DMA_SIZE		(4 * 1024)
> +
> +#define PCIEFD_TX_PAGE_SIZE		(2 * 1024)
> +
> +/* System Control Registers */
> +#define PCIEFD_REG_SYS_CTL_SET		0x0000	/* set bits */
> +#define PCIEFD_REG_SYS_CTL_CLR		0x0004	/* clear bits */
> +
> +/* Version info registers */
> +#define PCIEFD_REG_SYS_VER1		0x0040	/* version reg #1 */
> +#define PCIEFD_REG_SYS_VER2		0x0044	/* version reg #2 */
> +
> +/* System Control Registers Bits */
> +#define PCIEFD_SYS_CTL_TS_RST		0x00000001	/* timestamp clock */
> +#define PCIEFD_SYS_CTL_CLK_EN		0x00000002	/* system clock */
> +
> +/* CAN-FD channel addresses */
> +#define PCIEFD_CANX_OFF(c)		(((c) + 1) * 0x1000)
> +
> +#define PCIEFD_ECHO_SKB_MAX		0	/* no need of echo skb list */
> +
> +/* CAN-FD channel registers */
> +#define PCIEFD_REG_CAN_MISC		0x0000	/* Misc. control */
> +#define PCIEFD_REG_CAN_CLK_SEL		0x0008	/* Clock selector */
> +#define PCIEFD_REG_CAN_CMD_PORT_L	0x0010	/* 64-bits command port */
> +#define PCIEFD_REG_CAN_CMD_PORT_H	0x0014
> +#define PCIEFD_REG_CAN_TX_REQ_ACC	0x0020	/* Tx request accumulator */
> +#define PCIEFD_REG_CAN_TX_CTL_SET	0x0030	/* Tx control set register */=

> +#define PCIEFD_REG_CAN_TX_CTL_CLR	0x0038	/* Tx control clear register =
*/
> +#define PCIEFD_REG_CAN_TX_DMA_ADDR_L	0x0040	/* 64-bits addr for Tx DMA=
 */
> +#define PCIEFD_REG_CAN_TX_DMA_ADDR_H	0x0044
> +#define PCIEFD_REG_CAN_RX_CTL_SET	0x0050	/* Rx control set register */=

> +#define PCIEFD_REG_CAN_RX_CTL_CLR	0x0058	/* Rx control clear register =
*/
> +#define PCIEFD_REG_CAN_RX_CTL_WRT	0x0060	/* Rx control write register =
*/
> +#define PCIEFD_REG_CAN_RX_CTL_ACK	0x0068	/* Rx control ACK register */=

> +#define PCIEFD_REG_CAN_RX_DMA_ADDR_L	0x0070	/* 64-bits addr for Rx DMA=
 */
> +#define PCIEFD_REG_CAN_RX_DMA_ADDR_H	0x0074
> +
> +/* CAN-FD channel misc register bits */
> +#define CANFD_MISC_TS_RST		0x00000001	/* timestamp cnt rst */
> +
> +/* CAN-FD channel Clock SELector Source & DIVider */
> +#define CANFD_CLK_SEL_DIV_MASK		0x00000007
> +#define CANFD_CLK_SEL_DIV_60MHZ		0x00000000	/* SRC=3D240MHz only */
> +#define CANFD_CLK_SEL_DIV_40MHZ		0x00000001	/* SRC=3D240MHz only */
> +#define CANFD_CLK_SEL_DIV_30MHZ		0x00000002	/* SRC=3D240MHz only */
> +#define CANFD_CLK_SEL_DIV_24MHZ		0x00000003	/* SRC=3D240MHz only */
> +#define CANFD_CLK_SEL_DIV_20MHZ		0x00000004	/* SRC=3D240MHz only */
> +
> +#define CANFD_CLK_SEL_SRC_MASK		0x00000008	/* 0=3D80MHz, 1=3D240MHz */=

> +#define CANFD_CLK_SEL_SRC_240MHZ	0x00000008
> +#define CANFD_CLK_SEL_SRC_80MHZ		(~CANFD_CLK_SEL_SRC_240MHZ & \
> +							CANFD_CLK_SEL_SRC_MASK)
> +
> +#define CANFD_CLK_SEL_20MHZ		(CANFD_CLK_SEL_SRC_240MHZ |\
> +						CANFD_CLK_SEL_DIV_20MHZ)
> +#define CANFD_CLK_SEL_24MHZ		(CANFD_CLK_SEL_SRC_240MHZ |\
> +						CANFD_CLK_SEL_DIV_24MHZ)
> +#define CANFD_CLK_SEL_30MHZ		(CANFD_CLK_SEL_SRC_240MHZ |\
> +						CANFD_CLK_SEL_DIV_30MHZ)
> +#define CANFD_CLK_SEL_40MHZ		(CANFD_CLK_SEL_SRC_240MHZ |\
> +						CANFD_CLK_SEL_DIV_40MHZ)
> +#define CANFD_CLK_SEL_60MHZ		(CANFD_CLK_SEL_SRC_240MHZ |\
> +						CANFD_CLK_SEL_DIV_60MHZ)
> +#define CANFD_CLK_SEL_80MHZ		(CANFD_CLK_SEL_SRC_80MHZ)
> +
> +/* CAN-FD channel Rx/Tx control register bits */
> +#define CANFD_CTL_UNC_BIT		0x00010000	/* Uncached DMA mem */
> +#define CANFD_CTL_RST_BIT		0x00020000	/* reset DMA action */
> +#define CANFD_CTL_IEN_BIT		0x00040000	/* IRQ enable */
> +
> +/* Rx IRQ Count and Time Limits */
> +#define CANFD_CTL_IRQ_CL_DEF	16	/* Rx msg max nb per IRQ in Rx DMA */
> +#define CANFD_CTL_IRQ_TL_DEF	10	/* Time before IRQ if < CL (x100 =C2=B5=
s) */
> +
> +#define CANFD_OPTIONS_SET	(CANFD_OPTION_ERROR | CANFD_OPTION_BUSLOAD)
> +
> +/* Tx anticipation window (link logical address should be aligned on 2=
K
> + * boundary)
> + */
> +#define PCIEFD_TX_PAGE_COUNT	(PCIEFD_TX_DMA_SIZE / PCIEFD_TX_PAGE_SIZE=
)
> +
> +#define CANFD_MSG_LNK_TX	0x1001	/* Tx msgs link */
> +
> +/* 32-bits IRQ status fields, heading Rx DMA area */
> +static inline int pciefd_irq_tag(u32 irq_status)
> +{
> +	return irq_status & 0x0000000f;
> +}
> +
> +static inline int pciefd_irq_rx_cnt(u32 irq_status)
> +{
> +	return (irq_status & 0x000007f0) >> 4;
> +}
> +
> +static inline int pciefd_irq_is_lnk(u32 irq_status)
> +{
> +	return irq_status & 0x00010000;
> +}
> +
> +/* Rx record */
> +struct pciefd_rx_dma {
> +	__le32 irq_status;
> +	__le32 sys_time_low;
> +	__le32 sys_time_high;
> +	struct pucan_rx_msg msg[0];
> +} __packed __aligned(4);
> +
> +/* Tx Link record */
> +struct pciefd_tx_link {
> +	__le16 size;
> +	__le16 type;
> +	__le32 laddr_lo;
> +	__le32 laddr_hi;
> +} __packed __aligned(4);
> +
> +/* Tx page descriptor */
> +struct pciefd_page {
> +	void *vbase;			/* page virtual address */
> +	dma_addr_t lbase;		/* page logical address */
> +	u32 offset;
> +	u32 size;
> +};
> +
> +#define CANFD_IRQ_SET		0x00000001
> +#define CANFD_TX_PATH_SET	0x00000002
> +
> +/* CAN-FD channel object */
> +struct pciefd_board;
> +struct pciefd_can {
> +	struct peak_canfd_priv ucan;	/* must be the first member */
> +	void __iomem *reg_base;		/* channel config base addr */
> +	struct pciefd_board *board;	/* reverse link */
> +
> +	struct pucan_command pucan_cmd;	/* command buffer */
> +
> +	dma_addr_t rx_dma_laddr;	/* DMA virtual and logical addr */
> +	void *rx_dma_vaddr;		/* for Rx and Tx areas */
> +	dma_addr_t tx_dma_laddr;
> +	void *tx_dma_vaddr;
> +
> +	struct pciefd_page tx_pages[PCIEFD_TX_PAGE_COUNT];
> +	u16 tx_pages_free;		/* free Tx pages counter */
> +	u16 tx_page_index;		/* current page used for Tx */
> +
> +	u32 irq_status;
> +	u32 irq_tag;				/* next irq tag */
> +};
> +
> +/* PEAK-PCIe FD board object */
> +struct pciefd_board {
> +	void __iomem *reg_base;
> +	struct pci_dev *pci_dev;
> +	int can_count;
> +	spinlock_t cmd_lock;		/* 64-bits cmds must be atomic */
> +	struct pciefd_can *can[0];	/* array of network devices */
> +};
> +
> +/* supported device ids. */
> +static const struct pci_device_id peak_pciefd_tbl[] =3D {
> +	{PEAK_PCI_VENDOR_ID, PEAK_PCIEFD_ID, PCI_ANY_ID, PCI_ANY_ID,},
> +	{0,}
> +};
> +
> +MODULE_DEVICE_TABLE(pci, peak_pciefd_tbl);
> +
> +/* read a 32 bits value from a SYS block register */
> +static inline u32 pciefd_sys_readreg(const struct pciefd_board *priv, =
u16 reg)
> +{
> +	return readl(priv->reg_base + reg);
> +}
> +
> +/* write a 32 bits value into a SYS block register */
> +static inline void pciefd_sys_writereg(const struct pciefd_board *priv=
,
> +				       u32 val, u16 reg)
> +{
> +	writel(val, priv->reg_base + reg);
> +}
> +
> +/* read a 32 bits value from CAN-FD block register */
> +static inline u32 pciefd_can_readreg(const struct pciefd_can *priv, u1=
6 reg)
> +{
> +	return readl(priv->reg_base + reg);
> +}
> +
> +/* write a 32 bits value into a CAN-FD block register */
> +static inline void pciefd_can_writereg(const struct pciefd_can *priv,
> +				       u32 val, u16 reg)
> +{
> +	writel(val, priv->reg_base + reg);
> +}
> +
> +/* give a channel logical Rx DMA address to the board */
> +static void pciefd_can_setup_rx_dma(struct pciefd_can *priv)
> +{
> +	/* (DMA must be reset for Rx) */
> +	pciefd_can_writereg(priv, CANFD_CTL_RST_BIT, PCIEFD_REG_CAN_RX_CTL_SE=
T);
> +
> +	/* write the logical address of the Rx DMA area for this channel */
> +	pciefd_can_writereg(priv, (u32)priv->rx_dma_laddr,
> +			    PCIEFD_REG_CAN_RX_DMA_ADDR_L);
> +
> +	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
> +		pciefd_can_writereg(priv, (u32)(priv->rx_dma_laddr >> 32),
> +				    PCIEFD_REG_CAN_RX_DMA_ADDR_H);
> +	else
> +		pciefd_can_writereg(priv, 0, PCIEFD_REG_CAN_RX_DMA_ADDR_H);
> +
> +	/* also indicates that Rx DMA is cacheable */
> +	pciefd_can_writereg(priv, CANFD_CTL_UNC_BIT, PCIEFD_REG_CAN_RX_CTL_CL=
R);
> +}
> +
> +/* clear channel logical Rx DMA address from the board */
> +static void pciefd_can_clear_rx_dma(struct pciefd_can *priv)
> +{
> +	/* DMA must be reset for Rx */
> +	pciefd_can_writereg(priv, CANFD_CTL_RST_BIT, PCIEFD_REG_CAN_RX_CTL_SE=
T);
> +
> +	/* clear the logical address of the Rx DMA area for this channel */
> +	pciefd_can_writereg(priv, 0, PCIEFD_REG_CAN_RX_DMA_ADDR_L);
> +
> +	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
> +		pciefd_can_writereg(priv, 0, PCIEFD_REG_CAN_RX_DMA_ADDR_H);
> +}
> +
> +/* give a channel logical Tx DMA address to the board */
> +static void pciefd_can_setup_tx_dma(struct pciefd_can *priv)
> +{
> +	/* (DMA must be reset for Tx) */
> +	pciefd_can_writereg(priv, CANFD_CTL_RST_BIT, PCIEFD_REG_CAN_TX_CTL_SE=
T);
> +
> +	/* write the logical address of the Tx DMA area for this channel */
> +	pciefd_can_writereg(priv, (u32)priv->tx_dma_laddr,
> +			    PCIEFD_REG_CAN_TX_DMA_ADDR_L);
> +
> +	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
> +		pciefd_can_writereg(priv, (u32)(priv->tx_dma_laddr >> 32),
> +				    PCIEFD_REG_CAN_TX_DMA_ADDR_H);
> +	else
> +		pciefd_can_writereg(priv, 0, PCIEFD_REG_CAN_TX_DMA_ADDR_H);
> +
> +	/* also indicates that Tx DMA is cacheable */
> +	pciefd_can_writereg(priv, CANFD_CTL_UNC_BIT, PCIEFD_REG_CAN_TX_CTL_CL=
R);
> +}
> +
> +/* clear channel logical Tx DMA address from the board */
> +static void pciefd_can_clear_tx_dma(struct pciefd_can *priv)
> +{
> +	/* DMA must be reset for Tx */
> +	pciefd_can_writereg(priv, CANFD_CTL_RST_BIT, PCIEFD_REG_CAN_TX_CTL_SE=
T);
> +
> +	/* clear the logical address of the Tx DMA area for this channel */
> +	pciefd_can_writereg(priv, 0, PCIEFD_REG_CAN_TX_DMA_ADDR_L);
> +
> +	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
> +		pciefd_can_writereg(priv, 0, PCIEFD_REG_CAN_TX_DMA_ADDR_H);
> +}
> +
> +static void pciefd_can_ack_rx_dma(struct pciefd_can *priv)
> +{
> +	/* read value of current IRQ tag and inc it for next one */
> +	priv->irq_tag =3D le32_to_cpu(*(__le32 *)priv->rx_dma_vaddr);
> +	priv->irq_tag++;
> +	priv->irq_tag &=3D 0xf;
> +
> +	/* write the next IRQ tag for this CAN */
> +	pciefd_can_writereg(priv, priv->irq_tag, PCIEFD_REG_CAN_RX_CTL_ACK);
> +}
> +
> +/* IRQ handler */
> +static irqreturn_t pciefd_irq_handler(int irq, void *arg)
> +{
> +	struct pciefd_can *priv =3D arg;
> +	struct pciefd_rx_dma *rx_dma =3D priv->rx_dma_vaddr;
> +
> +	/* INTA mode only to sync with PCIe transaction */
> +	if (!pci_dev_msi_enabled(priv->board->pci_dev))
> +		(void)pciefd_sys_readreg(priv->board, PCIEFD_REG_SYS_VER1);
> +
> +	/* read IRQ status from the first 32-bits of the Rx DMA area */
> +	priv->irq_status =3D le32_to_cpu(rx_dma->irq_status);
> +
> +	/* check if this (shared) IRQ is for this CAN */
> +	if (pciefd_irq_tag(priv->irq_status) !=3D priv->irq_tag)
> +		return IRQ_NONE;
> +
> +	/* handle rx messages (if any) */
> +	peak_canfd_handle_msgs_list(&priv->ucan,
> +				    rx_dma->msg,
> +				    pciefd_irq_rx_cnt(priv->irq_status));
> +
> +	/* handle tx link interrupt (if any) */
> +	if (pciefd_irq_is_lnk(priv->irq_status)) {
> +		priv->tx_pages_free++;
> +
> +		/* wake producer up */
> +		netif_wake_queue(priv->ucan.ndev);
> +	}
> +
> +	/* re-enable Rx DMA transfer for this CAN */
> +	pciefd_can_ack_rx_dma(priv);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int pciefd_enable_tx_path(struct peak_canfd_priv *ucan)
> +{
> +	struct pciefd_can *priv =3D (struct pciefd_can *)ucan;
> +	int i;
> +
> +	/* initialize the Tx pages descriptors */
> +	priv->tx_pages_free =3D PCIEFD_TX_PAGE_COUNT - 1;
> +	priv->tx_page_index =3D 0;
> +
> +	priv->tx_pages[0].vbase =3D priv->tx_dma_vaddr;
> +	priv->tx_pages[0].lbase =3D priv->tx_dma_laddr;
> +
> +	for (i =3D 0; i < PCIEFD_TX_PAGE_COUNT; i++) {
> +		priv->tx_pages[i].offset =3D 0;
> +		priv->tx_pages[i].size =3D PCIEFD_TX_PAGE_SIZE -
> +					 sizeof(struct pciefd_tx_link);
> +		if (i) {
> +			priv->tx_pages[i].vbase =3D
> +					  priv->tx_pages[i - 1].vbase +
> +					  PCIEFD_TX_PAGE_SIZE;
> +			priv->tx_pages[i].lbase =3D
> +					  priv->tx_pages[i - 1].lbase +
> +					  PCIEFD_TX_PAGE_SIZE;
> +		}
> +	}
> +
> +	/* start (TX_RST=3D0) Tx Path */
> +	pciefd_can_writereg(priv, CANFD_CTL_RST_BIT, PCIEFD_REG_CAN_TX_CTL_CL=
R);
> +
> +	return 0;
> +}
> +
> +/* board specific CANFD command pre-processing */
> +static int pciefd_pre_cmd(struct peak_canfd_priv *ucan)
> +{
> +	struct pciefd_can *priv =3D (struct pciefd_can *)ucan;
> +	u16 cmd =3D pucan_cmd_get_opcode(&priv->pucan_cmd);
> +	int err;
> +
> +	/* pre-process command */
> +	switch (cmd) {
> +	case PUCAN_CMD_NORMAL_MODE:
> +	case PUCAN_CMD_LISTEN_ONLY_MODE:
> +
> +		if (ucan->can.state =3D=3D CAN_STATE_BUS_OFF)
> +			break;
> +
> +		/* going into operational mode: setup IRQ handler */
> +		err =3D request_irq(priv->board->pci_dev->irq,
> +				  pciefd_irq_handler,
> +				  IRQF_SHARED,
> +				  PCIEFD_DRV_NAME,
> +				  priv);
> +		if (err)
> +			return err;
> +
> +		/* setup max count of msgs per IRQ */
> +		pciefd_can_writereg(priv, (CANFD_CTL_IRQ_TL_DEF) << 8 |
> +				    CANFD_CTL_IRQ_CL_DEF,
> +				    PCIEFD_REG_CAN_RX_CTL_WRT);
> +
> +		/* clear DMA RST for Rx (Rx start) */
> +		pciefd_can_writereg(priv, CANFD_CTL_RST_BIT,
> +				    PCIEFD_REG_CAN_RX_CTL_CLR);
> +
> +		/* reset timestamps */
> +		pciefd_can_writereg(priv, !CANFD_MISC_TS_RST,
> +				    PCIEFD_REG_CAN_MISC);
> +
> +		/* do an initial ACK */
> +		pciefd_can_ack_rx_dma(priv);
> +
> +		/* enable IRQ for this CAN after having set next irq_tag */
> +		pciefd_can_writereg(priv, CANFD_CTL_IEN_BIT,
> +				    PCIEFD_REG_CAN_RX_CTL_SET);
> +
> +		/* Tx path will be setup as soon as RX_BARRIER is received */
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +/* write a command */
> +static int pciefd_write_cmd(struct peak_canfd_priv *ucan)
> +{
> +	struct pciefd_can *priv =3D (struct pciefd_can *)ucan;
> +	unsigned long flags;
> +
> +	/* 64-bits command is atomic */
> +	spin_lock_irqsave(&priv->board->cmd_lock, flags);
> +
> +	pciefd_can_writereg(priv, *(u32 *)ucan->cmd_buffer,
> +			    PCIEFD_REG_CAN_CMD_PORT_L);
> +	pciefd_can_writereg(priv, *(u32 *)(ucan->cmd_buffer + 4),
> +			    PCIEFD_REG_CAN_CMD_PORT_H);
> +
> +	spin_unlock_irqrestore(&priv->board->cmd_lock, flags);
> +
> +	return 0;
> +}
> +
> +/* board specific CANFD command post-processing */
> +static int pciefd_post_cmd(struct peak_canfd_priv *ucan)
> +{
> +	struct pciefd_can *priv =3D (struct pciefd_can *)ucan;
> +	u16 cmd =3D pucan_cmd_get_opcode(&priv->pucan_cmd);
> +
> +	switch (cmd) {
> +	case PUCAN_CMD_RESET_MODE:
> +
> +		if (ucan->can.state =3D=3D CAN_STATE_STOPPED)
> +			break;
> +
> +		/* controller now in reset mode: */
> +
> +		/* stop (TX_RST=3D1) DMA Tx engine */
> +		pciefd_can_writereg(priv, CANFD_CTL_RST_BIT,
> +				    PCIEFD_REG_CAN_TX_CTL_SET);
> +
> +		/* stop (RX_RST=3D1) DMA Rx engine */
> +		pciefd_can_writereg(priv, CANFD_CTL_RST_BIT,
> +				    PCIEFD_REG_CAN_RX_CTL_SET);
> +
> +		/* disable IRQ for this CAN */
> +		pciefd_can_writereg(priv, CANFD_CTL_IEN_BIT,
> +				    PCIEFD_REG_CAN_RX_CTL_CLR);
> +
> +		free_irq(priv->board->pci_dev->irq, priv);
> +
> +		ucan->can.state =3D CAN_STATE_STOPPED;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static void *pciefd_alloc_tx_msg(struct peak_canfd_priv *ucan, u16 msg=
_size,
> +				 int *room_left)
> +{
> +	struct pciefd_can *priv =3D (struct pciefd_can *)ucan;
> +	struct pciefd_page *page =3D priv->tx_pages + priv->tx_page_index;
> +	void *msg;
> +
> +	if (page->offset + msg_size > page->size) {
> +		struct pciefd_tx_link *lk;
> +
> +		/* not enough space in this page: try another one */
> +		if (!priv->tx_pages_free) {
> +			/* Tx overflow */
> +			return NULL;
> +		}
> +
> +		priv->tx_pages_free--;
> +
> +		/* keep address of the very last free slot of current page */
> +		lk =3D page->vbase + page->offset;
> +
> +		/* next, move on a new free page */
> +		priv->tx_page_index =3D (priv->tx_page_index + 1) %
> +							PCIEFD_TX_PAGE_COUNT;
> +		page =3D priv->tx_pages + priv->tx_page_index;
> +
> +		/* put link record to this new page at the end of prev one */
> +		lk->size =3D cpu_to_le16(sizeof(*lk));
> +		lk->type =3D cpu_to_le16(CANFD_MSG_LNK_TX);
> +		lk->laddr_lo =3D cpu_to_le32(page->lbase);
> +
> +		if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT))
> +			lk->laddr_hi =3D cpu_to_le32(page->lbase >> 32);
> +		else
> +			lk->laddr_hi =3D 0;
> +
> +		/* next msgs will be put from the begininng of this new page */
> +		page->offset =3D 0;
> +	}
> +
> +	msg =3D page->vbase + page->offset;
> +
> +	/* this slot is now reserved for writing next frame */
> +	page->offset +=3D msg_size;
> +
> +	/* give back room left in the tx ring */
> +	*room_left =3D priv->tx_pages_free * page->size +
> +		     page->size - page->offset;
> +
> +	return msg;
> +}
> +
> +static int pciefd_write_tx_msg(struct peak_canfd_priv *ucan)
> +{
> +	struct pciefd_can *priv =3D (struct pciefd_can *)ucan;
> +
> +	/* tell the board a frame has been written in Tx DMA area */
> +	pciefd_can_writereg(priv, 1, PCIEFD_REG_CAN_TX_REQ_ACC);
> +
> +	return 0;
> +}
> +
> +/* probe for CAN-FD channel #pciefd_board->can_count */
> +static int pciefd_can_probe(struct pciefd_board *pciefd)
> +{
> +	struct net_device *ndev;
> +	struct pciefd_can *priv;
> +	u32 clk;
> +	int err;
> +
> +	/* allocate the candev object */
> +	ndev =3D alloc_peak_canfd_dev(sizeof(*priv), PCIEFD_ECHO_SKB_MAX,
> +				    pciefd->can_count);
> +	if (!ndev) {
> +		dev_err(&pciefd->pci_dev->dev,
> +			"failed to alloc candev object\n");
> +		goto failure;
> +	}
> +
> +	priv =3D netdev_priv(ndev);
> +
> +	/* fill-in candev private object: */
> +
> +	/* setup PCIe-FD own callbacks */
> +	priv->ucan.pre_cmd =3D pciefd_pre_cmd;
> +	priv->ucan.write_cmd =3D pciefd_write_cmd;
> +	priv->ucan.post_cmd =3D pciefd_post_cmd;
> +	priv->ucan.enable_tx_path =3D pciefd_enable_tx_path;
> +	priv->ucan.alloc_tx_msg =3D pciefd_alloc_tx_msg;
> +	priv->ucan.write_tx_msg =3D pciefd_write_tx_msg;
> +
> +	/* setup PCIe-FD own command buffer */
> +	priv->ucan.cmd_buffer =3D &priv->pucan_cmd;
> +	priv->ucan.cmd_maxlen =3D sizeof(priv->pucan_cmd);
> +
> +	priv->board =3D pciefd;
> +
> +	/* CAN config regs block address */
> +	priv->reg_base =3D pciefd->reg_base + PCIEFD_CANX_OFF(priv->ucan.inde=
x);
> +
> +	/* allocate non-cacheable DMA'able 4KB memory area for Rx */
> +	priv->rx_dma_vaddr =3D dmam_alloc_coherent(&pciefd->pci_dev->dev,
> +						 PCIEFD_RX_DMA_SIZE,
> +						 &priv->rx_dma_laddr,
> +						 GFP_KERNEL);
> +	if (!priv->rx_dma_vaddr) {
> +		dev_err(&pciefd->pci_dev->dev,
> +			"Rx dmam_alloc_coherent(%u) failure\n",
> +			PCIEFD_RX_DMA_SIZE);
> +		goto err_free_candev;
> +	}
> +
> +	/* allocate non-cacheable DMA'able 4KB memory area for Tx */
> +	priv->tx_dma_vaddr =3D dmam_alloc_coherent(&pciefd->pci_dev->dev,
> +						 PCIEFD_TX_DMA_SIZE,
> +						 &priv->tx_dma_laddr,
> +						 GFP_KERNEL);
> +	if (!priv->tx_dma_vaddr) {
> +		dev_err(&pciefd->pci_dev->dev,
> +			"Tx dmaim_alloc_coherent(%u) failure\n",
> +			PCIEFD_TX_DMA_SIZE);
> +		goto err_free_rx;
> +	}
> +
> +	/* CAN clock in RST mode */
> +	pciefd_can_writereg(priv, CANFD_MISC_TS_RST, PCIEFD_REG_CAN_MISC);
> +
> +	/* read current clock value */
> +	clk =3D pciefd_can_readreg(priv, PCIEFD_REG_CAN_CLK_SEL);
> +	switch (clk) {
> +	case CANFD_CLK_SEL_20MHZ:
> +		priv->ucan.can.clock.freq =3D 20 * 1000 * 1000;
> +		break;
> +	case CANFD_CLK_SEL_24MHZ:
> +		priv->ucan.can.clock.freq =3D 24 * 1000 * 1000;
> +		break;
> +	case CANFD_CLK_SEL_30MHZ:
> +		priv->ucan.can.clock.freq =3D 30 * 1000 * 1000;
> +		break;
> +	case CANFD_CLK_SEL_40MHZ:
> +		priv->ucan.can.clock.freq =3D 40 * 1000 * 1000;
> +		break;
> +	case CANFD_CLK_SEL_60MHZ:
> +		priv->ucan.can.clock.freq =3D 60 * 1000 * 1000;
> +		break;
> +	default:
> +		pciefd_can_writereg(priv, CANFD_CLK_SEL_80MHZ,
> +				    PCIEFD_REG_CAN_CLK_SEL);
> +
> +		/* fallthough */
> +	case CANFD_CLK_SEL_80MHZ:
> +		priv->ucan.can.clock.freq =3D 80 * 1000 * 1000;
> +		break;
> +	}
> +
> +	ndev->irq =3D pciefd->pci_dev->irq;
> +
> +	SET_NETDEV_DEV(ndev, &pciefd->pci_dev->dev);
> +
> +	err =3D register_candev(ndev);
> +	if (err) {
> +		dev_err(&pciefd->pci_dev->dev,
> +			"couldn't register CAN device: %d\n", err);
> +		goto err_free_tx;
> +	}
> +
> +	/* everything is ok so setup DMA addresses */
> +	pciefd_can_setup_rx_dma(priv);
> +	pciefd_can_setup_tx_dma(priv);
> +
> +	/* save the object address in the board structure */
> +	pciefd->can[pciefd->can_count] =3D priv;
> +
> +	dev_info(&pciefd->pci_dev->dev, "%s at reg_base=3D0x%p irq=3D%d\n",
> +		 ndev->name, priv->reg_base, pciefd->pci_dev->irq);
> +
> +	return 0;
> +
> +err_free_tx:
> +	dmam_free_coherent(&pciefd->pci_dev->dev, PCIEFD_TX_DMA_SIZE,
> +			   priv->tx_dma_vaddr, priv->tx_dma_laddr);
> +err_free_rx:
> +	dmam_free_coherent(&pciefd->pci_dev->dev, PCIEFD_RX_DMA_SIZE,
> +			   priv->rx_dma_vaddr, priv->rx_dma_laddr);
> +err_free_candev:
> +	free_candev(ndev);
> +
> +failure:
> +	return -ENOMEM;
> +}
> +
> +/* remove a CAN-FD channel by releasing all of its resources */
> +static void pciefd_can_remove(struct pciefd_can *priv)
> +{
> +	/* unregister (close) the can device to go back to RST mode first */
> +	unregister_candev(priv->ucan.ndev);
> +
> +	/* clear DMA logical addresses */
> +	pciefd_can_clear_tx_dma(priv);
> +	pciefd_can_clear_rx_dma(priv);
> +
> +	/* Tx DMA area can now be released */
> +	dmam_free_coherent(&priv->board->pci_dev->dev, PCIEFD_TX_DMA_SIZE,
> +			   priv->tx_dma_vaddr, priv->tx_dma_laddr);
> +
> +	/* Rx DMA area can now be released */
> +	dmam_free_coherent(&priv->board->pci_dev->dev, PCIEFD_RX_DMA_SIZE,
> +			   priv->rx_dma_vaddr, priv->rx_dma_laddr);
> +
> +	/* finally, free the candev object */
> +	free_candev(priv->ucan.ndev);
> +}
> +
> +/* remove all CAN-FD channels by releasing their own resources */
> +static void pciefd_can_remove_all(struct pciefd_board *pciefd)
> +{
> +	while (pciefd->can_count > 0)
> +		pciefd_can_remove(pciefd->can[--pciefd->can_count]);
> +}
> +
> +/* probe for the entire device */
> +static int peak_pciefd_probe(struct pci_dev *pdev,
> +			     const struct pci_device_id *ent)
> +{
> +	struct pciefd_board *pciefd;
> +	int err, can_count;
> +	u16 sub_sys_id;
> +	u8 hw_ver_major;
> +	u8 hw_ver_minor;
> +	u8 hw_ver_sub;
> +	u32 v2;
> +
> +	err =3D pci_enable_device(pdev);
> +	if (err)
> +		return err;
> +	err =3D pci_request_regions(pdev, PCIEFD_DRV_NAME);
> +	if (err)
> +		goto err_disable_pci;
> +
> +	/* the number of channels depends on sub-system id */
> +	err =3D pci_read_config_word(pdev, PCI_SUBSYSTEM_ID, &sub_sys_id);
> +	if (err)
> +		goto err_release_regions;
> +
> +	dev_dbg(&pdev->dev, "probing device %04x:%04x:%04x\n",
> +		pdev->vendor, pdev->device, sub_sys_id);
> +
> +	if (sub_sys_id >=3D 0x0012)
> +		can_count =3D 4;
> +	else if (sub_sys_id >=3D 0x0010)
> +		can_count =3D 3;
> +	else if (sub_sys_id >=3D 0x0004)
> +		can_count =3D 2;
> +	else
> +		can_count =3D 1;
> +
> +	/* allocate board structure object */
> +	pciefd =3D devm_kzalloc(&pdev->dev, sizeof(*pciefd) +
> +			      can_count * sizeof(*pciefd->can),
> +			      GFP_KERNEL);
> +	if (!pciefd) {
> +		err =3D -ENOMEM;
> +		goto err_release_regions;
> +	}
> +
> +	/* initialize the board structure */
> +	pciefd->pci_dev =3D pdev;
> +	spin_lock_init(&pciefd->cmd_lock);
> +
> +	/* save the PCI BAR0 virtual address for further system regs access *=
/
> +	pciefd->reg_base =3D pci_iomap(pdev, 0, PCIEFD_BAR0_SIZE);
> +	if (!pciefd->reg_base) {
> +		dev_err(&pdev->dev, "failed to map PCI resource #0\n");
> +		err =3D -ENOMEM;
> +		goto err_free_pciefd;
> +	}
> +
> +	/* read the firmware version number */
> +	v2 =3D pciefd_sys_readreg(pciefd, PCIEFD_REG_SYS_VER2);
> +
> +	hw_ver_major =3D (v2 & 0x0000f000) >> 12;
> +	hw_ver_minor =3D (v2 & 0x00000f00) >> 8;
> +	hw_ver_sub =3D (v2 & 0x000000f0) >> 4;
> +
> +	dev_info(&pdev->dev,
> +		 "%ux CAN-FD PCAN-PCIe FPGA v%u.%u.%u:\n", can_count,
> +		 hw_ver_major, hw_ver_minor, hw_ver_sub);
> +
> +	/* stop system clock */
> +	pciefd_sys_writereg(pciefd, PCIEFD_SYS_CTL_CLK_EN,
> +			    PCIEFD_REG_SYS_CTL_CLR);
> +
> +	pci_set_master(pdev);
> +
> +	/* create now the corresponding channels objects */
> +	while (pciefd->can_count < can_count) {
> +		err =3D pciefd_can_probe(pciefd);
> +		if (err)
> +			goto err_free_canfd;
> +
> +		pciefd->can_count++;
> +	}
> +
> +	/* set system timestamps counter in RST mode */
> +	pciefd_sys_writereg(pciefd, PCIEFD_SYS_CTL_TS_RST,
> +			    PCIEFD_REG_SYS_CTL_SET);
> +
> +	/* wait a bit (read cycle) */
> +	(void)pciefd_sys_readreg(pciefd, PCIEFD_REG_SYS_VER1);
> +
> +	/* free all clocks */
> +	pciefd_sys_writereg(pciefd, PCIEFD_SYS_CTL_TS_RST,
> +			    PCIEFD_REG_SYS_CTL_CLR);
> +
> +	/* start system clock */
> +	pciefd_sys_writereg(pciefd, PCIEFD_SYS_CTL_CLK_EN,
> +			    PCIEFD_REG_SYS_CTL_SET);
> +
> +	/* remember the board structure address in the device user data */
> +	pci_set_drvdata(pdev, pciefd);
> +
> +	return 0;
> +
> +err_free_canfd:
> +	pciefd_can_remove_all(pciefd);
> +
> +	pci_iounmap(pdev, pciefd->reg_base);
> +
> +err_free_pciefd:
> +	devm_kfree(&pdev->dev, pciefd);
> +
> +err_release_regions:
> +	pci_release_regions(pdev);
> +
> +err_disable_pci:
> +	pci_disable_device(pdev);
> +
> +	return err;
> +}
> +
> +/* free the board structure object, as well as its resources: */
> +static void peak_pciefd_remove(struct pci_dev *pdev)
> +{
> +	struct pciefd_board *pciefd =3D pci_get_drvdata(pdev);
> +
> +	/* release CAN-FD channels resources */
> +	pciefd_can_remove_all(pciefd);
> +
> +	pci_iounmap(pdev, pciefd->reg_base);
> +
> +	devm_kfree(&pdev->dev, pciefd);
> +
> +	pci_release_regions(pdev);
> +	pci_disable_device(pdev);
> +}
> +
> +static struct pci_driver peak_pciefd_driver =3D {
> +	.name =3D PCIEFD_DRV_NAME,
> +	.id_table =3D peak_pciefd_tbl,
> +	.probe =3D peak_pciefd_probe,
> +	.remove =3D peak_pciefd_remove,
> +};
> +
> +module_pci_driver(peak_pciefd_driver);
> diff --git a/include/linux/can/dev/peak_canfd.h b/include/linux/can/dev=
/peak_canfd.h
> index 25e20ef..46dceef 100644
> --- a/include/linux/can/dev/peak_canfd.h
> +++ b/include/linux/can/dev/peak_canfd.h
> @@ -23,11 +23,14 @@
>  #define PUCAN_CMD_LISTEN_ONLY_MODE	0x003
>  #define PUCAN_CMD_TIMING_SLOW		0x004
>  #define PUCAN_CMD_TIMING_FAST		0x005
> +#define PUCAN_CMD_SET_STD_FILTER	0x006
> +#define PUCAN_CMD_RESERVED2		0x007
>  #define PUCAN_CMD_FILTER_STD		0x008
>  #define PUCAN_CMD_TX_ABORT		0x009
>  #define PUCAN_CMD_WR_ERR_CNT		0x00a
>  #define PUCAN_CMD_SET_EN_OPTION		0x00b
>  #define PUCAN_CMD_CLR_DIS_OPTION	0x00c
> +#define PUCAN_CMD_RX_BARRIER		0x010
>  #define PUCAN_CMD_END_OF_COLLECTION	0x3ff
> =20
>  /* uCAN received messages list */
> @@ -35,6 +38,10 @@
>  #define PUCAN_MSG_ERROR			0x0002
>  #define PUCAN_MSG_STATUS		0x0003
>  #define PUCAN_MSG_BUSLOAD		0x0004
> +
> +#define PUCAN_MSG_CACHE_CRITICAL	0x0102
> +
> +/* uCAN transmitted messages */
>  #define PUCAN_MSG_CAN_TX		0x1000
> =20
>  /* uCAN command common header */
> @@ -43,6 +50,12 @@ struct __packed pucan_command {
>  	u16	args[3];
>  };
> =20
> +/* return the opcode from the opcode_channel field of a command */
> +static inline u16 pucan_cmd_get_opcode(struct pucan_command *c)
> +{
> +	return le16_to_cpu(c->opcode_channel) & 0x3ff;
> +}
> +
>  #define PUCAN_TSLOW_BRP_BITS		10
>  #define PUCAN_TSLOW_TSGEG1_BITS		8
>  #define PUCAN_TSLOW_TSGEG2_BITS		7
> @@ -108,6 +121,27 @@ struct __packed pucan_filter_std {
>  	__le32	mask;		/* CAN-ID bitmask in idx range */
>  };
> =20
> +#define PUCAN_FLTSTD_ROW_IDX_MAX	((1 << PUCAN_FLTSTD_ROW_IDX_BITS) - 1=
)
> +
> +/* uCAN SET_STD_FILTER command fields */
> +struct __packed pucan_std_filter {
> +	__le16	opcode_channel;
> +
> +	u8	unused;
> +	u8	idx;
> +	__le32	mask;		/* CAN-ID bitmask in idx range */
> +};
> +
> +/* uCAN TX_ABORT commands fields */
> +#define PUCAN_TX_ABORT_FLUSH		0x0001
> +
> +struct __packed pucan_tx_abort {
> +	__le16	opcode_channel;
> +
> +	__le16	flags;
> +	u32	unused;
> +};
> +
>  /* uCAN WR_ERR_CNT command fields */
>  #define PUCAN_WRERRCNT_TE		0x4000	/* Tx error cntr write Enable */
>  #define PUCAN_WRERRCNT_RE		0x8000	/* Rx error cntr write Enable */
> @@ -184,6 +218,12 @@ struct __packed pucan_error_msg {
>  	u8	rx_err_cnt;
>  };
> =20
> +static inline int pucan_error_get_channel(const struct pucan_error_msg=
 *msg)
> +{
> +	return msg->channel_type_d & 0x0f;
> +}
> +
> +#define PUCAN_RX_BARRIER		0x10
>  #define PUCAN_BUS_PASSIVE		0x20
>  #define PUCAN_BUS_WARNING		0x40
>  #define PUCAN_BUS_BUSOFF		0x80
> @@ -197,6 +237,31 @@ struct __packed pucan_status_msg {
>  	u8	unused[3];
>  };
> =20
> +static inline int pucan_status_get_channel(const struct pucan_status_m=
sg *msg)
> +{
> +	return msg->channel_p_w_b & 0x0f;
> +}
> +
> +static inline int pucan_status_is_rx_barrier(const struct pucan_status=
_msg *msg)
> +{
> +	return msg->channel_p_w_b & PUCAN_RX_BARRIER;
> +}
> +
> +static inline int pucan_status_is_passive(const struct pucan_status_ms=
g *msg)
> +{
> +	return msg->channel_p_w_b & PUCAN_BUS_PASSIVE;
> +}
> +
> +static inline int pucan_status_is_warning(const struct pucan_status_ms=
g *msg)
> +{
> +	return msg->channel_p_w_b & PUCAN_BUS_WARNING;
> +}
> +
> +static inline int pucan_status_is_busoff(const struct pucan_status_msg=
 *msg)
> +{
> +	return msg->channel_p_w_b & PUCAN_BUS_BUSOFF;
> +}
> +
>  /* uCAN transmitted message format */
>  #define PUCAN_MSG_CHANNEL_DLC(c, d)	(((c) & 0xf) | ((d) << 4))
> =20
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--DdiQnmBroI9SXefm6kW5KgjuTcMSBRki8--

--TEbWwh5Okqk1fJiJav0upH1IPs3ePwGTr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlh43YoACgkQPTuqJayp
JWr77QgAlQJudU7O/z16xheclgzaZ5ghywV16Z1zjfTrUgc2z7H5nrTomZS9VxDM
xxNV9u6POSHoPc7bjCAA22oknp8/T5ffUu5Z9XgiO0atJ9Ar72o8vvdMWdcyX6tK
HEUvlfUTkN4Xx9/8iW83QUr16xzXOTUY8iS9wG7+o1zHBjam7tNslfP1unARv6m1
2X/eXom+3p2U294ODc61pLrh7ZcybmaMEuDgkXo0oczoEU1nZWRup/Zz9Svn/U12
9yyzjTF+Tqpiifp3k6P2i06BVgzyNuw1I427ETpwbw8C16J5sZV2675W0+PUSk6W
itxWebygJSA8XzxQtQXkLPpqpoCOTQ==
=6kNX
-----END PGP SIGNATURE-----

--TEbWwh5Okqk1fJiJav0upH1IPs3ePwGTr--
