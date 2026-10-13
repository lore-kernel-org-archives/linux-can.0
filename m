Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE79412BF1
	for <linux-can@vger.kernel.org>; Tue, 13 Oct 2026 11:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889734; cv=pass; b=r2dQCZokVNWUA6ir5nGc5xt5gbygBObntqvugf9tiyOPMkAKtQxtaQSAZYT9x8yDc0/ImxC14dKN0ZJE6YC4N2OyaoJyXySLW0X1xJIFHhGpRjFnmcn09CKYPxazMVLWzRS3Zqr1YT3S8OPSiwNFw9yI9KbVKDV/5U31D6bUY4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889734; c=relaxed/simple;
	bh=0zozuLCPpvB27KzfRaLcmBUSy7UCMJJq1I8r/NTME9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ocy6eNUD7klb+JcnLTzU5gpmBkBPTDGQJzfAE7oJC0nNc/MsHp50wcb8ap2UCTMWxELiWG1IUYfbAKG3dh+IPwahAM2c2poQq3tQu99bRKj29j4MR85NXBavQHXtFYark7HiX7JxRJ6wKB60gM3vSwDk+2U5RLd/CKh/BHPhmk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BMU+680N; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=jTQMd1K9; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="BMU+680N";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="jTQMd1K9"
ARC-Seal: i=1; a=rsa-sha256; t=1791889727; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bAJCJOmyq1LO32SNsmFSWWwaCMstXnFj3jRxoHk1E0YRFU8rX0zN5MBNkGJkGeSuTM
    6OQFvPX7f1bxc5wZXG85B2ZaYnAzT8B7hYK+o8hfjdviGBtXZlgSR0eADw3b9ttEfNOA
    Q6Ceh+FQCUlqVwc0xIRNY6nXzeNfuQiz2RoatZk0v+knkhR/Puol5w9E2ZKfAEdIbyXT
    WpzpDO0yomvQkISNZDFuEfAuYBviNpqjgmYWkE/xXquP/Q7flGsDEsq8+Bg1P4YX5t6p
    2lvfUup7smB/IpJWw8RHRMUPBzaWM4kQBGxyjHJx5pqNSQ1mXxL8lorc08ltTJ0Lvf4K
    Seiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1791889727;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=nd1FJrGRlbokjurTJUiPE6wEhyvE+sklY9cV7RAZc4c=;
    b=Zt09+scb2Xr6upswWBISTxxtrhJBJutrm3nzzUJ3FC2R2/bQUH3fpoMLLJTJzrqh57
    37Ky2kRrbUugJooVR2jS1oLeUQbBh/BRMi7OfZBxO7D79X/QNJGp70l7rE3NwrkePcDq
    +MilFePs5fK76ioQ/xwmnLMjnyAxtdskvxVxnbyGmwkElNJB02l+sjEruGV2VdtUX1QT
    OyxwK8GZTkW7PbMFgyBdNCQ/3WeeCZnc5mLlQ1fzLQVWyS9ENKCaMUhiVW78e2aP0M+L
    TUN2fMerYXhJr1/uXXHaLiY698m/sfvN/Cy2OOeXJi+g9BHEfefbZ+BJFVjetqgMnfZg
    osMQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1791889727;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=nd1FJrGRlbokjurTJUiPE6wEhyvE+sklY9cV7RAZc4c=;
    b=BMU+680NsWV07HziDz5+aV3Lr3WYJKzwBz9knCDoUNWbae4nldJwmEsJeiwJaysDyq
    UhW6qpV7fv/jgwc+lUFbZQ503fygPagAtv+m6NwjKDLVhEgis9dsbfQEHryHZ9KV9A65
    Cx7/kYEtdF6Fo4ebKM+JroHt5ssOREeAJ8ftc1md/lu9kTwxwSIOOE5neV2dmhimbwLK
    FWtBLeTqDzxVxdMB9JHMaXobjNRlIg/rjBCRrMJfqEVyh7DdVxrvaR/NIKoQWVMu6CP5
    fmWYlV5XjrZLnpVb/otb+vqU3stStOtd/SYssCmyIpFV4j5djolUeVILCnJvHCviReRu
    NYBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1791889727;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=nd1FJrGRlbokjurTJUiPE6wEhyvE+sklY9cV7RAZc4c=;
    b=jTQMd1K9qRWOJk3bQ3kQvAL4OTbNaQBPoc4G/lBLNQiLbmnJl1/4Y4wqiAeh/rvPx4
    r5DdO9UJnLNxFrp668Dg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29DB8l5y2
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 13 Oct 2026 13:08:47 +0200 (CEST)
Message-ID: <99878bd4-a4f4-470e-a6df-373c30a48668@hartkopp.net>
Date: Tue, 13 Oct 2026 13:08:47 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] can: remove CAN filters independent from namespace
To: netdev-bot+sashiko@kernel.org
Cc: linux-can@vger.kernel.org, stable@kernel.org, o.rempel@pengutronix.de,
 kuba@kernel.org, Norbert Szetei <norbert@doyensec.com>
