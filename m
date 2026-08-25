Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852B54028CA
	for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787669940; cv=pass; b=QTRd4iOx9RMFV5vGWTGbz1a6LTEXOpjSDvQBkFXiwXKNdrcPlN/K87Uo2z/f+jXuFR03VboPIdQgbqhyfuMVtRsMnKlFWNi1FetwnKvljr4UoScBDiUhAby9kpVxNh05+tb1fBuykFnAw0miDfe50iG9s8ys5B+zYRevWiyJdcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787669940; c=relaxed/simple;
	bh=LhQas4KRCe5CXHfDhmMbCRFVTHrucRYEfvWYcjyc2w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U03l7HKK/ndk0SqqDRXkSQEJrqV+ZhGLqCD2ALZdH0Ejeax7bDeaCkY5dafKFv5BHM1S0fjG8ddwG5UfNVLJJYRmcSSwG8iLk+WOoLyqUTpddhzSxYD4T0f91/oJULMYUFJY3sS+l+Bs64zPRxOeEaZW4HkBK+9QTYr5EB+OumQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jTE6Ec7Y; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=bad+V1/c; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jTE6Ec7Y";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="bad+V1/c"
ARC-Seal: i=1; a=rsa-sha256; t=1787669745; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=e83O7RdZEstvQhfnQC7lWLyIjUtwYLBnbVdysilDp3yV816sxhIZSfieOUot/SRaOI
    bbv2wDdicFpZ3oQkH/Q8BHRYSry4cvEzI0unfcrKTUan7gtOwNhbc2lRJ4+D9KoNu5WU
    YibURul7Qfw56lSfR7ei0aleyrQaKt2lTnsr78qxDTKZyIKA5FgCNIEqyft5u782dSnM
    kmyMeHSjpLLCCMp7tKRucbPd89qzFMyhL4KTf94mtKdDoQuKHpqNpSUCklBSLDsooMSz
    qNkQfPzaFZYU3zdzkbWYyL6nmOOKdk1YdtJjax+jp+g8AMq7tiOBSZZvff9nIpQkJNYr
    A8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1787669745;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fEy8CR0z45P47kCZMWFUsosscYPvmU6uv/CiL36pgeA=;
    b=fBJj3Kqq2iisai5G62gRcIeMiocIdPO6wrxx8TWC9SqwQhkRmMYJ+Z2sHh5SUlqFxH
    TIL6zu1H63peXNhyxeQTlSC33xtegBEPUV6cJxt6i25WoaC6k5LbUS2xcKlE3Vw5ZnPW
    bHsFthBRzuK9xvMfHwTpMqXIpgpoUoIcFAPCvveEZ3niLGBwCPp1K8IqK3ieDIztrVhC
    9qFMtVKE+sBS104B6/7xoM1HzoPcE4kN7wIoz7X1+g8xht3jNimPajr0+O6fLCMhYaJq
    5DQxI5MfX+LPtzMo4o5RafObsSKfkZOkYWMrPeTQAE8A3p3v2M7JlJ5XZ3FkYaBMdGVO
    I3xQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1787669745;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fEy8CR0z45P47kCZMWFUsosscYPvmU6uv/CiL36pgeA=;
    b=jTE6Ec7YeNKci2YA4g7Sod2Djcna++nQFy7sxWzSM/PXF2ZY3bfbgWq+HQCnQhJEm/
    7RmT/0ZvgEQgGY1Z+FReMAuGw8SajppWphSTJrv2DBJPbOg9fYSFCdyXT9J/dvSQQMmT
    jRtfy/2e4T4hvtmLqiD2GWaZ2klyUjzYSIUlgU5ZuD+fBcFAn7tnHHb43VQO2qY4YeLu
    86o+TW2jxu/4zaT3ROjhvIW4UHkSe3/ioej0q3wrUxLImGXyY/MAETFO0qvsY3FOnOFM
    7thgnIHon7894shccmFlbjZkHYFvBaYPYcgRPs2zVuRQHU3SEtuAqiLXQrqmQlTdbXrn
    I0NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1787669745;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fEy8CR0z45P47kCZMWFUsosscYPvmU6uv/CiL36pgeA=;
    b=bad+V1/ctRBvMZGh05hY9L/SkNSZC4/mWBGjz+rD0rEgr05icDVc2sGNJN45RWQCp1
    jaxQFAS5OBmFi1o0uJBA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.2 AUTH)
    with ESMTPSA id K171b727PEtjlHu
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 25 Aug 2026 16:55:45 +0200 (CEST)
Message-ID: <c3fc21b4-db28-4323-b182-eeeb646e64da@hartkopp.net>
Date: Tue, 25 Aug 2026 16:55:39 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: convert unreliable ARPHRD_CAN type checks to robust
 can_get_ml_priv()
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, stable@kernel.org,
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20260819160822.8256-1-socketcan@hartkopp.net>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260819160822.8256-1-socketcan@hartkopp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marc,

