Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.217
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793199881;
	b=07Ru0t6dJ8pR5YA0shUl1VATrhyTnHczbBAPjhPF19ZwITWZC4sONIeKNVo76AUpmJz+
	 XvjGIK5RYd28Izxt2xkMYgd+aYLPBzb9yk5zFX7c6GF8latndQqF9DtNcaL7Gu2sZzVtd
	 2thfuMtEkY2upJU9ldxSHgT2iP4hbX7aSF+EiW0VCBYULL9CqoKHeEgwNsglvIadvislf
	 hd9x7nrSWnnUZHFVDNArgnX65weFriOU/WehcjfmcD9tbVG67Mafojil6ctf6KqWtU88Y
	 k7ap0qpnPvHiX7fD0UoJTK5BZBcKpnGNV1Qr1iRpkE5+GUSNfMJ6y+n8Er5WHAX5/VQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199881;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Dl84GTZRgrYac+FKBDF98qVNR3679gYTNcSOnI3FujA=;
	b=0WftG6MhTazGONhk7KQEpxR84/fibjSEayywI/4iVkRgpwU2W5VbQPc/Yonbm/6us6Pq
	 T+tDZfIayuweQxOAoZAUklXFspTHZfcuWDXiAGP1ZrcmFxXzZ/LC6KCG9+m4n/03qWNQq
	 DRgQ+xMg3thLyvZj0VcMRM/Gx0X+rFvcI/3P9SRkBaIwnM54lD+Qmide6+Zmwv9kDzCb9
	 09q4fHUjtZAms2dcJQQnuodxStuTsi7SOJSuYV/byTH5BIFPpJdcXy8lAp2GxoYL4r+mJ
	 zyajFaHA/abS9KxhzPSwjS3k8ZK+00KiOuobhtdtcq72T01WslztP6JXwvswfqHpjTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mquBPOJF;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=jj+T5XGe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.217
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AA760A2617
	for <linux-can@vger.kernel.org>; Wed, 28 Oct 2026 15:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78AA760A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mquBPOJF;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=jj+T5XGe
ARC-Seal: i=1; a=rsa-sha256; t=1793199866; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rfntkRNnxQt5KzzpdlMFbZuTBxllVV+n2AaSY9XZbQxcBgBcFpQa7f85SYtCJbbUOf
    GGyvAKeBxHxxVf58dN2Z/yyxqFMSKhBbu2QvsEpku2EQl2UaIEY/TpGcAYCLyCC5Gtei
    Zp0loFy63LEnceilTUJHJo9eMF8xnGHj7KXkSJ+I6c/XXFC3kIluWPxpOWDJLfyiRUKU
    WMTV6jri7nlIuxrbgn2VroIksiW74jRFjNBq2R4R+btYt4VObNcJdNnZA5Fnt2yqISfU
    ZAYrfp4W01IBAgqdEMNrIGoA3y9y+pPgTpLFr3KQkptKx5Z7zuoHdxpgyRcWUNgtLjRK
    s1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793199866;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Dl84GTZRgrYac+FKBDF98qVNR3679gYTNcSOnI3FujA=;
    b=HCMyRASZsQJF/mveaInRjxzRxk8ntqriIbcXCYd4y8TwrjAB6aaJk6Oc0ozHjfr91B
    +zYGcMm/xPDGr+sTFFjqdbP+FpARwMf4sLcB9/iEC4f6tcHKRjypJy+TwVl+RlUXzPnE
    +DdObogNKDasMdKZcapZ1atc5nCUavBn3UvtRbnyJi46CcaP28+3Xi1oG4QlGPWbWQxl
    Ht8HhjmK1tF54DTxx0MA8yPGt7uRYcfCzXgS+3zfGH29ysmB5E9Ndph308jatoIeATO8
    W8jTb1h0Kl/GktPbhZQPbUyxxwZyMr9+6lwznfGiRCbL11OHb4Gq0RE+fqNgMUZy3TLM
    D8Jg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793199866;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Dl84GTZRgrYac+FKBDF98qVNR3679gYTNcSOnI3FujA=;
    b=mquBPOJFFPSxx4WAdlu5f5fZ1dVtAPStrE4xLYERMs6GF7TWzs7efcxgaF+bZ9Ncib
    HpSCFQovjHAdh5WU4uEYKbwlA9hDJ7H4jbRZwni3KwVZNKdBSp6Ut8MrKhq3d38I5ga1
    vIs4nT0olumT6zsivy+9bL5L+1Kt/R0Yj/SHR1uEuxn0LYhw8ysthh9QAtOAHX1tWPTB
    ZUAyc/5u0klFj/z/0de+bouJ2WTOVnz0VN5aCziFsMXv3s02zzQJmKRo7nOO/vdgXQtE
    1W4L4H+JKEPcvIrIztZcapKdOJtrMGcH/V0C/q4bMzRfrfvonVu0K+kVBT+mFJLcBhAB
    E7sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793199866;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Dl84GTZRgrYac+FKBDF98qVNR3679gYTNcSOnI3FujA=;
    b=jj+T5XGeruc7zMxENSs/wDtuNhJw+VfstMuP9ZvbAKoNPLB/PCVscMcI+e8cEPg3fN
    Z50jEoTlsrQ5kmBakvCw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29SF4QKCA
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 28 Oct 2026 16:04:26 +0100 (CET)
Message-ID: <08409264-c2b3-489a-b645-5849d7352990@hartkopp.net>
Date: Wed, 28 Oct 2026 16:04:21 +0100
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
Subject: Re: [PATCH net v2 1/1] can: bcm: limit RX operation resource usage
 per socket
