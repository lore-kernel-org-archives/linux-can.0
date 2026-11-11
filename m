Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.167
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794384039;
	b=UViGYuZdq/L0iQZddo6UqKG1J28cu0fgWVtxAxbB5qwJOmorYIQXxocRvOx1Fq+cB7iq
	 VVHh5R9FImTlqCgpFZpFlJSSxaCZvy5k2afSuVfOmR8I8mgknWEp4itE/BhNssvuaia7/
	 ajYOMS8b7ewmWoiJ4MEnqFQPzZZUoAqTywuW3eiWFopULO5LQGtVF0M5adRY25Jj9jv6R
	 TYGiK8qio+20gpUSHYLw8+rT4WBWgzJEmSCFElWh5lCQEDMhl+X2mXcKL8/l0NfRoBfE9
	 7uVLeWDbB/oXSZxfrqIuUk3hjyOEtbVgJGR6tZAJU06iBKp+N4qA4peqgFvjPbL8sRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384039;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=US1vNwatvvTGl0XkV5d0RGyto6gJ9ZnZSDmTA5Xn/wI=;
	b=y64fhRlE9gLZx8rUF86MZ417nuuswUjtk4sGfIUFbwkSncCOR+aMzSMTQkxyHM0IWMwf
	 hYL+1Ez34NZWjSM7uVR1FH8Q0MeKHr4QP7cxUWb/SjchsfjhmZvEcFpoGapODscCz7MXT
	 7xOWr3vS7rZ+KHYhK9F6DHBgSUiagcGj+ZJdqMecKYh3EHUkzz7ygDZ4GzgvbSO126pNp
	 XJMVXWnAYcXuox6NVyId3OMPuKDZUIMGqji0J/xZHOYPAzDYc5LFXyBQs2Y+hOE/42TfC
	 F6A0a1HU8Z7l/M0b38AvXdHfKXWVVLUchZg2siy28eZ7neA4JFG4dK3xY57xLvwpoAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=IhkDacmZ;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=F2qTjP5v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.167
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868BC606A33A;
	Wed, 11 Nov 2026 08:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 868BC606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=IhkDacmZ;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=F2qTjP5v
ARC-Seal: i=1; a=rsa-sha256; t=1794384034; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rwiumLSLfHTPbr09+fcGSWkLXpXHZw68d6XzIv4b/ticykMLDXb8ft7hDdB97ObnAA
    /1sXJA6oyuU4ArxcQeP5dbxXsDFSrOlBxoSR9YHP8lMqJqV6iwtxXtSbPoWZ1R2+Q+qp
    JEmy6rwyO5ZQVjZy7zQRsXBiQUtb9+q9L1CkDgbIn52tKdWTeIH5dZ9CWyiqMw05m7IE
    8t76vKjZA3DNDIm0QhQXtpntDUXn3xwc9X87T+pozYc/mphtlceuC1G5BbFQrC+KJAU4
    L9MOgqt4hGujjh6vSs/t1xfDgC97yl/Vmh4Ov7PruwSeQhLvh67obi2a5NciSovHD8Nh
    O4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794384034;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=US1vNwatvvTGl0XkV5d0RGyto6gJ9ZnZSDmTA5Xn/wI=;
    b=XIjZpjA5XAZ/YJu+NI2JIJ3ysoQ0V5VAaV6LH24LN7cQh7++I/uIFGj2hi1x2yNTl6
    TRnpJc1rFcUmSv14SDWCdFH03tjTi5NQGBNLbLWiagfea6OIGApTncuBU7E6Bigp4jDV
    JapTVWM//sw93R7lUq1XDwMgs8gBDlqL4DSMpT9noneBzoIoFT/QZD5Ta9k6tY6BQdiK
    v2YSnRQwqVCq5CjMl8fdIr4LfKYYlgBLgo6CW0eCfuomw3PI5g4vC6W3iHHYCzv4K0eJ
    Ao2VmJT5J1Z888iJDz69RkyrtTshT65/91bhDIm6sq5Yz4HNdTBABozrXDH6t5sT4IIB
    k3xA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794384034;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=US1vNwatvvTGl0XkV5d0RGyto6gJ9ZnZSDmTA5Xn/wI=;
    b=IhkDacmZv+pkAwHZ9/gE+U0ArayIJQx1Y4IStJ3HiwbUjQw9RpESSeyKspDgpvuz5P
    WtGdisD2/+nKymLH0PXLQVciAz7gJB29+ljUYUjOMG/xkwtgwAlbCsRBG30Me/TdI+lL
    9nrv9vgzjDg/HnwrPSKfTeJcxz+Yi/++i/nsyCMy/C6WaoHuusipPeAPquIFaH4MFBOm
    n6xhMt/wEaylt+Pxu75KjrJ5bOXn3P78BylcNhiu2jLBWFI05g/wSqOvIrh9e7YpqH/0
    YG9WP9cTZ3Hs61oth+32onHps2WFAP8LhxtXD8jfGGD3djuZZ2q1zPGc2jZNJCXWe91p
    Wqng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794384034;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=US1vNwatvvTGl0XkV5d0RGyto6gJ9ZnZSDmTA5Xn/wI=;
    b=F2qTjP5vwjAjvD5wBPxzlPk8XxAB2DUUBC5I4dr6OgsK1IMxTUQY8XOkaTZU07BFgH
    Rkwvi7hXBTGF0t1TTqBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AB80Y3S6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 11 Nov 2026 09:00:34 +0100 (CET)
