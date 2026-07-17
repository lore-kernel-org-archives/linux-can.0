Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B643F0A9
	for <linux-can@vger.kernel.org>; Fri, 17 Jul 2026 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306762; cv=none; b=Q9KYZy26FtuwM/LPRcln1J3lNuN+YwGjxBNGeMqM6XIt1VTm9chzgn2u2/6BdpJ7DplK4Qi7zBoDa6ygi4iIiIKRtMZO5OA5gYm06jeAywz5kXDyxxQABWFklsB1msTD13tGuNpLCiHBfns7po4RhYbly640eCSBCFg/IpP8M9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306762; c=relaxed/simple;
	bh=CuwklEoSccXczFteuIe7rkdBaWFGmwwRU5gKqbxTEnU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bzto7cesWikIh3V4t3L4Rv7WVRwLhnvKwxsbhkiq/j3qHScSUanOl+tpu7JcV6g6DqJ2LceDDUh4BG+NspE0qicwq3Rr4waOhDkup7a5XpqXw7gX9rEWFqyWjyQ6rP2CQxCCj0fvnjgjhPEEByOuXgCcMyzVDZ8xUXeH/5ylrbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KT374Rcm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KT374Rcm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD691F00A3A;
	Fri, 17 Jul 2026 16:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784306761;
	bh=AfUW7UbWdDntjS8FNgybMGGchw08UjB/kxxqWE7PYvc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KT374RcmyYMKoxlJ11Xz6YbOZTrdILAIkxYdIh2dDpHR01TxcD5izPRg/QEMd/wHj
	 kONEpK+iwT038b5MoKW9zTMQSZGRa2NH1Z0TSKCqJWVt3BXFVdyRf8HDUyOAkSLm94
	 vdCeaGkfv8aqla6Dlfzdm3yFt1S7Hri5OOghubd/F8ZRZI+Qy7wuIe0JLUL2X6wFWc
	 TnSRiJlA2yyepG8Gfw+Iyn2Wiru6ECzedp+EADL5XcvzlL1cUePP875cqjte/xHIB2
	 7fl9yh0hh77mZboia2cbWiQhBgxpClw60wQ/XhgLGj1y55dPyt7DzHaJwVqCIwbap7
	 0LBYndpkER/Rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 07/19] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260716155528.809908-8-mkl@pengutronix.de>
References: <20260716155528.809908-1-mkl@pengutronix.de>
 <20260716155528.809908-8-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 16:46:00 +0000
Message-Id: <20260717164600.EBD691F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] `bcm_delete_rx_op()` and `bcm_release()` silently skip unregis=
tering CAN receivers when `dev_get_by_index()` fails, leading to a leaked r=
eceiver and Use-After-Free.
- [High] Missing RCU protection and barrier for `bo->tx_ops` and `bo->rx_op=
s` list modifications.
- [High] Unprotected state modifications on CAN frames in the TX path causi=
ng a data race.
- [High] Unprotected state modifications on CAN frames in the RX path causi=
ng a data race.
- [Medium] Lockless reads of `bo->ifindex` contradict the patch's assumptio=
n and cause data races.
--

--- Patch [7]: [PATCH net 07/19] can: bcm: fix lockless bound/ifindex race =
and silent RX_SETUP failure ---
commit a163b4c749b944874d23ca2a810e83a4afdbe1b5
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure

This patch addresses a race condition between bcm_sendmsg and concurrent
bcm_notify or bcm_connect calls by moving the ifindex read under the
socket lock. It also fixes a bug where bcm_rx_setup would silently
return success if the target device disappeared concurrently.

Link: https://patch.msgid.link/20260714-bcm_fixes-v15-2-562f7e3e42da@hartko=
pp.net

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index bdf53241bd7b3..b612135b017d1 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1323,6 +1323,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
> =20
>  				op->rx_reg_dev =3D dev;
>  				dev_put(dev);
> +			} else {
> +				/* the requested device is gone - do not
> +				 * silently succeed without registering
> +				 */
> +				err =3D -ENODEV;
>  			}
> =20
>  		} else

[Severity: High]
This is a pre-existing issue, but does this code safely manage list updates
for the transmit and receive operations?

In bcm_rx_setup() and bcm_tx_setup(), the code uses the standard list_add()
function rather than list_add_rcu():

bcm_rx_setup() {
    ...
    list_add(&op->list, &bo->rx_ops);
}

This means there is no smp_store_release() barrier to ensure newly populated
fields of the bcm_op structure are visible before the node is linked.

Concurrently, bcm_proc_show() locklessly traverses bo->tx_ops using
list_for_each_entry() instead of the rcu variant:

