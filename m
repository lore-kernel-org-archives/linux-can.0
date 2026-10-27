Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.163
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793107382;
	b=JrtlIPstzqx31LvUs4guKH19QuyZBhOrxnWsm0luPFPJm7Xr6qbHO3oN2beQBkyo2nPk
	 AQp5LdnkMoOcAY3SYjyVEH4oIzpuxluKJP9cKBAZ+wD0h/TNN4oGRgpJVeYCICDZpk1QQ
	 L4B74MRafu6siuhodEVd6bvm4Ebt2z8JJF5SNBxNtyhYs3AEhvWCH9nRos0xEDrt9f2dG
	 pyz76Ki64CTrhQ1gD+UIEC1ay5eo5ze+nPo6xzToIpOgKekiJ0KFIoW6mpHca5umVMZPi
	 qNADc5O0+ldGDrwd87VMAHpTaE4KlcS47Uiv4z50Qg3xYLyVqFL4eA7kbTBPeLbMofg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107382;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wBiHCN9a8F0c3UEGoIfCjGnnD4v3jo9XslgQDKLMMYg=;
	b=zyfVXkt5atmSxu+yla/LZ1qGKG9ycnCLvTRb0ELbJLSIecdqQzVk+2MMCQX/088G8nWd
	 Qudq9xpiAVNhTOg3yfmoNJg+lecvz6WDND6nDf4mPu1fZbl4iVxjOGRc08uZZzO/+oghI
	 T+pb8pW2A7WuccEK9PI1WSAvNSsFlllpY6owrFyfx/UunoHW2P6ho/HfQ/JdCXDqOd7WT
	 vIZ7k69nhRPczWqpJRi/+9iaoHIeNMGKmCDMS8/oxjSVCrNR8OZZdpwKhNuxuSvAVC4ik
	 6jfkn75mVDKOxAgKq39gW7PMTQqSC/xEnlrBauLIyvBb1ta/bVXzkoTVXw5bGlLcaLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=c5RDHYdi;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=ugoQ0PF9;
	arc=fail smtp.remote-ip=81.169.146.163
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2DC606A33B
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 13:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C2DC606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=c5RDHYdi;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=ugoQ0PF9
ARC-Seal: i=1; a=rsa-sha256; t=1793107368; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kCY6NuV+aIuGbhd5KZnJZkpeSLoNGpwyZ1L57h2Oenbm/xKIKETXCtSwkzqpvuBs9j
    phGE1q03D1LKTQOQ/SRx0rWp6ZbLCtYngUQYGK+1kW0rTTOXXJdYCBznnh9cbh8NI4Ct
    ++1kH6Sgb4a9ARUGk/gCrUReQQm08H6Mf9V/9AD0mU0kvybw8aWU6ejsowseOHlAWlfa
    Ih5o7H1SzWCTDKktswcBF8KFFANvs0eVWJEOO5fJZfO1b3k4TJV2zD311ZiHasj4WatL
    CVEQjfiK2P6S+MdSePX3ElkmZ2ZXg29ypCika27+wYRzwTSLDJEnN8SstjTCgkIQXABL
    q0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793107368;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=wBiHCN9a8F0c3UEGoIfCjGnnD4v3jo9XslgQDKLMMYg=;
    b=iB88JXUCNTII3jt8nGOIBiuD3bOCCvqYTk8cDqtHEJtAsRfXkcaC/vy01ysXvbamKQ
    hmu6r/IwtasYfN9IUcZvmV5K1rCG2fmMU0nJd5LVbdzsVoHHbBIqPhLvC34+mEjseWIu
    i8SZehPq6v2qf5R2xfaKexJpPtYbjlfrvCGgG8uelpnbjw6iPYuJt0I8KZvsyEa5G0OD
    e2POIlih3y/IRzVxgkt32IGXfWgqUqd0Kk5qxS82JzC2ndyEd8t5ita0JcIA3FS4rWfN
    Oub6enI3lDZ+pkfsk9D2OI3RFaibbKHIDJt/yVjShv16IMLzRl+TgfSjmX63D5ZjpEU+
    oE4w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793107368;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=wBiHCN9a8F0c3UEGoIfCjGnnD4v3jo9XslgQDKLMMYg=;
    b=c5RDHYdiFX0WFcRJmpjAYoTgvwhi7n4WhMKlW5dVdV1h95HbFqs46yoUAIIRSLbGRZ
    QC0tAR8Hx0Or7bdWzK3q9JrZUFadDZQKd00NKs5gJEIkGHbV2llGOcVxhDGXQvuFgdEO
    BOkoxy7YVT8J0fcM4JfeDpmWKOHIy05S8hx0hvRKsU6T+RXUYyhzfSp9JxpJfaMx4xM0
    kRLdfe/a1fNw4fP5JnrWcTRlAY2kPVfTvjqK4Z+tJfwflikwxwTLTJr2i0MVJDw6QwZI
    HMwtW5pDLzUFCujFsg4gveSesPSskS1s9WCJi7sU1h5pFd3V/KqbjNUPX33XwOkDa7W8
    PKlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793107368;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=wBiHCN9a8F0c3UEGoIfCjGnnD4v3jo9XslgQDKLMMYg=;
    b=ugoQ0PF9Tfh4/04MD3vVBKwJP8wgE5Amivth1ZMISaY9eSpQBNHsMWr5Yhox+W/b6n
    bCHw7DB94m1Kfyx0gpAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29RDMl9lF
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 27 Oct 2026 14:22:47 +0100 (CET)
Message-ID: <350df96b-5f69-490e-b39e-ed6e9bca4754@hartkopp.net>
Date: Tue, 27 Oct 2026 14:22:43 +0100
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
Subject: Re: [PATCH net 1/1] can: bcm: limit RX operation resource usage per
 socket