Message-ID: <623c302e-c6e9-478c-941e-a738da6f1ee7@hartkopp.net>
Date: Wed, 11 Nov 2026 09:00:34 +0100
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: gw: avoid losing statistics updates on concurrent
 receive
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: mkl@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+a6205fafcbfe69a5fd67@syzkaller.appspotmail.com
References: <20261111062907.16857-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261111062907.16857-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11.11.26 07:29, Zhu Jun wrote:
> can_can_gw_rcv() can run on multiple CPUs for the same gateway job. RCU
> protects the job's lifetime, but does not serialize its frame counters.
> Concurrent plain increments can lose updates, and netlink dumps race
> with the counter updates as well.
> 
> Use atomic counters for handled, dropped and deleted frames. Read each
> counter once into a u32 for the netlink dump, preserving the existing
> 32-bit attributes and their wraparound behavior.
> 
> Fixes: c1aabdf379bc ("can-gw: add netlink based CAN routing")

No fixes tag here. This is not critical and not stable-relevant content 
that can go via can-next.

@Marc: Can you remove the tag while applying the patch or does it need a 
re-spin?

> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Many thanks,
Oliver

> ---
>   net/can/gw.c | 43 ++++++++++++++++++++++++-------------------
>   1 file changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/net/can/gw.c b/net/can/gw.c
> index 8a5327d8a00e..a5233b4606da 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -40,6 +40,7 @@
>    */
>   
>   #include <linux/module.h>
> +#include <linux/atomic.h>
>   #include <linux/init.h>
>   #include <linux/types.h>
>   #include <linux/kernel.h>
> @@ -129,9 +130,9 @@ struct can_can_gw {
>   struct cgw_job {
>   	struct hlist_node list;
>   	struct rcu_head rcu;
> -	u32 handled_frames;
> -	u32 dropped_frames;
> -	u32 deleted_frames;
> +	atomic_t handled_frames;
> +	atomic_t dropped_frames;
> +	atomic_t deleted_frames;
>   	struct cf_mod __rcu *cf_mod;
>   	union {
>   		/* CAN frame data source */
> @@ -484,12 +485,12 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>   	 */
>   	if (csx->can_gw_hops >= max_hops) {
>   		/* indicate deleted frames due to misconfiguration */
> -		gwj->deleted_frames++;
> +		atomic_inc(&gwj->deleted_frames);
>   		return;
>   	}
>   
>   	if (!(gwj->dst.dev->flags & IFF_UP)) {
> -		gwj->dropped_frames++;
> +		atomic_inc(&gwj->dropped_frames);
>   		return;
>   	}
>   
> @@ -510,7 +511,7 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>   		nskb = skb_clone(skb, GFP_ATOMIC);
>   
>   	if (!nskb) {
> -		gwj->dropped_frames++;
> +		atomic_inc(&gwj->dropped_frames);
>   		return;
>   	}
>   
> @@ -521,7 +522,7 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>   	ncsx = skb_ext_add(nskb, SKB_EXT_CAN);
>   	if (!ncsx) {
>   		kfree_skb(nskb);
> -		gwj->dropped_frames++;
> +		atomic_inc(&gwj->dropped_frames);
>   		return;
>   	}
>   
> @@ -552,7 +553,7 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>   		/* dlc may have changed, make sure it fits to the CAN frame */
>   		if (cf->len > max_len) {
>   			/* delete frame due to misconfiguration */
> -			gwj->deleted_frames++;
> +			atomic_inc(&gwj->deleted_frames);
>   			kfree_skb(nskb);
>   			return;
>   		}
> @@ -571,9 +572,9 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
>   
>   	/* send to netdevice */
>   	if (can_send(nskb, gwj->flags & CGW_FLAGS_CAN_ECHO))
> -		gwj->dropped_frames++;
> +		atomic_inc(&gwj->dropped_frames);
>   	else
> -		gwj->handled_frames++;
> +		atomic_inc(&gwj->handled_frames);
>   }
>   
>   static inline int cgw_register_filter(struct net *net, struct cgw_job *gwj)
> @@ -640,6 +641,7 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
>   	struct rtcanmsg *rtcan;
>   	struct nlmsghdr *nlh;
>   	struct cf_mod *mod;
> +	u32 handled, dropped, deleted;
>   
>   	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*rtcan), flags);
>   	if (!nlh)
> @@ -652,18 +654,21 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
>   
>   	/* add statistics if available */
>   
> -	if (gwj->handled_frames) {
> -		if (nla_put_u32(skb, CGW_HANDLED, gwj->handled_frames) < 0)
> +	handled = atomic_read(&gwj->handled_frames);
> +	if (handled) {
> +		if (nla_put_u32(skb, CGW_HANDLED, handled) < 0)
>   			goto cancel;
>   	}
>   
> -	if (gwj->dropped_frames) {
> -		if (nla_put_u32(skb, CGW_DROPPED, gwj->dropped_frames) < 0)
> +	dropped = atomic_read(&gwj->dropped_frames);
> +	if (dropped) {
> +		if (nla_put_u32(skb, CGW_DROPPED, dropped) < 0)
>   			goto cancel;
>   	}
>   
> -	if (gwj->deleted_frames) {
> -		if (nla_put_u32(skb, CGW_DELETED, gwj->deleted_frames) < 0)
> +	deleted = atomic_read(&gwj->deleted_frames);
> +	if (deleted) {
> +		if (nla_put_u32(skb, CGW_DELETED, deleted) < 0)
>   			goto cancel;
>   	}
>   
> @@ -1146,9 +1151,9 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
>   		goto out_free_cf;
>   	}
>   
> -	gwj->handled_frames = 0;
> -	gwj->dropped_frames = 0;
> -	gwj->deleted_frames = 0;
> +	atomic_set(&gwj->handled_frames, 0);
> +	atomic_set(&gwj->dropped_frames, 0);
> +	atomic_set(&gwj->deleted_frames, 0);
>   	gwj->flags = r->flags;
>   	gwj->gwtype = r->gwtype;
>   	gwj->limit_hops = limhops;

