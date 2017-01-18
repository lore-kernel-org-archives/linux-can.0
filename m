From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: fix hrtimer/tasklet termination in bcm op removal
Date: Wed, 18 Jan 2017 21:40:00 +0100
Message-ID: <3bc0f7a6-479f-d2ee-c3b4-ada91c784966@hartkopp.net>
References: <20170118203051.16192-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:36249 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752306AbdARUwW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 18 Jan 2017 15:52:22 -0500
In-Reply-To: <20170118203051.16192-1-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Josenhans <michael.josenhans@web.de>
Cc: linux-can@vger.kernel.org

Hi Michael,

thanks for your bug report!

I created and tested this patch with some weird settings using a 1 usec 
cycle together with TX_SETUP and TX_DELETE.

Can you please check this patch with your setup?

Best regards,
Oliver

On 01/18/2017 09:30 PM, Oliver Hartkopp wrote:
> When removing a bcm tx operation either a hrtimer or a tasklet might run.
> As the hrtimer triggers its associated tasklet and vice versa we need to
> take care to mutually terminate both handlers.
>
> Reported-by: Michael Josenhans <michael.josenhans@web.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  net/can/bcm.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 21ac75390e3d..a7dc80c8e724 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -734,14 +734,23 @@ static struct bcm_op *bcm_find_op(struct list_head *ops,
>
>  static void bcm_remove_op(struct bcm_op *op)
>  {
> -	hrtimer_cancel(&op->timer);
> -	hrtimer_cancel(&op->thrtimer);
> -
> -	if (op->tsklet.func)
> -		tasklet_kill(&op->tsklet);
> +	if (op->tsklet.func) {
> +		while (test_bit(TASKLET_STATE_SCHED, &op->tsklet.state) ||
> +		       test_bit(TASKLET_STATE_RUN, &op->tsklet.state) ||
> +		       hrtimer_active(&op->timer)) {
> +			hrtimer_cancel(&op->timer);
> +			tasklet_kill(&op->tsklet);
> +		}
> +	}
>
> -	if (op->thrtsklet.func)
> -		tasklet_kill(&op->thrtsklet);
> +	if (op->thrtsklet.func) {
> +		while (test_bit(TASKLET_STATE_SCHED, &op->thrtsklet.state) ||
> +		       test_bit(TASKLET_STATE_RUN, &op->thrtsklet.state) ||
> +		       hrtimer_active(&op->thrtimer)) {
> +			hrtimer_cancel(&op->thrtimer);
> +			tasklet_kill(&op->thrtsklet);
> +		}
> +	}
>
>  	if ((op->frames) && (op->frames != &op->sframe))
>  		kfree(op->frames);
>
