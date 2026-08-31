Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D94A41F5D8;
	Mon, 31 Aug 2026 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182787; cv=pass; b=ItnocTOW2bYHhQz2QODEftaMXJ+Wu+kv6bkyS84wjGnEML6bE4drNhPbWHCSupj1dw0NU2ahUi7Q1B01MtY21LfHSrpA0hiKA9mZupQ7jBX6hnQ08UCjbvZvcqKl6wagYgXo9f+oKQuIA4xTBk5LR235FaYILncTe9FXzvugUEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182787; c=relaxed/simple;
	bh=98UxJbR1kIYlfTcPw/kEpCbazbHHv4KlYKJLtEz+/fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQ/mSTljSLGPLttUESqqq8i2qAb1FZVICIZ+s7QAW5VRU22RQjiZz1RVCy9m90gsGGv5bgwE0WNeByz7E+ZC0JgF77WU5e5lO5jiyceeFNScZYvfzXxPGBa4ghIV/gPcsRPmOiZNPd1o6qrTpUiLINdiIvepx5s3HqsBmeQEobE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ooXkScAX; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=8O+r78F2; arc=pass smtp.client-ip=85.215.255.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ooXkScAX";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="8O+r78F2"
ARC-Seal: i=1; a=rsa-sha256; t=1788181699; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Uf0coD31ds8XG+ResexGgQi9hpXcNcKL0/asu+HUvvid3mHSXRD4y4F5C124I94ljO
    tYGTeUK9UW8VHFynSs3/sDLElk6ah/XuNp5zhCZdkp0qMqzNmHTALF/wYLaj1ePxvGCP
    GLFf0BUxQo563TnEuISG8qX6i+YF6A1I0Y8xX6sZhWAlC/ZjaxDX4U/91ven9cHpU9E1
    KTO02beTk9ZZu6xDXvr+VXEOIn4gjdlVQmkEq808y+KxXy3jRVYyAJ+d/Mx2BbpggRaJ
    jCSMnbmpuHL1VFBOZDIhfaqeix/yOMaDdBzCY/UkG51Qexl848kAhCNHtLaZi2ZeBWYK
    kX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1788181699;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Zo+m9skdyEmi6HZIMHQv08WDITUGReD0gbTOuRRdCyY=;
    b=eD9yP85Acs+EU27CYU7fXFLskFC/HKQA9n47sPb+u89P8D9Fu+8QvR7sLy7BxXg0iO
    HDauhGQNO54n0rxlXB8FTf/86miomz1dSpLGtEwRfHxJtrmMhS0lzlMny4ZZLHZDtI/G
    CdSKcc+H5t2WH0y0UVRsJbLCbI3Vac392MgYgfQ7b7HtpVwNpubWstmEOEGrBAdL47TJ
    0CE+EPajZH2zNeko8PgH2y9Uy/yef4EE6tKDwEkBiJf6QikQZYiNxihdK/B3vK+Ekm2N
    rOMboFrU06iO9cB4gmb4yMNhUBIMApD625SoXvBVE3rGcgBWB/gg7aJwff25/9aw7+8a
    f42g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1788181699;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Zo+m9skdyEmi6HZIMHQv08WDITUGReD0gbTOuRRdCyY=;
    b=ooXkScAX61WSM5+8/9aGD8tvOPJ7Iu+RHIAZ+qAgx0veZNE9J99ZSS5lUt6J+DCaX/
    mYt+3hQ7L0GIfGIPk0BrWA+oI+xm2xsptxJL6JH3g85549LxrEyMHZnxOYwP7+nzC2vO
    1AbzSKpwu9HhexwzrE0YcmnbDnvGShseDVvRTwIjQxYIAdfs2uFlr8l59aW5GsyxvTRd
    VnjOOjVOXntjRNuC7YUcf+ABlQLIRsm3FYbWjhoFgn8A/yA/+zVS/Y3SqqXaQ97JcBgk
    hdXtQcnWh33WzTsyWqGjo+xe1+/3p87NsW04vxk+23ZNPvzeEPw837FskM7XjNMkTybW
    e4Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1788181699;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Zo+m9skdyEmi6HZIMHQv08WDITUGReD0gbTOuRRdCyY=;
    b=8O+r78F28FOEcJ/Kwpe8LksehL2h97y6jfpuBUDFWpTolE++qJg81ZhkoYVcI0IRmn
    LulGsE4RnEIDJDc/dwAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727VD8IL8S
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 31 Aug 2026 15:08:18 +0200 (CEST)
Message-ID: <2c5851d3-cd83-4a16-91ed-b7323cabe7c0@hartkopp.net>
Date: Mon, 31 Aug 2026 15:08:13 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] can: isotp: take rtnl_lock() before leaving the
 notifier list
