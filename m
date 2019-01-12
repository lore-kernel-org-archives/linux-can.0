From: Andre Naujoks <nautsch2@gmail.com>
Subject: Re: [PATCH] can: bcm: check timer values before ktime conversion
Date: Sat, 12 Jan 2019 23:16:54 +0100
Message-ID: <01976e61-2ba1-09bf-94a1-b0e879c9a07b@gmail.com>
References: <20190112215726.2622-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190112215726.2622-1-socketcan@hartkopp.net>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, davem@davemloft.net, netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, lifeasageek@gmail.com, threeearcat@gmail.com, syzkaller@googlegroups.com, Kyungtae Kim <kt0755@gmail.com>, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Hi.

The 15 minute limit seems arbitrary to me. I'd be surprised if an
(R|T)X_SETUP failed because of a timeout greater than this. Are there
any problems with allowing larger timeouts? If not, I do not see a
reason to restrict this.

Regards
  Andre

On 1/12/19 10:57 PM, Oliver Hartkopp wrote:
> Kyungtae Kim detected a potential integer overflow in bcm_[rx|tx]_setup() when
> the conversion into ktime multiplies the given value with NSEC_PER_USEC (1000).
> 
> Reference: https://marc.info/?l=linux-can&m=154732118819828&w=2
> 
> Add a check for the given tv_usec, so that the value stays below one second.
> Additionally limit the tv_sec value to a reasonable value for CAN related
> use-cases of 15 minutes.
> 
> Reported-by: Kyungtae Kim <kt0755@gmail.com>
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: linux-stable <stable@vger.kernel.org> # >= 2.6.26
> ---
>  net/can/bcm.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 0af8f0db892a..ff3799be077b 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -67,6 +67,9 @@
>   */
>  #define MAX_NFRAMES 256
>  
> +/* limit timers to 15 minutes for sending/timeouts */
> +#define BCM_TIMER_SEC_MAX (15*60)
> +
>  /* use of last_frames[index].flags */
>  #define RX_RECV    0x40 /* received data for this element */
>  #define RX_THR     0x80 /* element not been sent due to throttle feature */
> @@ -140,6 +143,18 @@ static inline ktime_t bcm_timeval_to_ktime(struct bcm_timeval tv)
>  	return ktime_set(tv.tv_sec, tv.tv_usec * NSEC_PER_USEC);
>  }
>  
> +/* check limitations for timeval provided by user */
> +static int bcm_is_invalid_tv(struct bcm_msg_head *msg_head)
> +{
> +	if ((msg_head->ival1.tv_sec > BCM_TIMER_SEC_MAX) ||
> +	    (msg_head->ival1.tv_usec >= USEC_PER_SEC) ||
> +	    (msg_head->ival2.tv_sec > BCM_TIMER_SEC_MAX) ||
> +	    (msg_head->ival2.tv_usec >= USEC_PER_SEC))
> +		return 1;
> +
> +	return 0;
> +}
> +
>  #define CFSIZ(flags) ((flags & CAN_FD_FRAME) ? CANFD_MTU : CAN_MTU)
>  #define OPSIZ sizeof(struct bcm_op)
>  #define MHSIZ sizeof(struct bcm_msg_head)
> @@ -873,6 +888,10 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>  	if (msg_head->nframes < 1 || msg_head->nframes > MAX_NFRAMES)
>  		return -EINVAL;
>  
> +	/* check timeval limitations */
> +	if ((msg_head->flags & SETTIMER) && bcm_is_invalid_tv(msg_head))
> +		return -EINVAL;
> +
>  	/* check the given can_id */
>  	op = bcm_find_op(&bo->tx_ops, msg_head, ifindex);
>  	if (op) {
> @@ -1053,6 +1072,10 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>  	     (!(msg_head->can_id & CAN_RTR_FLAG))))
>  		return -EINVAL;
>  
> +	/* check timeval limitations */
> +	if ((msg_head->flags & SETTIMER) && bcm_is_invalid_tv(msg_head))
> +		return -EINVAL;
> +
>  	/* check the given can_id */
>  	op = bcm_find_op(&bo->rx_ops, msg_head, ifindex);
>  	if (op) {
> 
