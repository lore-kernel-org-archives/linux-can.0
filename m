From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: RFC: (optional) software filtering in candump
Date: Sun, 2 Jun 2013 13:23:09 +0200
Message-ID: <20130602112309.GB630@vandijck-laurijssen.be>
References: <51A66B55.6080506@sebastianhaas.info>
 <51A6DC6A.7020609@hartkopp.net>
 <51A70F0E.1010902@sebastianhaas.info>
 <51A71298.1070202@volkswagen.de>
 <51A71696.8030609@sebastianhaas.info>
 <20130530101719.GB427@vandijck-laurijssen.be>
 <51A740E7.3020400@volkswagen.de>
 <20130530123526.GC427@vandijck-laurijssen.be>
 <51A77250.8070907@sebastianhaas.info>
 <51AA01F0.8020308@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay008.isp.belgacom.be ([195.238.6.174]:17308 "EHLO
	mailrelay008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750927Ab3FBLXO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 2 Jun 2013 07:23:14 -0400
Content-Disposition: inline
In-Reply-To: <51AA01F0.8020308@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Sebastian Haas <dev@sebastianhaas.info>, Sandro Anders | CarMediaLab <sandro.anders@carmedialab.de>, linux-can Mailing List <linux-can@vger.kernel.org>

Oliver

Nice work. It is indeed a workaround. Still some tiny small remark:

Regardless of the defaults in kernel,
I think the default of candump should be to have unique CAN frames.
Why?
1) candump is to be used by 'less advanced users' also :-)
   Those do not understand why to turn 'unique filtering' on.
2) Advanced users understand the filtering and understand
   when to turn unique filtering off.

Kind regards,
Kurt