To: Zihan Xi <zihanx@nebusec.ai>, linux-can@vger.kernel.org
Cc: mkl@pengutronix.de, davem@davemloft.net, urs.thuermann@volkswagen.de,
 vega@nebusec.ai
References: <cover.1793089479.git.zihanx@nebusec.ai>
 <92fe9d7fe3a7daa2cc7de740b15ec7eaa0638b98.1793089479.git.zihanx@nebusec.ai>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <92fe9d7fe3a7daa2cc7de740b15ec7eaa0638b98.1793089479.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Zihan,

On 27.10.26 12:18, Zihan Xi wrote:
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

many thanks for the report and the reproducer!

The problem is known and on my list, as CAN_BCM needs some more work
after the pending "can: protect the receive lists with a per-device
lock" series. But I don't think the proposed patch is the right fix:

1. A per-socket limit does not bound the memory consumption. A process
    can open RLIMIT_NOFILE sockets and fork. With 16 MiB per socket
    around 100 sockets are enough to bring your 2 GB guest into OOM
    again - the PoC just needs an additional loop.

2. TX operations are not covered. bcm_tx_setup() allocates up to
    256 * 72 bytes per op in the same unbounded way, which only requires
    an existing CAN interface.

3. The hard-coded limits can break existing applications. 1024 RX ops
    per socket is not unrealistic, e.g. when monitoring all 2048 SFF CAN
    IDs individually. Such applications would get -ENOBUFS without a
    possibility to adjust the limit.

4. can_rx_register_with_release() extends the CAN core API and adds a
    pointer to every struct receiver of all CAN protocols, while each RX
    op has exactly one receiver anyway. This is quite invasive for
    stable and conflicts with the pending series.

A patch that enables memcg accounting is already in the works:
GFP_KERNEL_ACCOUNT for the bcm_op structures and their frame arrays
(RX and TX) and SLAB_ACCOUNT for the rcv_cache in af_can.c.

IMO this is the better solution, as

- the memory is charged to the cgroup of the allocating process, so
   the cgroup limits apply and the OOM killer is not left with kernel
   memory it can not attribute to anyone,
- it covers all sockets and processes of a cgroup and can not be
   bypassed by opening more sockets,
- it covers RX and TX ops and the receivers of all CAN protocols,
- it introduces no hard-coded limits, no ABI change and no new core
   API, and only changes a few lines, which makes it easy to backport.

This is also the established approach for other allocations in the
kernel that can be triggered by unprivileged users.

Best regards,
Oliver

> 
> Fixes: ffd980f976e7 ("[CAN]: Add broadcast manager (bcm) protocol")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://bugtracker.nebusec.ai/f/11134
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> ---
>   include/linux/can/core.h |   7 +++
>   net/can/af_can.c         |  34 +++++++++-
>   net/can/af_can.h         |   1 +
>   net/can/bcm.c            | 131 ++++++++++++++++++++++++++++++++-------
>   4 files changed, 147 insertions(+), 26 deletions(-)
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
> index 3d637a1e0ac1..96d3f050dec5 100644
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
> @@ -1425,26 +1518,22 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>   		op->nframes = msg_head->nframes;
>   		op->cfsiz = CFSIZ(msg_head->flags);
>   		op->flags = msg_head->flags;
> +		op->rx_mem = rx_mem;
>   
>   		if (msg_head->nframes > 1) {
>   			/* create array for CAN frames and copy the data */
>   			op->frames = kmalloc_array(msg_head->nframes,
>   						   op->cfsiz,
>   						   GFP_KERNEL);
> -			if (!op->frames) {
> -				kfree(op);
> -				return -ENOMEM;
> -			}
> +			if (!op->frames)
> +				goto free_op;
>   
>   			/* create and init array for received CAN frames */
>   			op->last_frames = kcalloc(msg_head->nframes,
>   						  op->cfsiz,
>   						  GFP_KERNEL);
> -			if (!op->last_frames) {
> -				kfree(op->frames);
> -				kfree(op);
> -				return -ENOMEM;
> -			}
> +			if (!op->last_frames)
> +				goto free_op;
>   
>   		} else {
>   			op->frames = &op->sframe;
> @@ -1532,11 +1621,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
> @@ -1558,9 +1643,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
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
> @@ -1593,6 +1676,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
>   	if (op->last_frames != &op->last_sframe)
>   		kfree(op->last_frames);
>   	kfree(op);
> +	bcm_rx_op_uncharge(bo, rx_mem);
>   	return err;
>   }
>   
> @@ -1896,6 +1980,7 @@ static int bcm_init(struct sock *sk)
>   	bo->ifindex          = 0;
>   	bo->dropped_usr_msgs = 0;
>   	bo->bcm_proc_read    = NULL;
> +	atomic_set(&bo->rx_receiver_count, 0);
>   
>   	INIT_LIST_HEAD(&bo->tx_ops);
>   	INIT_LIST_HEAD(&bo->rx_ops);

