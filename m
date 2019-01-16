From: Andre Naujoks <nautsch2@gmail.com>
Subject: Re: [PATCH v2] can: bcm: check timer values before ktime conversion
Date: Wed, 16 Jan 2019 14:31:11 +0100
Message-ID: <b0c40e9b-9c18-a8b0-c52b-0e6618eb7f9d@gmail.com>
References: <20190113183143.10612-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190113183143.10612-1-socketcan@hartkopp.net>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, davem@davemloft.net, netdev@vger.kernel.org
Cc: linux-can@vger.kernel.org, lifeasageek@gmail.com, threeearcat@gmail.com, syzkaller@googlegroups.com, Kyungtae Kim <kt0755@gmail.com>, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Am 13.01.19 um 19:31 schrieb Oliver Hartkopp:
> Kyungtae Kim detected a potential integer overflow in bcm_[rx|tx]_setup()
> when the conversion into ktime multiplies the given value with NSEC_PER_USEC
> (1000).
> 
> Reference: https://marc.info/?l=linux-can&m=154732118819828&w=2
> 
> Add a check for the given tv_usec, so that the value stays below one second.
> Additionally limit the tv_sec value to a reasonable value for CAN related
> use-cases of 400 days and ensure all values to be positive.
> 
> Reported-by: Kyungtae Kim <kt0755@gmail.com>
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: linux-stable <stable@vger.kernel.org> # >= 2.6.26

Acked-by: Andre Naujoks <nautsch2@gmail.com>

Sorry for the late reply, but I seem to have missed the initial send of
v2 of this. I wanted to at least ack it, since I made such a fuss about
the timeouts. :-)

Regards
  Andre

> ---
>  net/can/bcm.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 0af8f0db892a..d4ae0a1471f3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -67,6 +67,9 @@
>   */
>  #define MAX_NFRAMES 256
>  
> +/* limit timers to 400 days for sending/timeouts */
> +#define BCM_TIMER_SEC_MAX (400*24*60*60)
> +
>  /* use of last_frames[index].flags */
>  #define RX_RECV    0x40 /* received data for this element */
>  #define RX_THR     0x80 /* element not been sent due to throttle feature */
> @@ -140,6 +143,22 @@ static inline ktime_t bcm_timeval_to_ktime(struct bcm_timeval tv)
>  	return ktime_set(tv.tv_sec, tv.tv_usec * NSEC_PER_USEC);
>  }
>  
> +/* check limitations for timeval provided by user */
> +static int bcm_is_invalid_tv(struct bcm_msg_head *msg_head)
> +{
> +	if ((msg_head->ival1.tv_sec < 0) ||
> +	    (msg_head->ival1.tv_sec > BCM_TIMER_SEC_MAX) ||
> +	    (msg_head->ival1.tv_usec < 0) ||
> +	    (msg_head->ival1.tv_usec >= USEC_PER_SEC) ||
> +	    (msg_head->ival2.tv_sec < 0) ||
> +	    (msg_head->ival2.tv_sec > BCM_TIMER_SEC_MAX) ||
> +	    (msg_head->ival2.tv_usec < 0) ||
> +	    (msg_head->ival2.tv_usec >= USEC_PER_SEC))
> +		return 1;
> +
> +	return 0;
> +}
> +
>  #define CFSIZ(flags) ((flags & CAN_FD_FRAME) ? CANFD_MTU : CAN_MTU)
>  #define OPSIZ sizeof(struct bcm_op)
>  #define MHSIZ sizeof(struct bcm_msg_head)
> @@ -873,6 +892,10 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
> @@ -1053,6 +1076,10 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