To: Zihan Xi <zihanx@nebusec.ai>, linux-can@vger.kernel.org,
 mkl@pengutronix.de
Cc: urs.thuermann@volkswagen.de, davem@davemloft.net, vega@nebusec.ai
References: <cover.1793089479.git.zihanx@nebusec.ai>
 <cover.1793109154.git.zihanx@nebusec.ai>
 <50f8970ce7800947332f6203626abbe1933997eb.1793109154.git.zihanx@nebusec.ai>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <50f8970ce7800947332f6203626abbe1933997eb.1793109154.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Just in the case it was not clear to you here:

https://lore.kernel.org/linux-can/350df96b-5f69-490e-b39e-ed6e9bca4754@hartkopp.net/

Your patch does not solve the problem and will not be merged.

Please stop sending updates.

FYI it will go into this direction below, when the current patches are 
upstream. I already have a prepared patch for this issue.

Best regards,
Oliver

(..)

Enable memcg accounting instead, as it has been done for other
allocations that can be triggered by unprivileged users:
- use GFP_KERNEL_ACCOUNT for the bcm_op structures and their frames and
   last_frames arrays in bcm_tx_setup() and bcm_rx_setup()
- create the rcv_cache with SLAB_ACCOUNT, which covers the CAN receivers
   of all CAN protocols

(..)

--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -919,7 +919,7 @@ static __init int can_init(void)
  	rcv_cache = kmem_cache_create("can_receiver", sizeof(struct receiver),
-				      0, 0, NULL);
+				      0, SLAB_ACCOUNT, NULL);
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1155,7 +1155,7 @@ static int bcm_tx_setup(...)
-		op = kzalloc(OPSIZ, GFP_KERNEL);
+		op = kzalloc(OPSIZ, GFP_KERNEL_ACCOUNT);
@@ -1172,7 +1172,7 @@ static int bcm_tx_setup(...)
  			op->frames = kmalloc_array(msg_head->nframes,
  						   op->cfsiz,
-						   GFP_KERNEL);
+						   GFP_KERNEL_ACCOUNT);
@@ -1403,7 +1403,7 @@ static int bcm_rx_setup(...)
-		op = kzalloc(OPSIZ, GFP_KERNEL);
+		op = kzalloc(OPSIZ, GFP_KERNEL_ACCOUNT);
@@ -1418,7 +1418,7 @@ static int bcm_rx_setup(...)
  			op->frames = kmalloc_array(msg_head->nframes,
  						   op->cfsiz,
-						   GFP_KERNEL);
+						   GFP_KERNEL_ACCOUNT);
@@ -1427,7 +1427,7 @@ static int bcm_rx_setup(...)
  			op->last_frames = kcalloc(msg_head->nframes,
  						  op->cfsiz,
-						  GFP_KERNEL);
+						  GFP_KERNEL_ACCOUNT);

