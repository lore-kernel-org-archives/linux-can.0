From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/3 v2] can/usb: PEAK-System Technik PCAN-USB specific
 part
Date: Wed, 18 Jan 2012 14:30:30 +0100
Message-ID: <4F16C976.5000405@grandegger.com>
References: <1326468404-19330-1-git-send-email-s.grosjean@peak-system.com> <1326468404-19330-3-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59825 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757397Ab2ARNad (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2012 08:30:33 -0500
In-Reply-To: <1326468404-19330-3-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

On 01/13/2012 04:26 PM, Stephane Grosjean wrote:
> This patch adds the specific part which handles the PCAN-USB adapter from
> PEAK-System Technik (http://www.peak-system.com). The PCAN-USB adapter is
> a sja1000 based, mono-channel USB 1.1 adapter compliant with CAN
> specifications 2.0A (11-bit ID) and 2.0B (29-bit ID).
> 
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> Tested-by: Stephane Grosjean <s.grosjean@peak-system.com>

It's unusual to add "Tested-by" if there is already your
"Signed-off-by". We assume that you have tested the patches.

> ---
>  drivers/net/can/usb/peak_usb/pcan_usb.c |  751 +++++++++++++++++++++++++++++++
>  1 files changed, 751 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/net/can/usb/peak_usb/pcan_usb.c
> 
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
> new file mode 100644
> index 0000000..100fc2e
> --- /dev/null
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
...
> +/*
> + * decode non-data usb message
> + */
> +static int pcan_usb_decode_status(struct pcan_usb_msg_context *mc,
> +				  u8 status_len)
> +{
> +	u8 rec_len = status_len & PCAN_USB_STATUSLEN_DLC;
> +	struct sk_buff *skb;
> +	struct can_frame *cf;
> +	struct timeval tv;
> +	u8 f, n;
> +
> +	/* check whether function and number can be read */
> +	if ((mc->ptr + 2) > mc->end)
> +		return -EINVAL;
> +
> +	f = mc->ptr[0];
> +	n = mc->ptr[1];
> +	mc->ptr += 2;
> +
> +	if (status_len & PCAN_USB_STATUSLEN_TIMESTAMP) {
> +		int err = pcan_usb_decode_ts(mc, !mc->rec_idx);
> +
> +		if (err)
> +			return err;
> +	}
> +
> +	switch (f) {
> +	case PCAN_USB_REC_ERROR:
> +		/* no status flag => ignore record */
> +		if (!n)
> +			break;
> +
> +		/* ignore this error until 1st ts received */
> +		if (n == PCAN_USB_ERROR_QOVR)
> +			if (!mc->pdev->time_ref.tick_count)
> +				break;
> +
> +		/* allocate an skb to store the error frame */
> +		skb = alloc_can_err_skb(mc->netdev, &cf);
> +		if (!skb)
> +			return -ENOMEM;
> +
> +		if (n & (PCAN_USB_ERROR_RXQOVR | PCAN_USB_ERROR_QOVR)) {
> +			cf->can_id |= CAN_ERR_CRTL;
> +			cf->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
> +			mc->netdev->stats.rx_over_errors++;
> +			mc->netdev->stats.rx_errors++;
> +		}
> +		if (n & PCAN_USB_ERROR_BUS_OFF) {
> +			cf->can_id |= CAN_ERR_BUSOFF;
> +			can_bus_off(mc->netdev);
> +		}
> +		if (n & PCAN_USB_ERROR_BUS_HEAVY) {
> +			cf->can_id |= CAN_ERR_CRTL;
> +			cf->data[1] |= CAN_ERR_CRTL_TX_PASSIVE |
> +					CAN_ERR_CRTL_RX_PASSIVE;
> +			mc->pdev->dev.can.can_stats.error_passive++;
> +		}
> +		if (n & PCAN_USB_ERROR_BUS_LIGHT) {
> +			cf->can_id |= CAN_ERR_CRTL;
> +			cf->data[1] |= CAN_ERR_CRTL_TX_WARNING |
> +					CAN_ERR_CRTL_RX_WARNING;
> +			mc->pdev->dev.can.can_stats.error_warning++;
> +		}
> +
> +		if (cf->can_id != CAN_ERR_FLAG) {
> +			if (status_len & PCAN_USB_STATUSLEN_TIMESTAMP) {
> +				peak_usb_get_ts_tv(&mc->pdev->time_ref,
> +					mc->ts16, &tv);
> +				skb->tstamp = timeval_to_ktime(tv);
> +			}
> +			netif_rx(skb);
> +			mc->netdev->stats.rx_packets++;
> +			mc->netdev->stats.rx_bytes += cf->can_dlc;
> +		} else {
> +			dev_kfree_skb(skb);

Cannot happen because (cf->can_id != CAN_ERR_FLAG) is alway true.

Wolfgang.
