From: Michael Josenhans <michael.josenhans@web.de>
Subject: Re: [PATCH] can: fix hrtimer/tasklet termination in bcm op removal
Date: Sat, 28 Jan 2017 17:42:54 +0100
Message-ID: <7ded2bd2-45af-e4e1-63d9-e9959d8db2e3@web.de>
References: <20170118203051.16192-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:61608 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbdA1Qm7 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Sat, 28 Jan 2017 11:42:59 -0500
In-Reply-To: <20170118203051.16192-1-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org



When removing a bcm tx operation either a hrtimer or a tasklet might run.
As the hrtimer triggers its associated tasklet and vice versa we need to
take care to mutually terminate both handlers.

Reported-by: Michael Josenhans <michael.josenhans@web.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Tested-by: Michael Josenhans <michael.josenhans@web.de>
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
> --
