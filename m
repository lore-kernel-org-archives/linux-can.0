From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2] can: fix spelling errors
Date: Sat, 06 Dec 2014 11:40:39 +0100
Message-ID: <5482DD27.3060609@hartkopp.net>
References: <1417790950-6161-1-git-send-email-jmmahler@gmail.com> <1417802078-9309-1-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:12544 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbaLFKkm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 6 Dec 2014 05:40:42 -0500
In-Reply-To: <1417802078-9309-1-git-send-email-jmmahler@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jeremiah Mahler <jmmahler@gmail.com>, linux-can@vger.kernel.org
Cc: Jochen Frieling <j.frieling@pengutronix.de>



On 05.12.2014 18:54, Jeremiah Mahler wrote:
> Fix various spelling errors in the comments of the CAN modules.
>
> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks Jeremiah!

> ---
>
> Notes:
>      Changes in v2:
>        - fix the spelling error in the spelling fix
>
>   drivers/net/can/cc770/cc770.c |  2 +-
>   net/can/af_can.c              |  2 +-
>   net/can/bcm.c                 | 12 ++++++------
>   net/can/gw.c                  |  2 +-
>   4 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
> index d837927..c486fe5 100644
> --- a/drivers/net/can/cc770/cc770.c
> +++ b/drivers/net/can/cc770/cc770.c
> @@ -60,7 +60,7 @@ MODULE_DESCRIPTION(KBUILD_MODNAME "CAN netdevice driver");
>    *
>    * The message objects 1..14 can be used for TX and RX while the message
>    * objects 15 is optimized for RX. It has a shadow register for reliable
> - * data receiption under heavy bus load. Therefore it makes sense to use
> + * data reception under heavy bus load. Therefore it makes sense to use
>    * this message object for the needed use case. The frame type (EFF/SFF)
>    * for the message object 15 can be defined via kernel module parameter
>    * "msgobj15_eff". If not equal 0, it will receive 29-bit EFF frames,
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index ac05be1..66e0804 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -521,7 +521,7 @@ static void can_rx_delete_receiver(struct rcu_head *rp)
>
>   /**
>    * can_rx_unregister - unsubscribe CAN frames from a specific interface
> - * @dev: pointer to netdevice (NULL => unsubcribe from 'all' CAN devices list)
> + * @dev: pointer to netdevice (NULL => unsubscribe from 'all' CAN devices list)
>    * @can_id: CAN identifier
>    * @mask: CAN mask
>    * @func: callback function on filter match
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 6169aa2..ee9ffd9 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -439,7 +439,7 @@ static void bcm_rx_update_and_send(struct bcm_op *op,
>   	/* mark as used and throttled by default */
>   	lastdata->can_dlc |= (RX_RECV|RX_THR);
>
> -	/* throtteling mode inactive ? */
> +	/* throttling mode inactive ? */
>   	if (!op->kt_ival2.tv64) {
>   		/* send RX_CHANGED to the user immediately */
>   		bcm_rx_changed(op, lastdata);
> @@ -450,7 +450,7 @@ static void bcm_rx_update_and_send(struct bcm_op *op,
>   	if (hrtimer_active(&op->thrtimer))
>   		return;
>
> -	/* first receiption with enabled throttling mode */
> +	/* first reception with enabled throttling mode */
>   	if (!op->kt_lastmsg.tv64)
>   		goto rx_changed_settime;
>
> @@ -478,7 +478,7 @@ static void bcm_rx_cmp_to_index(struct bcm_op *op, unsigned int index,
>   				const struct can_frame *rxdata)
>   {
>   	/*
> -	 * no one uses the MSBs of can_dlc for comparation,
> +	 * no one uses the MSBs of can_dlc for comparison,
>   	 * so we use it here to detect the first time of reception
>   	 */
>
> @@ -508,7 +508,7 @@ static void bcm_rx_cmp_to_index(struct bcm_op *op, unsigned int index,
>   }
>
>   /*
> - * bcm_rx_starttimer - enable timeout monitoring for CAN frame receiption
> + * bcm_rx_starttimer - enable timeout monitoring for CAN frame reception
>    */
>   static void bcm_rx_starttimer(struct bcm_op *op)
>   {
> @@ -537,7 +537,7 @@ static void bcm_rx_timeout_tsklet(unsigned long data)
>   }
>
>   /*
> - * bcm_rx_timeout_handler - when the (cyclic) CAN frame receiption timed out
> + * bcm_rx_timeout_handler - when the (cyclic) CAN frame reception timed out
>    */
>   static enum hrtimer_restart bcm_rx_timeout_handler(struct hrtimer *hrtimer)
>   {
> @@ -625,7 +625,7 @@ static enum hrtimer_restart bcm_rx_thr_handler(struct hrtimer *hrtimer)
>   }
>
>   /*
> - * bcm_rx_handler - handle a CAN frame receiption
> + * bcm_rx_handler - handle a CAN frame reception
>    */
>   static void bcm_rx_handler(struct sk_buff *skb, void *data)
>   {
> diff --git a/net/can/gw.c b/net/can/gw.c
> index 050a211..295f62e 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -361,7 +361,7 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>   	 * The Controller Area Network controllers only accept CAN frames with
>   	 * correct CRCs - which are not visible in the controller registers.
>   	 * According to skbuff.h documentation the csum_start element for IP
> -	 * checksums is undefined/unsued when ip_summed == CHECKSUM_UNNECESSARY.
> +	 * checksums is undefined/unused when ip_summed == CHECKSUM_UNNECESSARY.
>   	 * Only CAN skbs can be processed here which already have this property.
>   	 */
>
>
