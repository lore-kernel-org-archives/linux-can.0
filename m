Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E514152ED46
	for <linux-can@vger.kernel.org>; Tue,  8 Sep 2026 11:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867303; cv=none; b=FeE8skyG+dvz12lpL8EHJwdLlRT5Xz4vyaUSr+XMTUM0cMVQbMTW484C/GcsjyvQp3yaAqArFJQuxIZrvH5yHepiqlmOkLK6isdO9QGlYEi6vFYID6zCQNyqMhdhpQnEYnWBio368A0pOfotcSl7sKt9Ajv5jBnNacI4/W25iYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867303; c=relaxed/simple;
	bh=JToy/Km8EndxNdAEJzv+2M22OGQ/FcJnHAIEaUAliaI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QF/Ue9qRZSITt/Ld5zmCi4daS+oOH4+y7VIsb1sNOSITwD2Tas7ESv6TnG7NiVQg8VlR4p4YLQmN0G76dJoA8xlsfDQiBZiMftPCj9F1uV9nhsRNLOqFF0fGs4bv1BAkhN4z/s2S6Zok0D2i6hAxjKA/1Eo826FhPoalx7UJf5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=MCyRWiUt; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="MCyRWiUt"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c247f6687dcso722871266b.2
        for <linux-can@vger.kernel.org>; Tue, 08 Sep 2026 04:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1788867291; x=1789472091; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=90T6cKVFwVsPE7lQSmkT6L8DygTtRW1/3+0qAhIa74c=;
        b=MCyRWiUt6CDoreKC1ylTIvNHS/p2UlaiIN/mFY4OzGy1xckf/kY8SPAZ42iU6uTpT3
         SDrcB5LRbtx9drZYIDZCUtH3KURo8ojOclc3Dvv9XjgxuSYpplEQ11fowN9x8hcffVdE
         G4d3Rm3i3NIhEPrMt7ujcWu/V6ewWIZQFpsBMJuz5eK6Y9xLhoxIIXjL/of4QLNgFHgw
         KV9VWGIkuYljv75eQBT0UIfRog75j5b57Vpsmhd4Ks74YoQrHvnvGHrorPS2lkcXK0P3
         0HwVFJid5jTkuWO3IEozU8TfvTU+0FBpzNFx35rCyrkVtKtW9aRUEfyaf3OJwMC+7eWW
         p6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788867291; x=1789472091;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=90T6cKVFwVsPE7lQSmkT6L8DygTtRW1/3+0qAhIa74c=;
        b=EH3oLmtnPj6F2BoKH+D0xiFbyR8MyDGqEZqwW6wB1zGXpIquGNaNVRn3kKnPwwhwBj
         SoS1XQVTrk6Ku5wQqgMgonE2b3mtD9md+iOlueVkyUNudAHpdvcwlW+OMwIE+g2J8K5o
         PBu7OtkmI1IuRnGFuTV26sshUBmN1QDQoJRLxjN+wmYZXqnBvFryQ+xgNqkv5h1NirEz
         M6mkUyElBvwogukhjI2ZSaZTYDUUZ4oTlCL5RmuItXjACCWjEfMccpMd5VeM7LFZ961+
         qZyB/tQs7NQe3K8brxofPVIz/w3W7TGUvBQSxXzindkxL+hfZs+AJKEn9Y7/JHsIUMM/
         LJRA==
X-Gm-Message-State: AFuF++lRKklu9pXERNBujtMmhR1rhttL1AxvG7dk9Bj2EEdqVcGMMCyu
	WnpVa2xYjgLxslXWkpaF3mIpxFuI/+p8FIPycv71yeA3FmYJOy7PDVGawZGJMG2IgAcaPzdsAQ8
	Fy6SEBNQ=
