From: Thomas Graf <tgraf@suug.ch>
Subject: Re: [PATCH 3/4] can: Properly fill the netlink header when
 responding to RTM_GETROUTE
Date: Mon, 9 Jul 2012 05:43:42 -0400
Message-ID: <20120709094342.GF32535@canuck.infradead.org>
References: <cover.1341489914.git.tgraf@suug.ch>
 <f719ba361ffa7d76dc1248d41acdbe726ecd9c4c.1341489914.git.tgraf@suug.ch>
 <4FF74CE9.7000604@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:54857 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab2GIJnp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 05:43:45 -0400
Content-Disposition: inline
In-Reply-To: <4FF74CE9.7000604@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

On Fri, Jul 06, 2012 at 10:39:05PM +0200, Oliver Hartkopp wrote:
> what about this approach which reduces the number of parameters and stack
> space when calling cgw_put_job() ??
> 
> 
> diff --git a/net/can/gw.c b/net/can/gw.c
> index b41acf2..b6b9e0a 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -444,11 +444,15 @@ static int cgw_notifier(struct notifier_block *nb,
>  	return NOTIFY_DONE;
>  }
>  
> -static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj)
> +static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj,
> +		       struct netlink_callback *cb)
>  {
>  	struct cgw_frame_mod mb;
>  	struct rtcanmsg *rtcan;
> -	struct nlmsghdr *nlh = nlmsg_put(skb, 0, 0, 0, sizeof(*rtcan), 0);
> +	struct nlmsghdr *nlh;
> +
> +	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).pid, cb->nlh->nlmsg_seq,
> +			RTM_NEWROUTE, sizeof(*rtcan), NLM_F_MULTI);
>  	if (!nlh)
>  		return -EMSGSIZE;
>  
> @@ -571,7 +575,7 @@ static int cgw_dump_jobs(struct sk_buff *skb, struct netlink_callback *cb)
>  		if (idx < s_idx)
>  			goto cont;
>  
> -		if (cgw_put_job(skb, gwj) < 0)
> +		if (cgw_put_job(skb, gwj, cb) < 0)
>  			break;
>  cont:
>  		idx++;

The format I've chosen allows to implement a non-dump RTM_GETROUTE using
cgw_put_job() if needed and is in line with how such filling functions
are typically prototyped in other netlink protocol implementations.

~Thomas
