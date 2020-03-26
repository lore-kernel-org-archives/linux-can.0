From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: [PATCH] can: c_can: Handle lost bus-off interrupt while IRQs are
 disabled
Date: Thu, 26 Mar 2020 14:40:16 +0100
Message-ID: <20200326134015.GC27785@x1.vandijck-laurijssen.be>
References: <20200326104318.15086-1-felix.riemann@sma.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:33072 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZNlE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 26 Mar 2020 09:41:04 -0400
Content-Disposition: inline
In-Reply-To: <20200326104318.15086-1-felix.riemann@sma.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Felix Riemann <felix.riemann@sma.de>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Andre Kalb <andre.kalb@sma.de>

This patch looks very familiar.
I tried this 6 months ago, when I got a setup where I could reproduce
this within minutes.

This patch didn't solve my problem, and I fixed my problem with reading the
ISR register only once in the IRQ, and _not_ 2nd time in napi handler.
Reading the ISR in C_CAN is consuming the info, so unless the there is
more state to clear (such as received message buffers), the interrupt
cause is assumed to be known, and the C_CAN proceeds to the next
interrupt cause.
I've not experienced a single problem since, where before the fix, I'd
experience a few occurances every month.
We have an am3358 (beaglebone-like hardware).

I believe I submitted a patch for that.

Re-scheduling the napi is a workaround, IMHO.

Kurt

On do, 26 mrt 2020 11:43:18 +0100, Felix Riemann wrote:
> There are appears to be a race condition where interrupts caused
> by bus offs get lost if it occurs while interrupts are disabled
> or being re-enabled.
> 
> This tries to avoid the deadlock by rescheduling the NAPI worker
> to handle the bus-off condition.
> 
> Signed-off-by: Felix Riemann <felix.riemann@sma.de>
> Reviewed-by: Andre Kalb <andre.kalb@sma.de>
> ---
>  drivers/net/can/c_can/c_can.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
> index 8e9f5620c9a2..0952ac0b9123 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -1123,8 +1123,25 @@ static int c_can_poll(struct napi_struct *napi, int quota)
>  	if (work_done < quota) {
>  		napi_complete_done(napi, work_done);
>  		/* enable all IRQs if we are not in bus off state */
> -		if (priv->can.state != CAN_STATE_BUS_OFF)
> +		if (priv->can.state != CAN_STATE_BUS_OFF) {
> +			u32 ctrl;
>  			c_can_irq_control(priv, true);
> +
> +			/* There appears to be a race condition when the device
> +			 * enters bus off while interrupts are off or being
> +			 * re-enabled causing the bus off to get lost.
> +			 * This tries to avoid this condition.
> +			 */
> +			ctrl = priv->read_reg(priv, C_CAN_CTRL_REG);
> +
> +			if (ctrl & CONTROL_INIT) {
> +				netdev_warn(dev, "lost bus off\n");
> +				c_can_irq_control(priv, false);
> +				/* Reschedule worker to handle bus off */
> +				atomic_set(&priv->sie_pending, 1);
> +				napi_reschedule(napi);
> +			}
> +		}
>  	}
>  
>  	return work_done;
> -- 
> 2.26.0
> 