X-Gm-Gg: AYBFou1nVILJWH8ERpCc1BfkLL+vN/HkbU89CObq2OaEzHvfFpG4jo1OOVJCn4mOore
	lOU0ZfgscIg89TD6FGRz5DI0lSdegJtJIUy347Tcd93rEulb4v3qhRdwEym7TehaxbFKAv/PT1s
	R/nmz5osO4PuffLdHctdeJimpIizMOaH7fqVmllUNTyNmRImIQJsDD9rF+qwdpj6Q1Y2gP9NMl3
	TtCjrP0wCPLpVBVwBzDk3IPvU+fb+RsafTf0Hxw9tMh0ymRpoCUxXt1N1k0ccJYqWfy4U/30X4u
	mISTlIG3o4im+309/u6ePm0uZp33kuMcqcEMLhTgli6gxmqHlmflw74+TKPJ1D2+B1vrybAnc9S
	gmJNsY33mnJbQTGfS1/z40B75h68/GYW6y/+Jdl/ycqk8+nIrHZTPhe5Ubc4pbQINIkAdjJ4DK0
	YBMDZR6FkJ+f6bhlw4kU40OX99V1/Kd9Nfby5TD+XOqnFOiPO0+Ph22gf1EqftWqpXoZxafAEoh
	xc3fryAFF6aZiCdaUmg3VaWB9j1Oq7Gt4XkFv7AYhDWwHS4RJk8
X-Received: by 2002:a17:907:6e8c:b0:c16:5cf0:3aff with SMTP id a640c23a62f3a-c260c9f8ac8mr1112926266b.18.1788867290994;
        Tue, 08 Sep 2026 04:34:50 -0700 (PDT)