bcm_proc_show() {
    ...
    list_for_each_entry(op, &bo->tx_ops, list) {

Could this data race cause a procfs reader to observe torn pointers or
uninitialized memory during traversal?

[Severity: High]
This is also a pre-existing issue, but is it safe to overwrite the
comparison frames directly from userspace?

In bcm_rx_setup(), op->frames is updated directly from process context:

bcm_rx_setup() {
    ...
    err =3D memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);

Since this can sleep, it cannot disable softirqs. Concurrently, CAN packet
reception can trigger bcm_rx_handler() in softirq (NAPI) context.

The handler locklessly compares the incoming frame against the actively
overwritten op->frames:

bcm_rx_handler() {
    ...
    if ((get_u64(op->frames, 0) & get_u64(rxframe, 0)) =3D=3D

Could this lead to incorrect filtering logic and misclassified or wrongly
accepted CAN frames?

[ ... ]
> @@ -1396,12 +1401,13 @@ static int bcm_sendmsg(struct socket *sock, struc=
t msghdr *msg, size_t size)
[ ... ]
> -	lock_sock(sk);
> -
>  	switch (msg_head.opcode) {
> =20
>  	case TX_SETUP:

[Severity: High]
This is a pre-existing issue, but does this code protect the CAN frames
against concurrent transmission?

When bcm_sendmsg() calls bcm_tx_setup(), it directly modifies the
op->frames buffer from userspace:

bcm_tx_setup() {
    ...
    err =3D memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);

Because copying from userspace can sleep, this happens without holding the
bcm_tx_lock spinlock. Concurrently, the transmission timer can fire and
invoke bcm_can_tx(), which computes a pointer to op->frames while holding
the lock, but drops the lock before calling skb_put_data():

bcm_can_tx() {
    ...
    skb_put_data(skb, cf, op->cfsiz);

Can this race condition result in partially updated or torn CAN frames
being transmitted on the CAN bus?

[ ... ]
> @@ -1535,7 +1564,12 @@ static void bcm_notify(struct bcm_sock *bo, unsign=
ed long msg,
>  				bo->bcm_proc_read =3D NULL;
>  			}
>  #endif
> -			bo->bound   =3D 0;
> +			/* Paired with the lockless fast-path check in
> +			 * bcm_sendmsg(); bo->ifindex itself is only ever
> +			 * accessed under lock_sock() so it needs no
> +			 * annotation.
> +			 */

[Severity: Medium]
Is this comment accurate?

The comment states bo->ifindex is only ever accessed under lock_sock(),
which justifies skipping memory barriers for lockless fast-path accesses.

However, bcm_notify() reads it locklessly when handling a NETDEV_DOWN
event:

bcm_notify() {
    ...
    if (bo->bound && bo->ifindex =3D=3D dev->ifindex) {

And bcm_proc_show() also reads bo->ifindex locklessly for procfs output
generation:

bcm_proc_show() {
    ...
    seq_printf(m, " / bound %s", bcm_proc_getifname(net, ifname, bo->ifinde=
x));

Because bcm_connect() uses WRITE_ONCE(bo->bound, 1) without a paired CPU
memory barrier for bo->ifindex, couldn't concurrent paths observe an
inconsistent torn state?

> +			WRITE_ONCE(bo->bound, 0);
>  			bo->ifindex =3D 0;
>  			notify_enodev =3D 1;
>  		}
> @@ -1676,7 +1710,7 @@ static int bcm_release(struct socket *sock)
> =20
>  	/* remove device reference */
>  	if (bo->bound) {
> -		bo->bound   =3D 0;
> +		WRITE_ONCE(bo->bound, 0);
>  		bo->ifindex =3D 0;
>  	}

[Severity: Critical]
This isn't a bug introduced by this patch, but could this teardown path
skip unregistering CAN receivers and cause a use-after-free?

When a network device is unregistered, it is removed from the network
namespace index before the NETDEV_UNREGISTER notifiers run. If a socket
is closed during this exact window, dev_get_by_index() fails and returns
NULL:

bcm_release() {
    ...
    dev =3D dev_get_by_index(net, op->ifindex);
    if (dev) {
        bcm_rx_unreg(dev, op);
        dev_put(dev);
    }

As a result, bcm_rx_unreg() is silently skipped, but the bcm_op is
removed from bo->rx_ops and freed via RCU. The bcm_rx_handler remains
registered in the CAN core pointing to the freed memory.

A similar issue exists in bcm_delete_rx_op(). Could a subsequent packet
reception trigger the handler and corrupt memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716155528.8099=
08-1-mkl@pengutronix.de?part=3D7