References: <20260929163424.16382-2-socketcan@hartkopp.net>
 <179100651478.1406898.6853696436813565877@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <179100651478.1406898.6853696436813565877@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I reworked and stripped this patch to only address the race which can 
indeed be fixed by moving rtnl_lock() as originally suggested by Norbert 
and Opus-5 ;-)

The new patch is reduced for stable here:

https://lore.kernel.org/linux-can/20261013105909.91715-1-socketcan@hartkopp.net/

Thanks Norbert and thanks for the review!

Best regards,
Oliver

On 03.10.26 07:48, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 2 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] bcm_release() (net/can/bcm.c) unregisters device-bound receive
>    filters without holding RTNL, so a concurrent namespace move can still…
> - [Medium] The commit message describes a failure that does not occur in
>    the notifier code.
> - [Medium] The patch removes the early net_eq() return in bcm_notify()
>    and moves lock_sock(sk) above the switch (net/can/bcm.c:1838).
> 
> --
> 
> can: remove CAN filters independent from namespace
> 
> This commit removes the net_eq() namespace check from the BCM, ISOTP and
> RAW netdev notifiers, so CAN filters are removed on NETDEV_UNREGISTER
> even when the device namespace differs from the socket namespace. In
> bcm.c it adds tracked net_device pointers (bo->dev, op->tx_dev) for
> device comparisons, and bcm_notify() now takes lock_sock() for every
> event. In isotp_release() the can_rx_unregister() calls now use
> dev_net(so->dev).
> 
> Link: https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doyensec.com/
> 
>> When the devices namespace is changed the socket namespace and the device
>> namespace might differ. The net_eq(dev_net(dev), sock_net(sk)) check in
>> the CAN protocols netdev notifiers therefore led to skipping the required
>> removal of the CAN filters from the (namespace changed) CAN devices.
> 
> [Severity: Medium]
> 
> Is this root cause accurate? In __dev_change_net_namespace(), the
> UNREGISTER notifiers run while dev_net(dev) still points to the old
> namespace:
> 
> net/core/dev.c:__dev_change_net_namespace() {
>      ...
> 	unlist_netdevice(dev);
>      ...
> 	call_netdevice_notifiers(NETDEV_UNREGISTER, dev);
>      ...
> 	netdev_lock(dev);
> 	dev_net_set(dev, net);
> 	netdev_unlock(dev);
> 	dev->ifindex = new_ifindex;
>      ...
> }
> 
> The bind and registration paths are raw_bind(), isotp_bind(),
> bcm_connect(), bcm_rx_setup() and bcm_sendmsg(). All of them look up
> the device with dev_get_by_index(sock_net(sk), ...). can_rx_register()
> also refuses a device from another namespace:
> 
> 	if (dev && !net_eq(net, dev_net(dev)))
> 		return -ENODEV;
> 
> For a socket with filters on the moved device, wouldn't the removed
> net_eq() check in raw_notify(), isotp_notify() and bcm_notify() have
> passed during the move?
> 
> No registration seems able to get in between either:
> 
> - raw and isotp register under rtnl.
> - bcm_rx_setup() runs under lock_sock(), which bcm_notify() also takes
>    for UNREGISTER.
> - Lookups fail after unlist_netdevice().
> 
> I couldn't find a path where the notifier sees a bound device in a
> foreign namespace.
> 
> The real bug this patch fixes looks like it is in isotp_release():
> 
> 1. The socket is unlinked from the notifier list.
> 2. A namespace move completes.
> 3. can_rx_unregister(sock_net(sk), so->dev, ...) returns early on its
>     own net_eq() check.
> 
> That is a race between release and the move, not the notifier check.
> 
> Could the commit message describe the path that was actually hit, or
> the reproducer from the report? The BCM rework, which is tagged for
> stable, is justified by this description.
> 
>> diff --git a/net/can/bcm.c b/net/can/bcm.c
>> index 3d637a1e0ac1a..cd3522ec32c0a 100644
>> --- a/net/can/bcm.c
>> +++ b/net/can/bcm.c
> 
> [ ... ]
> 
>> @@ -1792,15 +1833,13 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
>>   {
>>   	struct sock *sk = &bo->sk;
>>   	struct bcm_op *op;
>> -	int notify_enodev = 0;
>> +	int sk_err = 0;
>>   
>> -	if (!net_eq(dev_net(dev), sock_net(sk)))
>> -		return;
>> +	lock_sock(sk);
> 
> [Severity: Medium]
> 
> With the early return gone and lock_sock() moved above the switch,
> bcm_notifier() now takes the lock of every BCM socket in every
> namespace. It does this for every NETDEV_DOWN and NETDEV_UNREGISTER of
> any CAN device, while holding RTNL:
> 
> net/can/bcm.c:bcm_notifier() {
>      ...
> 	list_for_each_entry(bcm_busy_notifier, &bcm_notifier_list, notifier) {
> 		spin_unlock(&bcm_notifier_lock);
> 		bcm_notify(bcm_busy_notifier, msg, dev);
> 		spin_lock(&bcm_notifier_lock);
> 	}
>      ...
> }
> 
> Before this change, sockets in other namespaces returned immediately,
> and NETDEV_DOWN never took lock_sock().
> 
> bcm_sendmsg() holds lock_sock() across bcm_tx_setup(), bcm_rx_setup()
> and bcm_tx_send(), and these call memcpy_from_msg() on the user buffer.
> Suppose that buffer is on a FUSE-backed mmap that never answers the
> read. An unprivileged user in a user namespace can set this up. The
> copy then blocks with the socket lock held.
> 
> Can a CAN device event in an unrelated namespace then block in
> lock_sock() inside bcm_notify() with RTNL held? An example is "ip link
> set can0 down" in init_net. That would stall network configuration
> system-wide.
> 
> A similar stall was already possible for same-namespace UNREGISTER
> events. This change extends it to cross-namespace events and to
> NETDEV_DOWN. Later patches in this series don't appear to change this.
> 
> NETDEV_DOWN only needs the bo->dev == dev comparison, which
> raw_notify() and isotp_notify() already do without the socket lock.
> Would a lockless check, before lock_sock(), of whether this socket
> references dev at all avoid this?
> 
>>   
>>   	switch (msg) {
> 
> [ ... ]
> 
>> @@ -1984,6 +2025,10 @@ static int bcm_release(struct socket *sock)
>>   	if (bo->bound) {
>>   		WRITE_ONCE(bo->bound, 0);
>>   		bo->ifindex = 0;
>> +		if (bo->dev) {
>> +			netdev_put(bo->dev, &bo->dev_tracker);
>> +			bo->dev = NULL;
>> +		}
>>   	}
>>   
>>   	sock_orphan(sk);
> 
> [Severity: High]
> 
> Does bcm_release() still have the same window between release and a
> namespace move that this patch closes for isotp?
> 
> bcm_release() removes the socket from bcm_notifier_list and then takes
> only lock_sock(). Unlike raw_release() and isotp_release(), it does not
> take rtnl_lock():
> 
> net/can/bcm.c:bcm_release() {
>      ...
> 	list_del(&bo->notifier);
> 	spin_unlock(&bcm_notifier_lock);
> 
> 	lock_sock(sk);
>      ...
> 			if (op->rx_reg_dev)
> 				bcm_rx_unreg(op->rx_reg_dev, op);
>      ...
> }
> 
> The list_del() can happen before a concurrent move's UNREGISTER walk
> reaches this socket. In that case bcm_notify() never runs for it, and
> op->rx_reg_dev stays set.
> 
> bcm_rx_unreg() then reads dev_net(dev) without RTNL, and
> can_rx_unregister() reads it a second time:
> 
> net/can/bcm.c:bcm_rx_unreg() {
> 	if (op->rx_reg_dev == dev) {
> 		can_rx_unregister(dev_net(dev), dev, op->can_id,
> 				  REGMASK(op->can_id), bcm_rx_handler, op);
> 
> 		/* mark as removed subscription */
> 		op->rx_reg_dev = NULL;
> 		netdev_put(dev, &op->rx_reg_dev_tracker);
>      ...
> }
> 
> net/can/af_can.c:can_rx_unregister() {
>      ...
> 	if (dev && !net_eq(net, dev_net(dev)))
> 		return;
>      ...
> }
> 
> The concurrent writer is dev_net_set() in __dev_change_net_namespace(),
> which runs under RTNL and netdev_lock().
> 
> Say the argument is sampled as the old namespace and dev_net_set() runs
> before the net_eq() check. can_rx_unregister() then returns without
> unlinking anything. bcm_rx_unreg() still clears op->rx_reg_dev, and
> bcm_remove_op() later frees op.
> 
> Can the next frame received on the device in the new namespace then
> call bcm_rx_handler() with the freed op?
> 
> Now say the check passes instead. hlist_del_rcu() runs under the old
> namespace's rcvlists_lock, while code in the new namespace may modify
> the same per-device list under its own lock.
> 
> Could this corrupt the receive list?
> 
> The isotp_release() change to dev_net(so->dev) in this patch relies on
> rtnl_lock() being held there. This window existed before this patch,
> and later patches in this series don't appear to change bcm_release().
> 
> For the BCM part of this fix to be complete, does bcm_release() need
> rtnl_lock() around the unregister step, as raw_release() and
> isotp_release() take?
> 