as you are currently filling your linux-can git repo, please take care 
of this (stable) patch too.

Do you think that these two patches below should be integrated into a 
net pull?

[can-next v2] can: proc: remove pointers from CAN specific proc output
https://lore.kernel.org/linux-can/20260815103400.117175-1-socketcan@hartkopp.net/

[can-next] can: remove Softing CANcard driver
https://lore.kernel.org/linux-can/20260815103428.117201-1-socketcan@hartkopp.net/

Best regards,
Oliver

On 19.08.26 18:08, Oliver Hartkopp wrote:
> Commit 4e096a18867a ("net: introduce CAN specific pointer in the struct
> net_device") introduced an explicit way to assign the midlayer private
> pointer (dev->ml_priv) to named users like ML_PRIV_CAN.
> 
> With this extension the CAN device specific ml_priv assignment became a
> robust indicator to identify a valid CAN device, when can_get_ml_priv()
> returns a valid pointer.
> 
> This has been used directly by the referenced commit in the CAN specific
> j1939 and proc code but not in the other parts of the CAN subsystem.
> 
> With the TUN/TAP driver a device's ARPHRD type can be controlled by
> userspace independently of its midlayer private data (ml_priv). The
> TUNSETLINK ioctl allows a down TUN/TAP device to overwrite its hardware
> type to become ARPHRD_CAN while dev->ml_priv remains NULL (uninitialized).
> 
> Instead of checking dev->type being the unreliable ARPHRD_CAN value convert
> the missing "valid CAN devices" checks to can_get_ml_priv().
> 
> Fixes: 4e096a18867a ("net: introduce CAN specific pointer in the struct net_device")
> Cc: stable@kernel.org
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   net/can/af_can.c | 12 ++++++------
>   net/can/bcm.c    |  7 ++++---
>   net/can/gw.c     |  7 ++++---
>   net/can/isotp.c  |  5 +++--
>   net/can/raw.c    |  4 ++--
>   5 files changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index be0661679ef8..1d30a622063c 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -224,11 +224,11 @@ int can_send(struct sk_buff *skb, int loop)
>   	if (unlikely(skb->len > READ_ONCE(skb->dev->mtu))) {
>   		err = -EMSGSIZE;
>   		goto inval_skb;
>   	}
>   
> -	if (unlikely(skb->dev->type != ARPHRD_CAN)) {
> +	if (unlikely(!can_get_ml_priv(skb->dev))) {
>   		err = -EPERM;
>   		goto inval_skb;
>   	}
>   
>   	if (unlikely(!(skb->dev->flags & IFF_UP))) {
> @@ -450,11 +450,11 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
>   	struct can_dev_rcv_lists *dev_rcv_lists;
>   	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
>   
>   	/* insert new receiver  (dev,canid,mask) -> (func,data) */
>   
> -	if (dev && (dev->type != ARPHRD_CAN || !can_get_ml_priv(dev)))
> +	if (dev && !can_get_ml_priv(dev))
>   		return -ENODEV;
>   
>   	if (dev && !net_eq(net, dev_net(dev)))
>   		return -ENODEV;
>   
> @@ -517,11 +517,11 @@ void can_rx_unregister(struct net *net, struct net_device *dev, canid_t can_id,
>   	struct receiver *rcv = NULL;
>   	struct hlist_head *rcv_list;
>   	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
>   	struct can_dev_rcv_lists *dev_rcv_lists;
>   
> -	if (dev && dev->type != ARPHRD_CAN)
> +	if (dev && !can_get_ml_priv(dev))
>   		return;
>   
>   	if (dev && !net_eq(net, dev_net(dev)))
>   		return;
>   
> @@ -685,11 +685,11 @@ static void can_receive(struct sk_buff *skb, struct net_device *dev)
>   }
>   
>   static int can_rcv(struct sk_buff *skb, struct net_device *dev,
>   		   struct packet_type *pt, struct net_device *orig_dev)
>   {
> -	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
> +	if (unlikely(!can_get_ml_priv(dev) ||
>   		     !can_skb_ext_find(skb) || !can_is_can_skb(skb))) {
>   		pr_warn_once("PF_CAN: dropped non conform CAN skbuff: dev type %d, len %d\n",
>   			     dev->type, skb->len);
>   
>   		kfree_skb_reason(skb, SKB_DROP_REASON_CAN_RX_INVALID_FRAME);
> @@ -701,11 +701,11 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
>   }
>   
>   static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
>   		     struct packet_type *pt, struct net_device *orig_dev)
>   {
> -	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
> +	if (unlikely(!can_get_ml_priv(dev) ||
>   		     !can_skb_ext_find(skb) || !can_is_canfd_skb(skb))) {
>   		pr_warn_once("PF_CAN: dropped non conform CAN FD skbuff: dev type %d, len %d\n",
>   			     dev->type, skb->len);
>   
>   		kfree_skb_reason(skb, SKB_DROP_REASON_CANFD_RX_INVALID_FRAME);
> @@ -717,11 +717,11 @@ static int canfd_rcv(struct sk_buff *skb, struct net_device *dev,
>   }
>   
>   static int canxl_rcv(struct sk_buff *skb, struct net_device *dev,
>   		     struct packet_type *pt, struct net_device *orig_dev)
>   {
> -	if (unlikely(dev->type != ARPHRD_CAN || !can_get_ml_priv(dev) ||
> +	if (unlikely(!can_get_ml_priv(dev) ||
>   		     !can_skb_ext_find(skb) || !can_is_canxl_skb(skb))) {
>   		pr_warn_once("PF_CAN: dropped non conform CAN XL skbuff: dev type %d, len %d\n",
>   			     dev->type, skb->len);
>   
>   		kfree_skb_reason(skb, SKB_DROP_REASON_CANXL_RX_INVALID_FRAME);
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index dff8fab6b402..2f261c438f52 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -52,10 +52,11 @@
>   #include <linux/netdevice.h>
>   #include <linux/socket.h>
>   #include <linux/if_arp.h>
>   #include <linux/skbuff.h>
>   #include <linux/can.h>
> +#include <linux/can/can-ml.h>
>   #include <linux/can/core.h>
>   #include <linux/can/skb.h>
>   #include <linux/can/bcm.h>
>   #include <linux/slab.h>
>   #include <linux/workqueue.h>
> @@ -1716,11 +1717,11 @@ static int bcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
>   			if (!dev) {
>   				ret = -ENODEV;
>   				goto out_release;
>   			}
>   
> -			if (dev->type != ARPHRD_CAN) {
> +			if (!can_get_ml_priv(dev)) {
>   				dev_put(dev);
>   				ret = -ENODEV;
>   				goto out_release;
>   			}
>   
> @@ -1864,11 +1865,11 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
>   static int bcm_notifier(struct notifier_block *nb, unsigned long msg,
>   			void *ptr)
>   {
>   	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
>   
> -	if (dev->type != ARPHRD_CAN)
> +	if (!can_get_ml_priv(dev))
>   		return NOTIFY_DONE;
>   	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
>   		return NOTIFY_DONE;
>   	if (unlikely(bcm_busy_notifier)) /* Check for reentrant bug. */
>   		return NOTIFY_DONE;
> @@ -2021,11 +2022,11 @@ static int bcm_connect(struct socket *sock, struct sockaddr_unsized *uaddr, int
>   		dev = dev_get_by_index(net, addr->can_ifindex);
>   		if (!dev) {
>   			ret = -ENODEV;
>   			goto fail;
>   		}
> -		if (dev->type != ARPHRD_CAN) {
> +		if (!can_get_ml_priv(dev)) {
>   			dev_put(dev);
>   			ret = -ENODEV;
>   			goto fail;
>   		}
>   
> diff --git a/net/can/gw.c b/net/can/gw.c
> index f1f59c0c6fd6..b946da2d0a60 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -50,10 +50,11 @@
>   #include <linux/net.h>
>   #include <linux/netdevice.h>
>   #include <linux/if_arp.h>
>   #include <linux/skbuff.h>
>   #include <linux/can.h>
> +#include <linux/can/can-ml.h>
>   #include <linux/can/core.h>
>   #include <linux/can/skb.h>
>   #include <linux/can/gw.h>
>   #include <net/can.h>
>   #include <net/rtnetlink.h>
> @@ -607,11 +608,11 @@ static int cgw_notifier(struct notifier_block *nb,
>   			unsigned long msg, void *ptr)
>   {
>   	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
>   	struct net *net = dev_net(dev);
>   
> -	if (dev->type != ARPHRD_CAN)
> +	if (!can_get_ml_priv(dev))
>   		return NOTIFY_DONE;
>   
>   	if (msg == NETDEV_UNREGISTER) {
>   		struct cgw_job *gwj = NULL;
>   		struct hlist_node *nx;
> @@ -1158,19 +1159,19 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
>   	gwj->src.dev = __dev_get_by_index(net, gwj->ccgw.src_idx);
>   
>   	if (!gwj->src.dev)
>   		goto out;
>   
> -	if (gwj->src.dev->type != ARPHRD_CAN)
> +	if (!can_get_ml_priv(gwj->src.dev))
>   		goto out;
>   
>   	gwj->dst.dev = __dev_get_by_index(net, gwj->ccgw.dst_idx);
>   
>   	if (!gwj->dst.dev)
>   		goto out;
>   
> -	if (gwj->dst.dev->type != ARPHRD_CAN)
> +	if (!can_get_ml_priv(gwj->dst.dev))
>   		goto out;
>   
>   	/* is sending the skb back to the incoming interface intended? */
>   	if (gwj->src.dev == gwj->dst.dev &&
>   	    !(gwj->flags & CGW_FLAGS_CAN_IIF_TX_OK)) {
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 35ae4f51a525..130a0dbec78c 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -63,10 +63,11 @@
>   #include <linux/netdevice.h>
>   #include <linux/socket.h>
>   #include <linux/if_arp.h>
>   #include <linux/skbuff.h>
>   #include <linux/can.h>
> +#include <linux/can/can-ml.h>
>   #include <linux/can/core.h>
>   #include <linux/can/skb.h>
>   #include <linux/can/isotp.h>
>   #include <linux/slab.h>
>   #include <net/can.h>
> @@ -1604,11 +1605,11 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
>   	dev = dev_get_by_index(net, addr->can_ifindex);
>   	if (!dev) {
>   		err = -ENODEV;
>   		goto out;
>   	}
> -	if (dev->type != ARPHRD_CAN) {
> +	if (!can_get_ml_priv(dev)) {
>   		err = -ENODEV;
>   		goto out_put_dev;
>   	}
>   	if (READ_ONCE(dev->mtu) < so->ll.mtu) {
>   		err = -EINVAL;
> @@ -1891,11 +1892,11 @@ static void isotp_notify(struct isotp_sock *so, unsigned long msg,
>   static int isotp_notifier(struct notifier_block *nb, unsigned long msg,
>   			  void *ptr)
>   {
>   	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
>   
> -	if (dev->type != ARPHRD_CAN)
> +	if (!can_get_ml_priv(dev))
>   		return NOTIFY_DONE;
>   	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
>   		return NOTIFY_DONE;
>   	if (unlikely(isotp_busy_notifier)) /* Check for reentrant bug. */
>   		return NOTIFY_DONE;
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 0a8b7c2fb4c9..b700e5fde07a 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -342,11 +342,11 @@ static void raw_notify(struct raw_sock *ro, unsigned long msg,
>   static int raw_notifier(struct notifier_block *nb, unsigned long msg,
>   			void *ptr)
>   {
>   	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
>   
> -	if (dev->type != ARPHRD_CAN)
> +	if (!can_get_ml_priv(dev))
>   		return NOTIFY_DONE;
>   	if (msg != NETDEV_UNREGISTER && msg != NETDEV_DOWN)
>   		return NOTIFY_DONE;
>   	if (unlikely(raw_busy_notifier)) /* Check for reentrant bug. */
>   		return NOTIFY_DONE;
> @@ -485,11 +485,11 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
>   		dev = dev_get_by_index(sock_net(sk), addr->can_ifindex);
>   		if (!dev) {
>   			err = -ENODEV;
>   			goto out;
>   		}
> -		if (dev->type != ARPHRD_CAN) {
> +		if (!can_get_ml_priv(dev)) {
>   			err = -ENODEV;
>   			goto out_put_dev;
>   		}
>   
>   		if (!(dev->flags & IFF_UP))

