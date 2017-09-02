From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 1/2] can: bcm: increase tx cycle time precision
Date: Sat, 2 Sep 2017 20:02:07 +0200
Message-ID: <6e00d84b-967b-cf0a-f988-35b109265b89@hartkopp.net>
References: <20170824115903.3661-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:19786 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752723AbdIBSCJ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 2 Sep 2017 14:02:09 -0400
In-Reply-To: <20170824115903.3661-1-socketcan@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hi Marc,

as this patch set is not urgent, I'll send an update after the hrtimer 
rework from Anna-Maria & tglx has hit the mainline kernel.

Best regards,
Oliver

On 08/24/2017 01:59 PM, Oliver Hartkopp wrote:
> When creating cyclic TX jobs with the broadcast manager the timer is re-armed
> based on the current time. Due to the execution time of the timer handling and
> the CAN frame transmission the fixed cycle time gets expanded over time.
> 
> Calculate the new expiration time based on the former expiration time to
> remove this unpredictable delay and omit unnecessary ktime_get() calls.
> 
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   net/can/bcm.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 47a8748d953a..f1a8d9a5b1cb 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -103,7 +103,7 @@ struct bcm_op {
>   	struct bcm_timeval ival1, ival2;
>   	struct hrtimer timer, thrtimer;
>   	struct tasklet_struct tsklet, thrtsklet;
> -	ktime_t rx_stamp, kt_ival1, kt_ival2, kt_lastmsg;
> +	ktime_t rx_stamp, kt_ival1, kt_ival2, kt_expire, kt_lastmsg;
>   	int rx_ifindex;
>   	int cfsiz;
>   	u32 count;
> @@ -364,16 +364,21 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
>   	}
>   }
>   
> +static void bcm_tx_start_the_timer(struct bcm_op *op, ktime_t ival)
> +{
> +	if (!op->kt_expire)
> +		op->kt_expire = ktime_get();
> +
> +	op->kt_expire = ktime_add(op->kt_expire, ival);
> +	hrtimer_start(&op->timer, op->kt_expire, HRTIMER_MODE_ABS);
> +}
> +
>   static void bcm_tx_start_timer(struct bcm_op *op)
>   {
>   	if (op->kt_ival1 && op->count)
> -		hrtimer_start(&op->timer,
> -			      ktime_add(ktime_get(), op->kt_ival1),
> -			      HRTIMER_MODE_ABS);
> +		bcm_tx_start_the_timer(op, op->kt_ival1);
>   	else if (op->kt_ival2)
> -		hrtimer_start(&op->timer,
> -			      ktime_add(ktime_get(), op->kt_ival2),
> -			      HRTIMER_MODE_ABS);
> +		bcm_tx_start_the_timer(op, op->kt_ival2);
>   }
>   
>   static void bcm_tx_timeout_tsklet(unsigned long data)
> 