(..)

On 28.10.26 14:43, Zihan Xi wrote:
> BCM sockets can create an unbounded number of RX operations. Each
> operation allocates memory outside of the socket buffer accounting,
> so a single unprivileged socket can exhaust kernel memory.
> 
> Bound the number and aggregate allocation size of RX operations per
> socket. Keep the charge until the operation and its frame arrays are
> freed. Also keep a receiver count charged until the CAN core releases
> the receiver after its RCU grace period, so repeated setup/delete
> requests cannot bypass the limits while callbacks are pending.
> 
> Return -ENOBUFS when a socket reaches either limit. Existing operations
> can still be updated without additional charges.
> 
> Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://bugtracker.nebusec.ai/f/11134
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---
>   include/linux/can/core.h |   7 +++
>   net/can/af_can.c         |  34 ++++++++++-
>   net/can/af_can.h         |   1 +
>   net/can/bcm.c            | 127 +++++++++++++++++++++++++++++++++------
>   4 files changed, 147 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/can/core.h b/include/linux/can/core.h
> index 2de74c2b78b6..89b9d0a2dcc1 100644
> --- a/include/linux/can/core.h
> +++ b/include/linux/can/core.h
> @@ -53,6 +53,13 @@ int can_rx_register(struct net *net, struct net_device *dev,
>   		    void (*func)(struct sk_buff *, void *),
>   		    void *data, char *ident, struct sock *sk);
>   
> +/* release runs from an RCU callback and must not sleep. */
> +int can_rx_register_with_release(struct net *net, struct net_device *dev,
> +				 canid_t can_id, canid_t mask,
> +				 void (*func)(struct sk_buff *, void *),
> +				 void *data, char *ident, struct sock *sk,
> +				 void (*release)(struct sock *sk));
> +
>   extern void can_rx_unregister(struct net *net, struct net_device *dev,
>   			      canid_t can_id, canid_t mask,
>   			      void (*func)(struct sk_buff *, void *),
> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index 34fe3b28d576..a3f0ed35fbb5 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -441,15 +441,20 @@ static struct hlist_head *can_rcv_list_find(canid_t *can_id, canid_t *mask,
>    *  -ENOMEM on missing cache mem to create subscription entry
>    *  -ENODEV unknown device
>    */
> -int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
> -		    canid_t mask, void (*func)(struct sk_buff *, void *),
> -		    void *data, char *ident, struct sock *sk)
> +static int can_rx_register_internal(struct net *net, struct net_device *dev,
> +				    canid_t can_id, canid_t mask,
> +				    void (*func)(struct sk_buff *, void *),
> +				    void *data, char *ident, struct sock *sk,
> +				    void (*release)(struct sock *sk))
>   {
>   	struct receiver *rcv;
>   	struct hlist_head *rcv_list;
>   	struct can_dev_rcv_lists *dev_rcv_lists;
>   	struct can_rcv_lists_stats *rcv_lists_stats = net->can.rcv_lists_stats;
>   
> +	if (release && !sk)
> +		return -EINVAL;
> +
>   	/* insert new receiver  (dev,canid,mask) -> (func,data) */
>   
>   	if (dev && (dev->type != ARPHRD_CAN || !can_get_ml_priv(dev)))
> @@ -474,6 +479,7 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
>   	rcv->data = data;
>   	rcv->ident = ident;
>   	rcv->sk = sk;
> +	rcv->release = release;
>   
>   	hlist_add_head_rcu(&rcv->list, rcv_list);
>   	dev_rcv_lists->entries++;
> @@ -485,15 +491,37 @@ int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
>   
>   	return 0;
>   }
> +
> +int can_rx_register(struct net *net, struct net_device *dev, canid_t can_id,
> +		    canid_t mask, void (*func)(struct sk_buff *, void *),
> +		    void *data, char *ident, struct sock *sk)
> +{
> +	return can_rx_register_internal(net, dev, can_id, mask, func, data,
> +					ident, sk, NULL);
> +}
>   EXPORT_SYMBOL(can_rx_register);
>   
> +int can_rx_register_with_release(struct net *net, struct net_device *dev,
> +				 canid_t can_id, canid_t mask,
> +				 void (*func)(struct sk_buff *, void *),
> +				 void *data, char *ident, struct sock *sk,
> +				 void (*release)(struct sock *sk))
> +{
> +	return can_rx_register_internal(net, dev, can_id, mask, func, data,
> +					ident, sk, release);
> +}
> +EXPORT_SYMBOL(can_rx_register_with_release);
> +
>   /* can_rx_delete_receiver - rcu callback for single receiver entry removal */
>   static void can_rx_delete_receiver(struct rcu_head *rp)
>   {
>   	struct receiver *rcv = container_of(rp, struct receiver, rcu);
>   	struct sock *sk = rcv->sk;
> +	void (*release)(struct sock *sk) = rcv->release;
>   
>   	kmem_cache_free(rcv_cache, rcv);
> +	if (release)
> +		release(sk);
>   	if (sk)
>   		sock_put(sk);
>   }
> diff --git a/net/can/af_can.h b/net/can/af_can.h
> index 87887014f562..2fa4cf8c1314 100644
> --- a/net/can/af_can.h
> +++ b/net/can/af_can.h
> @@ -57,6 +57,7 @@ struct receiver {
>   	void *data;
>   	char *ident;
>   	struct sock *sk;
> +	void (*release)(struct sock *sk);
>   	struct rcu_head rcu;
>   };
>   
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 3d637a1e0ac1..477bdc1e8745 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -58,6 +58,7 @@
>   #include <linux/can/skb.h>
>   #include <linux/can/bcm.h>
>   #include <linux/slab.h>
> +#include <linux/overflow.h>
>   #include <linux/workqueue.h>
>   #include <linux/spinlock.h>
>   #include <net/can.h>
> @@ -127,6 +128,7 @@ struct bcm_op {
>   	void *last_frames;
>   	struct canfd_frame sframe;
>   	struct canfd_frame last_sframe;
> +	size_t rx_mem;
>   	struct sock *sk;
>   	struct net_device *rx_reg_dev;
>   	netdevice_tracker rx_reg_dev_tracker;
> @@ -141,6 +143,9 @@ struct bcm_sock {
>   	struct list_head notifier;
>   	struct list_head rx_ops;
>   	struct list_head tx_ops;
> +	unsigned int rx_op_count;
> +	size_t rx_mem_used;
> +	atomic_t rx_receiver_count;
>   	unsigned long dropped_usr_msgs;
>   	struct proc_dir_entry *bcm_proc_read;
>   	char procname [32]; /* inode number in decimal with \0 */
> @@ -190,6 +195,10 @@ static bool bcm_is_invalid_tv(struct bcm_msg_head *msg_head)
>   #define OPSIZ sizeof(struct bcm_op)
>   #define MHSIZ sizeof(struct bcm_msg_head)
>   
> +/* Bound the resources consumed by RX operations on one BCM socket. */
> +#define BCM_MAX_RX_OPS 1024
> +#define BCM_MAX_RX_MEM (16 * 1024 * 1024)
> +
>   /*
>    * procfs functions
>    */
> @@ -922,9 +931,64 @@ static struct bcm_op *bcm_find_op(struct list_head *ops,
>   	return NULL;
>   }
>   
> +/* Called with the socket lock held. */
> +static bool bcm_rx_op_charge(struct bcm_sock *bo, size_t rx_mem)
> +{
> +	if (bo->rx_op_count >= BCM_MAX_RX_OPS ||
> +	    rx_mem > BCM_MAX_RX_MEM - bo->rx_mem_used)
> +		return false;
> +
> +	bo->rx_op_count++;
> +	bo->rx_mem_used += rx_mem;
> +	return true;
> +}
> +
> +/* Called with the socket lock held. */
> +static void bcm_rx_op_uncharge(struct bcm_sock *bo, size_t rx_mem)
> +{
> +	if (!rx_mem)
> +		return;
> +
> +	if (WARN_ON_ONCE(!bo->rx_op_count || bo->rx_mem_used < rx_mem))
> +		return;
> +
> +	bo->rx_op_count--;
> +	bo->rx_mem_used -= rx_mem;
> +}
> +
> +static void bcm_rx_receiver_release(struct sock *sk)
> +{
> +	struct bcm_sock *bo = bcm_sk(sk);
> +
> +	WARN_ON_ONCE(atomic_dec_return(&bo->rx_receiver_count) < 0);
> +}
> +
> +/* Called with the socket lock held. */
> +static int bcm_rx_register(struct bcm_op *op, struct net_device *dev)
> +{
> +	struct bcm_sock *bo = bcm_sk(op->sk);
> +	int err;
> +
> +	if (atomic_inc_return(&bo->rx_receiver_count) > BCM_MAX_RX_OPS) {
> +		atomic_dec(&bo->rx_receiver_count);
> +		return -ENOBUFS;
> +	}
> +
> +	err = can_rx_register_with_release(sock_net(op->sk), dev, op->can_id,
> +					   REGMASK(op->can_id), bcm_rx_handler,
> +					   op, "bcm", op->sk,
> +					   bcm_rx_receiver_release);
> +	if (err)
> +		atomic_dec(&bo->rx_receiver_count);
> +
> +	return err;
> +}
> +
>   static void bcm_free_op_work(struct work_struct *work)
>   {
>   	struct bcm_op *op = container_of(work, struct bcm_op, work);
> +	struct sock *sk = op->sk;
> +	size_t rx_mem = op->rx_mem;
>   
>   	hrtimer_cancel(&op->timer);
>   	hrtimer_cancel(&op->thrtimer);
> @@ -935,13 +999,20 @@ static void bcm_free_op_work(struct work_struct *work)
>   	if ((op->last_frames) && (op->last_frames != &op->last_sframe))
>   		kfree(op->last_frames);
>   
> -	/* the last possible access to op->timer/op->thrtimer has now
> -	 * happened above via hrtimer_cancel() - op->sk is no longer
> -	 * needed by any pending timer callback, so drop our reference
> +	kfree(op);
> +	/*
> +	 * Keep the RX budget charged until the operation and its frame arrays
> +	 * have actually been freed. op->sk holds a reference while this work is
> +	 * pending, so the socket remains valid while updating its accounting.
>   	 */
> -	sock_put(op->sk);
> +	if (rx_mem) {
> +		lock_sock(sk);
> +		bcm_rx_op_uncharge(bcm_sk(sk), rx_mem);
> +		release_sock(sk);
> +	}
>   
> -	kfree(op);
> +	/* Drop the reference held for the operation and any pending timer. */
> +	sock_put(sk);
>   }
>   
>   static void bcm_free_op_rcu(struct rcu_head *rcu_head)
> @@ -1316,6 +1387,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>   {
>   	struct bcm_sock *bo = bcm_sk(sk);
>   	struct bcm_op *op;
> +	size_t rx_mem, frames_size, arrays_size;
>   	int do_rx_register;
>   	int new_op = 0;
>   	int err = 0;
> @@ -1414,10 +1486,31 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>   		do_rx_register = (ifindex && !op->rx_reg_dev) ? 1 : 0;
>   
>   	} else {
> +		/*
> +		 * Charge the operation and its frame arrays before allocating
> +		 * them or registering a CAN receiver. nframes is already bounded
> +		 * above, but keep the size arithmetic explicitly overflow-safe.
> +		 */
> +		rx_mem = sizeof(*op);
> +		if (msg_head->nframes > 1) {
> +			if (check_mul_overflow((size_t)msg_head->nframes,
> +					       (size_t)CFSIZ(msg_head->flags),
> +					       &frames_size) ||
> +			    check_mul_overflow(frames_size, (size_t)2,
> +					       &arrays_size) ||
> +			    check_add_overflow(rx_mem, arrays_size, &rx_mem))
> +				return -EOVERFLOW;
> +		}
> +
> +		if (!bcm_rx_op_charge(bo, rx_mem))
> +			return -ENOBUFS;
> +
>   		/* insert new BCM operation for the given can_id */
>   		op = kzalloc(OPSIZ, GFP_KERNEL);
> -		if (!op)
> +		if (!op) {
> +			bcm_rx_op_uncharge(bo, rx_mem);
>   			return -ENOMEM;
> +		}
>   
>   		spin_lock_init(&op->bcm_tx_lock);
>   		spin_lock_init(&op->bcm_rx_update_lock);
> @@ -1425,6 +1518,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>   		op->nframes = msg_head->nframes;
>   		op->cfsiz = CFSIZ(msg_head->flags);
>   		op->flags = msg_head->flags;
> +		op->rx_mem = rx_mem;
>   
>   		if (msg_head->nframes > 1) {
>   			/* create array for CAN frames and copy the data */
> @@ -1432,8 +1526,8 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>   						   op->cfsiz,
>   						   GFP_KERNEL);
>   			if (!op->frames) {
> -				kfree(op);
> -				return -ENOMEM;
> +				err = -ENOMEM;
> +				goto free_op;
>   			}
>   
>   			/* create and init array for received CAN frames */
> @@ -1441,9 +1535,8 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>   						  op->cfsiz,
>   						  GFP_KERNEL);
>   			if (!op->last_frames) {
> -				kfree(op->frames);
> -				kfree(op);
> -				return -ENOMEM;
> +				err = -ENOMEM;
> +				goto free_op;
>   			}
>   
>   		} else {
> @@ -1532,11 +1625,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>   
>   			dev = dev_get_by_index(sock_net(sk), ifindex);
>   			if (dev) {
> -				err = can_rx_register(sock_net(sk), dev,
> -						      op->can_id,
> -						      REGMASK(op->can_id),
> -						      bcm_rx_handler, op,
> -						      "bcm", sk);
> +				err = bcm_rx_register(op, dev);
>   
>   				/* keep a tracked reference so that a later
>   				 * unregister can safely reach the device even
> @@ -1558,9 +1647,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>   			}
>   
>   		} else {
> -			err = can_rx_register(sock_net(sk), NULL, op->can_id,
> -					      REGMASK(op->can_id),
> -					      bcm_rx_handler, op, "bcm", sk);
> +			err = bcm_rx_register(op, NULL);
>   		}
>   
>   		if (err) {
> @@ -1593,6 +1680,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>   	if (op->last_frames != &op->last_sframe)
>   		kfree(op->last_frames);
>   	kfree(op);
> +	bcm_rx_op_uncharge(bo, rx_mem);
>   	return err;
>   }
>   
> @@ -1896,6 +1984,7 @@ static int bcm_init(struct sock *sk)
>   	bo->ifindex          = 0;
>   	bo->dropped_usr_msgs = 0;
>   	bo->bcm_proc_read    = NULL;
> +	atomic_set(&bo->rx_receiver_count, 0);
>   
>   	INIT_LIST_HEAD(&bo->tx_ops);
>   	INIT_LIST_HEAD(&bo->rx_ops);