> 
> It turned out that linked filters would become a mess in implementation and
> configuration (e.g. extensive locking / performance reduction). Additionally
> it would only make sense for a concatenation of inverted filters, like:
> 
> 100~7FF,101~7FF,103~7FF
> 
> Finally i dropped the idea to fiddle with the really efficient filters in
> af_can.c that follow the original idea of the CAN controller HW filters.
> 
> The main drawback of the independent filters is that the user does not expect
> to get the same message several times due to the match of overlapping filters.
> 
> Below you will find an approach that does not push this problem into
> userspace but only omits identical frames that had multiple matches.
> 
> The idea is to introduce a new socket option CAN_RAW_FILTER_UNIQUE for the
> RAW socket, that catches and omits duplicate frames when it's enabled.
> This is a per-socket option and is active for all configured filters applied
> to this socket.
> 
> It's a relatively small and clear change and it fixes your "bug".
> 
> Here's the output of candump with and without the 'unique' option when
> invoking "cansend vcan0 1FF#" in another terminal:
> 
> $ ./candump vcan0,100~7FF,101~7FF
>   vcan0  1FF   [0] 
>   vcan0  1FF   [0] 
> 
> $ ./candump vcan0,100~7FF,101~7FF,U
>   vcan0  1FF   [0] 
> 
> I hope this fit your needs ?! :-)
> 
> Regards,
> Oliver
> 
> 
> 
> diff --git a/include/uapi/linux/can/raw.h b/include/uapi/linux/can/raw.h
> index a814062..965af9e 100644
> --- a/include/uapi/linux/can/raw.h
> +++ b/include/uapi/linux/can/raw.h
> @@ -25,6 +25,7 @@ enum {
>  	CAN_RAW_LOOPBACK,	/* local loopback (default:on)       */
>  	CAN_RAW_RECV_OWN_MSGS,	/* receive my own msgs (default:off) */
>  	CAN_RAW_FD_FRAMES,	/* allow CAN FD frames (default:off) */
> +	CAN_RAW_FILTER_UNIQUE,	/* eliminate multiple filter matches */
>  };
>  
>  #endif
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 1085e65..e4233bd 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -76,6 +76,11 @@ MODULE_ALIAS("can-proto-1");
>   * storing the single filter in dfilter, to avoid using dynamic memory.
>   */
>  
> +struct unique_can_frame {
> +	struct sk_buff *skb;
> +	ktime_t tstamp;
> +};
> +
>  struct raw_sock {
>  	struct sock sk;
>  	int bound;
> @@ -84,10 +89,12 @@ struct raw_sock {
>  	int loopback;
>  	int recv_own_msgs;
>  	int fd_frames;
> +	int filter_unique;
>  	int count;                 /* number of active filters */
>  	struct can_filter dfilter; /* default/single filter */
>  	struct can_filter *filter; /* pointer to filter(s) */
>  	can_err_mask_t err_mask;
> +	struct unique_can_frame uniq_cf;
>  };
>  
>  /*
> @@ -121,6 +128,16 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
>  	if (!ro->recv_own_msgs && oskb->sk == sk)
>  		return;
>  
> +	/* eliminate multiple filter matches for the same skb */
> +	if (ro->filter_unique) {
> +		if (ro->uniq_cf.skb == oskb &&
> +		    ktime_equal(ro->uniq_cf.tstamp, oskb->tstamp))
> +			return;
> +
> +		ro->uniq_cf.skb = oskb;
> +		ro->uniq_cf.tstamp = oskb->tstamp;
> +	}
> +
>  	/* do not pass frames with DLC > 8 to a legacy socket */
>  	if (!ro->fd_frames) {
>  		struct canfd_frame *cfd = (struct canfd_frame *)oskb->data;
> @@ -302,6 +319,8 @@ static int raw_init(struct sock *sk)
>  	ro->loopback         = 1;
>  	ro->recv_own_msgs    = 0;
>  	ro->fd_frames        = 0;
> +	ro->filter_unique    = 0;
> +	ro->uniq_cf.skb      = NULL;
>  
>  	/* set notifier */
>  	ro->notifier.notifier_call = raw_notifier;
> @@ -589,6 +608,15 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
>  
>  		break;
>  
> +	case CAN_RAW_FILTER_UNIQUE:
> +		if (optlen != sizeof(ro->filter_unique))
> +			return -EINVAL;
> +
> +		if (copy_from_user(&ro->filter_unique, optval, optlen))
> +			return -EFAULT;
> +
> +		break;
> +
>  	default:
>  		return -ENOPROTOOPT;
>  	}
> @@ -653,6 +681,12 @@ static int raw_getsockopt(struct socket *sock, int level, int optname,
>  		val = &ro->fd_frames;
>  		break;
>  
> +	case CAN_RAW_FILTER_UNIQUE:
> +		if (len > sizeof(int))
> +			len = sizeof(int);
> +		val = &ro->filter_unique;
> +		break;
> +
>  	default:
>  		return -ENOPROTOOPT;
>  	}
> 
> 
> diff --git a/candump.c b/candump.c
> index b489cd9..cd7bd74 100644
> --- a/candump.c
> +++ b/candump.c
> @@ -130,6 +130,7 @@ void print_usage(char *prg)
>  	fprintf(stderr, " <can_id>:<can_mask> (matches when <received_can_id> & mask == can_id & mask)\n");
>  	fprintf(stderr, " <can_id>~<can_mask> (matches when <received_can_id> & mask != can_id & mask)\n");
>  	fprintf(stderr, " #<error_mask>       (set error frame filter, see include/linux/can/error.h)\n");
> +	fprintf(stderr, " [u|U]               (set unique mode to eliminate multiple filter matches)\n");
>  	fprintf(stderr, "\nCAN IDs, masks and data content are given and expected in hexadecimal values.\n");
>  	fprintf(stderr, "When can_id and can_mask are both 8 digits, they are assumed to be 29 bit EFF.\n");
>  	fprintf(stderr, "Without any given filter all data frames are received ('0:0' default filter).\n");
> @@ -217,6 +218,7 @@ int main(int argc, char **argv)
>  	int rcvbuf_size = 0;
>  	int opt, ret;
>  	int currmax, numfilter;
> +	int unique_filter;
>  	char *ptr, *nptr;
>  	struct sockaddr_can addr;
>  	char ctrlmsg[CMSG_SPACE(sizeof(struct timeval)) + CMSG_SPACE(sizeof(__u32))];
> @@ -466,6 +468,7 @@ int main(int argc, char **argv)
>  
>  			numfilter = 0;
>  			err_mask = 0;
> +			unique_filter = 0;

