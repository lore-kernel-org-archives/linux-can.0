From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC v3] CAN FD support
Date: Mon, 14 May 2012 11:36:30 +0200
Message-ID: <20120514093630.GA600@vandijck-laurijssen.be>
References: <4FAD5A04.2030108@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:10050 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755093Ab2ENJge (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 14 May 2012 05:36:34 -0400
Content-Disposition: inline
In-Reply-To: <4FAD5A04.2030108@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Oliver,

You're running fast now :-)

I like the inversion of HDR & EDL bits. It make CAN & CANFD
even more compatible.

I still don't see the contribution of ETH_P_CANFD.
I think it introduces a lot of (almost) idenctical code,
especially compared to its benefits (cfr. 'helga').

Another issue I'm still struggling with: can_raw is differentiating
between CAN & CANFD with CAN_RAW_FD_FRAMES sockopt.

IMO, at most 1 property/method shall exist to differentiate CAN from CANFD.
(Preferrably, no method should have been necessary).

I see that 2 struct are in place now, with sizes CAN_MTU & CANFD_MTU.
This alone is IMO enough to differentiate.
Next to this property, an _extra_ sockopt is introduced.
This sockopt actually implements a filter, at can_raw level, *and*
is a second way of telling you want to use CANFD.

I understood that mixing CAN & CANFD on 1 bus is possible on CANFD chip level,
and we do want to support those features by using 2 structs
that in fact determine the CAN type. If an application want to mix
CAN & CANFD, it is currently not possible without opening another
socket, thereby loosing the proper sequence of events.

IMHO, the CAN_RAW_FD_FRAMES is not justifyable towards userspace
applications.

I put my view in the code down below, besides the elimination of the 'fd_frames'
member in struct raw_sock, and the corresponding CAN_RAW_FD_FRAMES sockopt.

IMO, the old behaviour (that is written in stone) is still preserved for
99.999%, _and_ no difficult sockopts are needed.
Difficult means in this case: it became not straightforward to predict
which frames got received.

Kurt

On Fri, May 11, 2012 at 08:27:16PM +0200, Oliver Hartkopp wrote:
> 
> I generated this diff by 'git diff fb7944b' on the repository
> 
> https://gitorious.org/~hartkopp/linux-can/hartkopps-linux-can-next
> 
> Regards,
> Oliver
> 
>  drivers/net/can/dev.c    |   35 ++++++++++++++
>  drivers/net/can/vcan.c   |   27 ++++++++---
>  include/linux/can.h      |   51 ++++++++++++++++++++-
>  include/linux/can/core.h |    4 -
>  include/linux/can/dev.h  |   33 ++++++++++----
>  include/linux/can/raw.h  |    3 -
>  include/linux/if_ether.h |    3 -
>  net/can/af_can.c         |  110 +++++++++++++++++++++++++++++++++++------------
>  net/can/raw.c            |   41 ++++++++++++++++-
>  9 files changed, 257 insertions(+), 50 deletions(-)
> 
> ---
[...]
> diff --git a/include/linux/can/raw.h b/include/linux/can/raw.h
> index 781f3a3..5448c0f 100644
> --- a/include/linux/can/raw.h
> +++ b/include/linux/can/raw.h
> @@ -23,7 +23,8 @@ enum {
>  	CAN_RAW_FILTER = 1,	/* set 0 .. n can_filter(s)          */
>  	CAN_RAW_ERR_FILTER,	/* set filter for error frames       */
>  	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
> -	CAN_RAW_RECV_OWN_MSGS	/* receive my own msgs (default:off) */
> +	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
> +	CAN_RAW_FD_FRAMES,	/* use struct canfd_frame (default:off) */
>  };
>  
>  #endif
> diff --git a/net/can/raw.c b/net/can/raw.c
> index cde1b4a..2473e6e 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -82,6 +82,7 @@ struct raw_sock {
>  	struct notifier_block notifier;
>  	int loopback;
>  	int recv_own_msgs;
> +	int fd_frames;
>  	int count;                 /* number of active filters */
>  	struct can_filter dfilter; /* default/single filter */
>  	struct can_filter *filter; /* pointer to filter(s) */
> @@ -119,6 +120,15 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
>  	if (!ro->recv_own_msgs && oskb->sk == sk)
>  		return;
>  
> +	/* only pass correct frames to the socket */
I'm not sure to introduce such check here, but it could be as simple as:

	if (unlikely((oskb->len != CAN_MTU)||(oskb->len != CANFD_MTU)))
		return;

> +	if (ro->fd_frames) {
> +		if (unlikely(oskb->len != CANFD_MTU))
> +			return;
> +	} else {
> +		if (unlikely(oskb->len != CAN_MTU))
> +			return;
> +	}
> +
>  	/* clone the given skb to be able to enqueue it into the rcv queue */
>  	skb = skb_clone(oskb, GFP_ATOMIC);
>  	if (!skb)
> @@ -291,6 +301,7 @@ static int raw_init(struct sock *sk)
>  	/* set default loopback behaviour */
>  	ro->loopback         = 1;
>  	ro->recv_own_msgs    = 0;
> +	ro->fd_frames        = 0;
>  
>  	/* set notifier */
>  	ro->notifier.notifier_call = raw_notifier;
> @@ -569,6 +580,15 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>  
>  		break;
>  
> +	case CAN_RAW_FD_FRAMES:
> +		if (optlen != sizeof(ro->fd_frames))
> +			return -EINVAL;
> +
> +		if (copy_from_user(&ro->fd_frames, optval, optlen))
> +			return -EFAULT;
> +
> +		break;
> +
>  	default:
>  		return -ENOPROTOOPT;
>  	}
> @@ -627,6 +647,12 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>  		val = &ro->recv_own_msgs;
>  		break;
>  
> +	case CAN_RAW_FD_FRAMES:
> +		if (len > sizeof(int))
> +			len = sizeof(int);
> +		val = &ro->fd_frames;
> +		break;
> +
>  	default:
>  		return -ENOPROTOOPT;
>  	}
> @@ -662,13 +688,24 @@ static int raw_sendmsg(struct kiocb *iocb, struct socket *sock,
>  	} else
>  		ifindex = ro->ifindex;
>  
	if (unlikely((size != CAN_MTU)&&(size != CANFD_MTU)))
		return -EINVAL;
> -	if (size != sizeof(struct can_frame))
> -		return -EINVAL;
> +	if (ro->fd_frames) {
> +		if (unlikely(size != CANFD_MTU))
> +			return -EINVAL;
> +	} else {
> +		if (unlikely(size != CAN_MTU))
> +			return -EINVAL;
> +	}
>  
>  	dev = dev_get_by_index(&init_net, ifindex);
>  	if (!dev)
>  		return -ENXIO;
>  
> +	/* make sure the created CAN frame can pass the CAN netdevice */
> +	if (unlikely(size > dev->mtu)) {
> +		err = -EMSGSIZE;
> +		goto put_dev;
> +	}
> +
>  	skb = sock_alloc_send_skb(sk, size, msg->msg_flags & MSG_DONTWAIT,
>  				  &err);
>  	if (!skb)
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