Received: from smtpclient.apple (80.49.147.201.ipv4.supernova.orange.pl. [80.49.147.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d6dfad6sm598181666b.60.2026.09.08.04.34.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2026 04:34:50 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH v2] can: remove CAN filters independent from namespace
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <20260903065947.7718-1-socketcan@hartkopp.net>
Date: Tue, 8 Sep 2026 13:34:38 +0200
Cc: linux-can@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D4EEFE9E-284F-45F0-BF4E-39CFF7134E52@doyensec.com>
References: <20260903065947.7718-1-socketcan@hartkopp.net>
To: Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: Apple Mail (2.3864.700.51.1.1)

Hi Oliver,

many thanks for v2. I ran it on 7.3-rc2 with vcan and my reproducer no =
longer
triggers. The ifindex case is gone too, from another namespace I can no =
longer
touch a bound BCM socket.

Tested-by: Norbert Szetei <norbert@doyensec.com =
<mailto:norbert@doyensec.com>>

Thanks,
Norbert

> On Sep 3, 2026, at 8:59=E2=80=AFAM, Oliver Hartkopp =
<socketcan@hartkopp.net> wrote:
>=20
> When the devices namespace is changed the socket namespace and the =
device
> namespace might differ. The net_eq(dev_net(dev), sock_net(sk)) check =
in
> the CAN protocols netdev notifiers therefore led to skipping the =
required
> removal of the CAN filters from the (namespace changed) CAN devices.
>=20
> This patch removes the namespace equality check in the netdev =
notifiers for
> BCM, ISOTP and RAW sockets. Since the struct net_device pointer is =
globally
> unique, the notifier should always process the unregister event and =
remove
> the CAN filters if it matches the original socket's bound device =
pointer.
>=20
> In bcm.c netdevice comparisons were performed by checking the =
interface
> index (bo->ifindex and op->ifindex) which is not namespace-safe =
either.
> Introduce tracked netdevice pointers (bo->dev and op->tx_dev) for =
these
> referenced devices to enable namespace-save device comparisons.
> Additional put all bo->dev accesses in bcm_notify() under lock_sock().
>=20
> In isotp.c the two missing can_rx_unregister() calling sites are =
converted
> to use dev_net(dev) instead of sock_net(sk) to get the correct =
namespace.
>=20
> Fixes: 8e8cda6d737d ("can: initial support for network namespaces")
> Reported-by: Norbert Szetei <norbert@doyensec.com>
> Link: =
https://lore.kernel.org/linux-can/CEA6A38A-2646-4ADA-95B4-CBAE2F301A8E@doy=
ensec.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
> changes in v2:
> - re-introduce the net_eq() check for ANYDEV case handling of =
op->ifdetected
> - drop bo->dev reference tracking when procfs initialization fails
> - add error handling for dev_get_by_index() of tx_dev in =
bcm_tx_setup()
> - put all bo->dev accesses in bcm_notify() under lock_sock()
> ---
> net/can/bcm.c   | 100 ++++++++++++++++++++++++++++++++++++------------
> net/can/isotp.c |   7 +---
> net/can/raw.c   |   3 --
> 3 files changed, 78 insertions(+), 32 deletions(-)
>=20
> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 3d637a1e0ac1..cd3522ec32c0 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -128,18 +128,22 @@ struct bcm_op {
> struct canfd_frame sframe;
> struct canfd_frame last_sframe;
> struct sock *sk;
> struct net_device *rx_reg_dev;
> netdevice_tracker rx_reg_dev_tracker;
> + struct net_device *tx_dev;
> + netdevice_tracker tx_dev_tracker;
> spinlock_t bcm_tx_lock; /* protect tx data and timer updates */
> spinlock_t bcm_rx_update_lock; /* protect filter/timer data updates */
> };
>=20
> struct bcm_sock {
> struct sock sk;
> int bound;
> int ifindex;
> + struct net_device *dev;
> + netdevice_tracker dev_tracker;
> struct list_head notifier;
> struct list_head rx_ops;
> struct list_head tx_ops;
> unsigned long dropped_usr_msgs;
> struct proc_dir_entry *bcm_proc_read;
> @@ -933,10 +937,13 @@ static void bcm_free_op_work(struct work_struct =
*work)
> kfree(op->frames);
>=20
> if ((op->last_frames) && (op->last_frames !=3D &op->last_sframe))
> kfree(op->last_frames);
>=20
> + if (op->tx_dev)
> + netdev_put(op->tx_dev, &op->tx_dev_tracker);
> +
> /* the last possible access to op->timer/op->thrtimer has now
> * happened above via hrtimer_cancel() - op->sk is no longer
> * needed by any pending timer callback, so drop our reference
> */
> sock_put(op->sk);
> @@ -1072,10 +1079,11 @@ static int bcm_tx_setup(struct bcm_msg_head =
*msg_head, struct msghdr *msg,
> int ifindex, struct sock *sk)
> {
> struct bcm_sock *bo =3D bcm_sk(sk);
> struct bcm_op *op;
> struct canfd_frame *cf;
> + struct net_device *tx_dev;
> bool add_op_to_list =3D false;
> unsigned int i;
> int err;
>=20
> /* we need a real device to send frames */
> @@ -1103,10 +1111,26 @@ static int bcm_tx_setup(struct bcm_msg_head =
*msg_head, struct msghdr *msg,
> * therefore (complexity / locking) it is not supported.
> */
> if (msg_head->nframes > op->nframes)
> return -E2BIG;
>=20
> + /* Re-resolve and re-hold the target device if a concurrent
> + * NETDEV_UNREGISTER already cleared it (see bcm_notify()).
> + * op->ifindex and sock_net(sk) is unchanged.
> + */
> + if (!op->tx_dev) {
> + tx_dev =3D dev_get_by_index(sock_net(sk), ifindex);
> + if (tx_dev) {
> + op->tx_dev =3D tx_dev;
> + netdev_hold(tx_dev, &op->tx_dev_tracker,
> +    GFP_KERNEL);
> + dev_put(tx_dev);
> + } else {
> + return -ENODEV;
> + }
> + }
> +
> /* get new CAN frames content into a staging buffer before
> * locking: validate and normalize the frames there so that
> * bcm_can_tx() / bcm_tx_timeout_handler() never observe a
> * partially updated or unvalidated frame in op->frames
> */
> @@ -1169,10 +1193,22 @@ static int bcm_tx_setup(struct bcm_msg_head =
*msg_head, struct msghdr *msg,
>=20
> op =3D kzalloc(OPSIZ, GFP_KERNEL);
> if (!op)
> return -ENOMEM;
>=20
> + tx_dev =3D dev_get_by_index(sock_net(sk), ifindex);
> + if (tx_dev) {
> + op->tx_dev =3D tx_dev;
> + netdev_hold(tx_dev, &op->tx_dev_tracker, GFP_KERNEL);
> + dev_put(tx_dev);
> + } else {
> + /* prepare op->frames for goto free_op */
> + op->frames =3D &op->sframe;
> + err =3D -ENODEV;
> + goto free_op;
> + }
> +
> spin_lock_init(&op->bcm_tx_lock);
> op->can_id =3D msg_head->can_id;
> op->cfsiz =3D CFSIZ(msg_head->flags);
> op->flags =3D msg_head->flags;
> op->nframes =3D msg_head->nframes;
> @@ -1184,12 +1220,14 @@ static int bcm_tx_setup(struct bcm_msg_head =
*msg_head, struct msghdr *msg,
> if (msg_head->nframes > 1) {
> op->frames =3D kmalloc_array(msg_head->nframes,
>   op->cfsiz,
>   GFP_KERNEL);
> if (!op->frames) {
> - kfree(op);
> - return -ENOMEM;
> + /* prepare op->frames for goto free_op */
> + op->frames =3D &op->sframe;
> + err =3D -ENOMEM;
> + goto free_op;
> }
> } else
> op->frames =3D &op->sframe;
>=20
> for (i =3D 0; i < msg_head->nframes; i++) {
> @@ -1267,10 +1305,13 @@ static int bcm_tx_setup(struct bcm_msg_head =
*msg_head, struct msghdr *msg,
> bcm_tx_start_timer(op);
>=20
> return msg_head->nframes * op->cfsiz + MHSIZ;
>=20
> free_op:
> + if (op->tx_dev)
> + netdev_put(op->tx_dev, &op->tx_dev_tracker);
> +
> if (op->frames !=3D &op->sframe)
> kfree(op->frames);
> kfree(op);
> return err;
> }
> @@ -1790,46 +1831,47 @@ static int bcm_sendmsg(struct socket *sock, =
struct msghdr *msg, size_t size)
> static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
>       struct net_device *dev)
> {
> struct sock *sk =3D &bo->sk;
> struct bcm_op *op;
> - int notify_enodev =3D 0;
> + int sk_err =3D 0;
>=20
> - if (!net_eq(dev_net(dev), sock_net(sk)))
> - return;
> + lock_sock(sk);
>=20
> switch (msg) {
>=20
> case NETDEV_UNREGISTER:
> - lock_sock(sk);
>=20
> /* rx_ops: remove device specific receive entries */
> list_for_each_entry(op, &bo->rx_ops, list) {
> if (op->rx_reg_dev =3D=3D dev)
> bcm_rx_unreg(dev, op);
>=20
> /* release an ANYDEV op's claim (see bcm_rx_handler())
> * on this now confirmed-gone interface.
> */
> - if (!op->ifindex) {
> + if (!op->ifindex && net_eq(dev_net(dev), sock_net(sk))) {
> spin_lock_bh(&op->bcm_rx_update_lock);
> if (op->if_detected =3D=3D dev->ifindex)
> op->if_detected =3D 0;
> spin_unlock_bh(&op->bcm_rx_update_lock);
> }
> }
>=20
> /* tx_ops: stop device specific cyclic transmissions on the
> - * vanishing ifindex. Cancelling the timer is enough to stop
> + * vanishing device. Cancelling the timer is enough to stop
> * cyclic bcm_can_tx() calls as there is no re-arming.
> */
> list_for_each_entry(op, &bo->tx_ops, list)
> - if (op->ifindex =3D=3D dev->ifindex)
> + if (op->tx_dev =3D=3D dev) {
> hrtimer_cancel(&op->timer);
> + netdev_put(op->tx_dev, &op->tx_dev_tracker);
> + op->tx_dev =3D NULL;
> + }
>=20
> /* remove device reference, if this is our bound device */
> - if (bo->bound && bo->ifindex =3D=3D dev->ifindex) {
> + if (bo->bound && bo->dev =3D=3D dev) {
> #if IS_ENABLED(CONFIG_PROC_FS)
> if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read) {
> remove_proc_entry(bo->procname, sock_net(sk)->can.bcmproc_dir);
> bo->bcm_proc_read =3D NULL;
> }
> @@ -1839,28 +1881,27 @@ static void bcm_notify(struct bcm_sock *bo, =
unsigned long msg,
> * accessed under lock_sock() so it needs no
> * annotation.
> */
> WRITE_ONCE(bo->bound, 0);
> bo->ifindex =3D 0;
> - notify_enodev =3D 1;
> - }
> -
> - release_sock(sk);
> -
> - if (notify_enodev) {
> - sk->sk_err =3D ENODEV;
> - if (!sock_flag(sk, SOCK_DEAD))
> - sk_error_report(sk);
> + netdev_put(bo->dev, &bo->dev_tracker);
> + bo->dev =3D NULL;
> + sk_err =3D ENODEV;
> }
> break;
>=20
> case NETDEV_DOWN:
> - if (bo->bound && bo->ifindex =3D=3D dev->ifindex) {
> - sk->sk_err =3D ENETDOWN;
> - if (!sock_flag(sk, SOCK_DEAD))
> - sk_error_report(sk);
> - }
> + if (bo->bound && bo->dev =3D=3D dev)
> + sk_err =3D ENETDOWN;
> + }
> +
> + release_sock(sk);
> +
> + if (sk_err) {
> + sk->sk_err =3D sk_err;
> + if (!sock_flag(sk, SOCK_DEAD))
> + sk_error_report(sk);
> }
> }
>=20
> static int bcm_notifier(struct notifier_block *nb, unsigned long msg,
> void *ptr)
> @@ -1982,10 +2023,14 @@ static int bcm_release(struct socket *sock)
>=20
> /* remove device reference */
> if (bo->bound) {
> WRITE_ONCE(bo->bound, 0);
> bo->ifindex =3D 0;
> + if (bo->dev) {
> + netdev_put(bo->dev, &bo->dev_tracker);
> + bo->dev =3D NULL;
> + }
> }
>=20
> sock_orphan(sk);
> sock->sk =3D NULL;
>=20
> @@ -2029,25 +2074,32 @@ static int bcm_connect(struct socket *sock, =
struct sockaddr_unsized *uaddr, int
> ret =3D -ENODEV;
> goto fail;
> }
>=20
> bo->ifindex =3D dev->ifindex;
> + bo->dev =3D dev;
> + netdev_hold(dev, &bo->dev_tracker, GFP_KERNEL);
> dev_put(dev);
>=20
> } else {
> /* no interface reference for ifindex =3D 0 ('any' CAN device) */
> bo->ifindex =3D 0;
> + bo->dev =3D NULL;
> }
>=20
> #if IS_ENABLED(CONFIG_PROC_FS)
> if (net->can.bcmproc_dir) {
> /* unique socket address as filename */
> sprintf(bo->procname, "%llu", sock_i_ino(sk));
> bo->bcm_proc_read =3D proc_create_net_single(bo->procname, 0644,
>     net->can.bcmproc_dir,
>     bcm_proc_show, sk);
> if (!bo->bcm_proc_read) {
> + if (bo->dev) {
> + netdev_put(bo->dev, &bo->dev_tracker);
> + bo->dev =3D NULL;
> + }
> ret =3D -ENOMEM;
> goto fail;
> }
> }
> #endif /* CONFIG_PROC_FS */
> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 155530aedce2..0835a4758a72 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1490,15 +1490,15 @@ static int isotp_release(struct socket *sock)
> /* remove current filters & unregister
> * tracked reference so->dev is taken at bind() time with rtnl_lock
> */
> if (so->bound && so->dev) {
> if (isotp_register_rxid(so))
> - can_rx_unregister(net, so->dev, so->rxid,
> + can_rx_unregister(dev_net(so->dev), so->dev, so->rxid,
>  SINGLE_MASK(so->rxid),
>  isotp_rcv, sk);
>=20
> - can_rx_unregister(net, so->dev, so->txid,
> + can_rx_unregister(dev_net(so->dev), so->dev, so->txid,
>  SINGLE_MASK(so->txid),
>  isotp_rcv_echo, sk);
> netdev_put(so->dev, &so->dev_tracker);
> }
>=20
> @@ -1846,13 +1846,10 @@ static int isotp_getsockopt(struct socket =
*sock, int level, int optname,
> static void isotp_notify(struct isotp_sock *so, unsigned long msg,
> struct net_device *dev)
> {
> struct sock *sk =3D &so->sk;
>=20
> - if (!net_eq(dev_net(dev), sock_net(sk)))
> - return;
> -
> if (so->dev !=3D dev)
> return;
>=20
> switch (msg) {
> case NETDEV_UNREGISTER:
> diff --git a/net/can/raw.c b/net/can/raw.c
> index 82d9c0499c95..c5596fc9aac5 100644
> --- a/net/can/raw.c
> +++ b/net/can/raw.c
> @@ -300,13 +300,10 @@ static int raw_enable_allfilters(struct net =
*net, struct net_device *dev,
> static void raw_notify(struct raw_sock *ro, unsigned long msg,
>       struct net_device *dev)
> {
> struct sock *sk =3D &ro->sk;
>=20
> - if (!net_eq(dev_net(dev), sock_net(sk)))
> - return;
> -
> if (ro->dev !=3D dev)
> return;
>=20
> switch (msg) {
> case NETDEV_UNREGISTER:
> --=20
> 2.53.0
>=20

