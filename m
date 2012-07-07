From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 3/4] can: Properly fill the netlink header when responding
 to RTM_GETROUTE
Date: Sat, 07 Jul 2012 11:18:33 +0200
Message-ID: <4FF7FEE9.1000509@hartkopp.net>
References: <cover.1341489914.git.tgraf@suug.ch> <f719ba361ffa7d76dc1248d41acdbe726ecd9c4c.1341489914.git.tgraf@suug.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:16483 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab2GGJSa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 7 Jul 2012 05:18:30 -0400
In-Reply-To: <f719ba361ffa7d76dc1248d41acdbe726ecd9c4c.1341489914.git.tgraf@suug.ch>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Graf <tgraf@suug.ch>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Hello Thomas,

besides the fact that i would like to simplify this patch (3/4) as shown
below, i was able to test it now.

You may add my

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

to the next post.

Do you have an URL to pull this patch set for Marc?

Thanks for your effort!

Best regards,
Oliver



On 05.07.2012 14:19, Thomas Graf wrote:

>  - set message type to RTM_NEWROUTE
>  - relate to original request by inheriting the sequence and port number.
>  - set NLM_F_MULTI because it's a dump and more messages will follow
> 
> Signed-off-by: Thomas Graf <tgraf@suug.ch>
> ---
>  net/can/gw.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/net/can/gw.c b/net/can/gw.c
> index a1c639c..20c36e1 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -444,11 +444,14 @@ static int cgw_notifier(struct notifier_block *nb,
>  	return NOTIFY_DONE;
>  }
>  
> -static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj)
> +static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
> +		       u32 pid, u32 seq, int flags)
>  {
>  	struct cgw_frame_mod mb;
>  	struct rtcanmsg *rtcan;
> -	struct nlmsghdr *nlh = nlmsg_put(skb, 0, 0, 0, sizeof(*rtcan), 0);
> +	struct nlmsghdr *nlh;
> +
> +	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*rtcan), flags);
>  	if (!nlh)
>  		return -EMSGSIZE;
>  
> @@ -546,7 +549,8 @@ static int cgw_dump_jobs(struct sk_buff *skb, struct netlink_callback *cb)
>  		if (idx < s_idx)
>  			goto cont;
>  
> -		if (cgw_put_job(skb, gwj) < 0)
> +		if (cgw_put_job(skb, gwj, RTM_NEWROUTE, NETLINK_CB(cb->skb).pid,
> +		    cb->nlh->nlmsg_seq, NLM_F_MULTI) < 0)
>  			break;
>  cont:
>  		idx++;




Hello Thomas,

what about this approach which reduces the number of parameters and stack
space when calling cgw_put_job() ??


diff --git a/net/can/gw.c b/net/can/gw.c
index b41acf2..b6b9e0a 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -444,11 +444,15 @@ static int cgw_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
-static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj)
+static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj,
+		       struct netlink_callback *cb)
 {
 	struct cgw_frame_mod mb;
 	struct rtcanmsg *rtcan;
-	struct nlmsghdr *nlh = nlmsg_put(skb, 0, 0, 0, sizeof(*rtcan), 0);
+	struct nlmsghdr *nlh;
+
+	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).pid, cb->nlh->nlmsg_seq,
+			RTM_NEWROUTE, sizeof(*rtcan), NLM_F_MULTI);
 	if (!nlh)
 		return -EMSGSIZE;
@@ -571,7 +575,7 @@ static int cgw_dump_jobs(struct sk_buff *skb, struct netlink_callback *cb)
 		if (idx < s_idx)
 			goto cont;
-		if (cgw_put_job(skb, gwj) < 0)
+		if (cgw_put_job(skb, gwj, cb) < 0)
 			break;
 cont:
 		idx++;


Regards,
Oliver
