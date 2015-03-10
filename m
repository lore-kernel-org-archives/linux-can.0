From: Alexander Duyck <alexander.h.duyck@redhat.com>
Subject: Re: [PATCH] net: add comment for sock_efree() usage
Date: Tue, 10 Mar 2015 10:29:26 -0700
Message-ID: <54FF29F6.6080403@redhat.com>
References: <1426007997-6219-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42126 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742AbbCJR3c (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 10 Mar 2015 13:29:32 -0400
In-Reply-To: <1426007997-6219-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: eric.dumazet@gmail.com

On 03/10/2015 10:19 AM, Oliver Hartkopp wrote:
> In opposite to sock_rfree() and sock_wfree() the function sock_efree() does
> not need to change the sk_[rw]_mem_alloc length. Add the comment to point out
> the idea for using sock_efree() in the _e_rror handler or e.g. timestamp path.
>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   net/core/sock.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 93c8b20..7a1eac8 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1655,6 +1655,10 @@ void sock_rfree(struct sk_buff *skb)
>   }
>   EXPORT_SYMBOL(sock_rfree);
>   
> +/*
> + * Buffer destructor for skbs that don't have sk_[rw]_mem_alloc accounting.
> + * E.g. error handler / timestamp path. Automatically called from kfree_skb.
> + */
>   void sock_efree(struct sk_buff *skb)
>   {
>   	sock_put(skb->sk);

This should probably be pushed out to the netdev list since this effects 
all sockets.

Technically speaking there is a 1 byte sk_wmem_alloc that this is 
accounting for to keep the socket from being closed.  It is shared 
between all instances that are using sock_efree as their destructor, and 
will drop that 1 byte when sk_refcnt has reached 0.

- Alex
