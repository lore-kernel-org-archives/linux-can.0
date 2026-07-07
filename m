Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5E934A3A5
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783448173; cv=none; b=pWI4zqh4GfeYPhK+2BHNpb69Xo3DBYRrEf+gZEqpNCmr681v/oGWxTowW4P6U6xdsy6os2dg68gPaWOVcFWVKez/OudvpceFqBAzhlQyxUd5xjK+uxr0xvlItQAey0j+Q/UXIFRVZpPR3+FWWpoUB7lv+55Be3/Ltlvc7x1sT1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783448173; c=relaxed/simple;
	bh=KJbA9XPl5SLVoKXg4301qV01xBLNBX8L8Bg36pfvVuc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RwKJzlaLkfsa47C2H6soN5sUSg/Wq0Bhw9pgd1Dsa8MfR8TazYuoe/JDkdQ5w/GpkP9WHfdv17l+cKmyfCWRt7LCGctKGV5PnTeEW1zKE7i4ohzlY2Z+fdX8rZZe3fTTnfjgnVuRtmGA3oYjKBosLsgcR7SNCwhc1oG2lCB/iwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj5dssK1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj5dssK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0DD1F000E9;
	Tue,  7 Jul 2026 18:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783448171;
	bh=JcXCxSrMQ/ses1n6nOvyswE97ybTdaP0bHInqWIrVQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nj5dssK1XEoS25YJkOEUOKIsC9FePZdTI7G+irSu9W2Q8nkbd1whwkS9BbxVp0KIu
	 lKn0eYE901BGxHTMHmY3tLa9v/NETwO7Cbt/Betbhh0zNGxdLutygcg6vATXyaj+4L
	 ypkY36xdbhSJQbm3C5AgYEHB96qC/kSWL3NUZi9xuKuFLjImW9F/Jw025q1j3Qp+sN
	 fcUOq6gVLL1B2zPYtnFxBjzYliqhl/MlvZko/eocAbz2c7/t0fI1EGWngroA30VCpk
	 T1FGoapDJSNOPEmsEL3iPNWddAyan/Xl+oYRjI7eOBaZXeCRsEp/ivZOIAmI5QtN5O
	 ck17gYmncslUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/8] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260707-bcm_fixes-v5-2-c3c74f8d8ff7@hartkopp.net>
References: <20260707-bcm_fixes-v5-0-c3c74f8d8ff7@hartkopp.net>
 <20260707-bcm_fixes-v5-2-c3c74f8d8ff7@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 18:16:11 +0000
Message-Id: <20260707181611.7E0DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded kernel memory allocation in BCM RX_SETUP and TX_SETUP ha=
ndlers.
- [High] Missing RCU list primitives causes data races and memory ordering =
vulnerabilities for `rx_ops` and `tx_ops`.
- [High] Data races and state corruption due to unprotected direct copy int=
o active CAN frame arrays.
- [High] Device unregistration race in `bcm_delete_rx_op` causes netdevice =
leak and Use-After-Free.
--

--- Patch [2]: [PATCH v5 2/8] can: bcm: fix lockless bound/ifindex race and=
 silent RX_SETUP failure ---
commit 055258653f72b3386825203a828327e5ab3630d0
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure

This commit fixes a race condition where bcm_sendmsg() locklessly reads
interface indices while other functions mutate them under lock. It moves
these checks under the socket lock to ensure consistency. It also fixes a
silent success return in bcm_rx_setup() when the target device concurrently
disappears.

Link: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_p=
V3At4g=3Dh1kVEtyhA@mail.gmail.com/

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

[Severity: High]
This is a pre-existing issue, but does this allocation lack socket memory
limits?

When allocating the operation structure and frame array in bcm_rx_setup()
and bcm_tx_setup():

op =3D kzalloc(OPSIZ, GFP_KERNEL);
...
op->frames =3D kmalloc_array(msg_head->nframes, op->cfsiz, GFP_KERNEL);

Could an unprivileged user exhaust kernel memory by creating a CAN BCM sock=
et
and repeatedly sending RX_SETUP or TX_SETUP messages with unique can_id val=
ues,
since these allocations are not accounted against sk_omem_alloc or
sk_wmem_alloc?

[Severity: High]
This is a pre-existing issue, but is there a data race when updating frames?

In bcm_rx_setup() and bcm_tx_setup(), incoming frame data is copied directly
into the active op->frames array without holding a lock to protect the buff=
ers:

err =3D memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);

Could the cyclic timeout handlers call bcm_can_tx() and read from op->frames
locklessly while this copy is happening?

This might allow bcm_can_tx() to read and process torn or partially-updated
CAN frames, potentially leading to out-of-bounds reads in drivers if frame
lengths are corrupted.

[ ... ]

> @@ -1436,20 +1463,21 @@ static int bcm_sendmsg(struct socket *sock, struc=
t msghdr *msg, size_t size)
[ ... ]
>  	switch (msg_head.opcode) {
> =20
>  	case TX_SETUP:

[Severity: High]
This is a pre-existing issue, but do the rx_ops and tx_ops list modificatio=
ns
need RCU memory barriers?

In bcm_rx_setup() and bcm_tx_setup(), operations are inserted into the list=
s.
While rx_ops uses list_add_rcu() in some places, tx_ops uses the standard
list_add():

list_add(&op->list, &bo->tx_ops);

Readers such as bcm_proc_show() iterate over these lists locklessly under
rcu_read_lock():

list_for_each_entry(op, &bo->tx_ops, list) {

Could this cause data races on weakly-ordered architectures where the CPU
reorders the initialization of the new node's pointers to occur after it
becomes visible in the list?

[Severity: High]
This is a pre-existing issue, but does bcm_delete_rx_op() leak device
references?

When userspace removes an RX operation via bcm_delete_rx_op(), it validates
the device by calling dev_get_by_index(). If the device is concurrently
unregistering, it returns NULL:

dev =3D dev_get_by_index(sock_net(op->sk), op->ifindex);
if (dev) {
        bcm_rx_unreg(dev, op);
        dev_put(dev);
}

If dev is NULL, bcm_rx_unreg() is skipped but the op is freed anyway.

Since the op is removed from bo->rx_ops, a subsequent NETDEV_UNREGISTER
event in bcm_notify() will not find it either.

Does this leave the bcm_rx_handler permanently registered to a freed op
structure?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v5-0-c3c74f8d8ff7@hartkopp.net?part=3D2