To: Norbert Szetei <norbert@doyensec.com>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-kernel@vger.kernel.org
References: <CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Norbert,

many thanks for your patch and the analysis of the unremoved filter 
lists in the case of moving a CAN device to another namespace.

But I don't think that moving rtnl_lock() up so that it covers a busy 
loop including a schedule_timeout_uninterruptible(1) wait is not a nice 
move for other rtnl_lock() users.

Focussing on the removal of the correct filter lists when the namespace 
is changed away from the socket's namespace I would propose this small 
change:

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 155530aedce2..0835a4758a72 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1490,15 +1490,15 @@ static int isotp_release(struct socket *sock)
         /* remove current filters & unregister
          * tracked reference so->dev is taken at bind() time with rtnl_lock
          */
         if (so->bound && so->dev) {
                 if (isotp_register_rxid(so))
-                       can_rx_unregister(net, so->dev, so->rxid,
+                       can_rx_unregister(dev_net(so->dev), so->dev, 
so->rxid,
                                           SINGLE_MASK(so->rxid),
                                           isotp_rcv, sk);

-               can_rx_unregister(net, so->dev, so->txid,
+               can_rx_unregister(dev_net(so->dev), so->dev, so->txid,
                                   SINGLE_MASK(so->txid),
                                   isotp_rcv_echo, sk);
                 netdev_put(so->dev, &so->dev_tracker);
         }

@@ -1846,13 +1846,10 @@ static int isotp_getsockopt(struct socket *sock, 
int level, int optname,
  static void isotp_notify(struct isotp_sock *so, unsigned long msg,
                          struct net_device *dev)
  {
         struct sock *sk = &so->sk;

-       if (!net_eq(dev_net(dev), sock_net(sk)))
-               return;
-
         if (so->dev != dev)
                 return;

         switch (msg) {
         case NETDEV_UNREGISTER:


Can you give it a try with your KASAN setup and maybe also ask opus 
about my idea?

Many thanks,
Oliver

On 31.08.26 10:30, Norbert Szetei wrote:
> isotp_release() removes the socket from isotp_notifier_list before it
> takes rtnl_lock(). The netdev notifier chain runs under RTNL, so a
> socket that leaves the list in that window is skipped by isotp_notify()
> and has to unregister its own CAN filters.
> 
> It cannot always do that. isotp_release() passes sock_net(sk) to
> can_rx_unregister(), which returns early when that netns no longer
> matches dev_net(dev), before the receiver list is searched and before
> the "receive list entry not found" warning. Once the bound device has
> been moved to another netns the filters are removed zero times, and
> can_rx_register() stores rcv->sk without taking a reference, so the
> receivers left in the device's dev_rcv_lists point at the freed socket
> and travel with the device into the new netns.
> 
>    BUG: KASAN: use-after-free in isotp_rcv+0x1570/0x24d0
>    Read of size 1 at addr ffff888118130552 by task isotp_ns_uaf/578
>     can_rcv_filter+0x4af/0x8c0
>     can_receive+0x28d/0x3c0
>     can_rcv+0x2a9/0x310
>     __netif_receive_skb_one_core+0x21a/0x260
>     process_backlog+0x210/0x760
> 
> Take rtnl_lock() before removing the socket from the notifier list, so
> that isotp_release() and isotp_notify() cannot both skip the removal.
> 
> Fixes: 20bab8b88baa ("can: isotp: fix use-after-free race with concurrent NETDEV_UNREGISTER")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> ---
> Reproducer available on request.
> 
>   net/can/isotp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 155530aedce2..8ca75d30360c 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1475,6 +1475,8 @@ static int isotp_release(struct socket *sock)
>   	/* forced SHUTDOWN may have skipped IDLE (gave up on a signal) */
>   	wake_up_interruptible(&so->wait);
>   
> +	rtnl_lock();
> +
>   	spin_lock(&isotp_notifier_lock);
>   	while (isotp_busy_notifier == so) {
>   		spin_unlock(&isotp_notifier_lock);
> @@ -1484,7 +1486,6 @@ static int isotp_release(struct socket *sock)
>   	list_del(&so->notifier);
>   	spin_unlock(&isotp_notifier_lock);
>   
> -	rtnl_lock();
>   	lock_sock(sk);
>   
>   	/* remove current filters & unregister

