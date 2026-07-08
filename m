Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B93F6C4E
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503829; cv=none; b=avPLXZq1sjudUIKzdULmBSWE03cg0azE44ZV/YjdXHVYI81z/RBunG5WWKjYtb2FJrzUxkicZakknHw6hRzI1octaqr1ST3hDTc2vuiX8DsYS575+GbUuyBf6JqzYp81VRh3lNAE8//kmTQgWuthelzx2ubRh0+TU8B806xmRts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503829; c=relaxed/simple;
	bh=k7K8Xx9fNCzL2B4VndgGS/O2lXFgK0wNR1Qfc8nnFfk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xu0+SDyEEP61rbESDK7WJeKWqKadR08cPg5FIWT1rZT4EK5nW8sjymzYfKWX6q42qvvIMKfEDHgFEFi3DVfD+CKdL2asiNc/EfHQsd8SvR3V12q+2szB3FeS09kItHh1qyIc8oTFvrQ7YOyl9ZESNfoiCL6AnFemOwkp4t+AaiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZepULd3h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZepULd3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7391F000E9;
	Wed,  8 Jul 2026 09:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783503828;
	bh=Y99FsQm2QCkmGboYSNbsSAYVRqztIArAhSkAkoZO19o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZepULd3hTB42eFRr0XZxhOEmbco/CPMB4vB3p3kpZZAOaN08fwZZLmiR7xdMz47Cf
	 FEGNlEHaI5MVl+wKElT/qcdVjUdCR3+RCnq1fWkeA6gCpTA2tCQFwbZHzWOOV/BK9v
	 JmMuuVPyDATKqVRjxKS7U5qk7JS4q8N3jP/rWv4dwLhe00lsp2xIwHJRI6pZibzDRX
	 m7C9ZmqIvbSYP5z9OE/5wY69K1O07LKTbD7HXppImVfk1Ckchx/4x9eo0OyXRhEqd4
	 +W0fDP54WbJst6B+g3PRSwvvRh8hD0Sptw9K9kBDyPXtu3YzKZcbwu3iIAD99psfFI
	 80yNEkqi03U6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/9] can: bcm: add missing rcu list annotations and
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260708-bcm_fixes-v6-5-80710a2bc398@hartkopp.net>
References: <20260708-bcm_fixes-v6-0-80710a2bc398@hartkopp.net>
 <20260708-bcm_fixes-v6-5-80710a2bc398@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 09:43:47 +0000
Message-Id: <20260708094347.AD7391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] bcm_tx_setup() updates CAN frames directly in the active op->f=
rames buffer without locking and before validation, allowing a concurrent t=
imer to transmit unvalidated, malformed frames.
- [Medium] bcm_tx_setup() updates 64-bit ktime_t timer variables without lo=
cking, risking torn reads on 32-bit systems.
- [Medium] Memory leak of CAN receiver object due to race between bcm_delet=
e_rx_op() and NETDEV_UNREGISTER.
--

--- Patch [5]: [PATCH v6 5/9] can: bcm: add missing rcu list annotations an=
d operations ---
commit f371f28179652ae60b7b0cd6b25f7f33429dc82a
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add missing rcu list annotations and operations

This patch fixes missing list_add_rcu() calls in bcm_tx_setup() and
bcm_rx_setup() by moving them to the end of the setup code. It also fixes
bcm_release() to properly call list_del_rcu() before bcm_remove_op() when
removing operations.

Link: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 340b7fc89744e..fca7c714cc52f 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -999,6 +999,7 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head=
, struct msghdr *msg,
>  	struct bcm_sock *bo =3D bcm_sk(sk);
>  	struct bcm_op *op;
>  	struct canfd_frame *cf;
> +	bool add_op_to_list =3D false;
>  	unsigned int i;
>  	int err;

[Severity: Critical]
This is a pre-existing issue, but does bcm_tx_setup() update CAN frames
directly in the active op->frames buffer without locking and before
validation?

When updating an existing TX operation, user data is copied directly into
op->frames without holding bcm_tx_lock:

	err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);
	if (op->flags & CAN_FD_FRAME) {
		if (cf->len > 64)
			err =3D -EINVAL;

Since the operation is already active, a concurrent bcm_tx_timeout_handler()
could trigger and call bcm_can_tx(). The timer handler acquires bcm_tx_lock,
copies the torn/unvalidated frame, and transmits it:

	memcpy(&cframe, op->frames + op->cfsiz * op->currframe, op->cfsiz);
	cf =3D &cframe;

If an unprivileged user provides an invalid length, could
bcm_tx_timeout_handler() transmit it before bcm_tx_setup() rejects it,
leading to an out-of-bounds read of the kernel skb?

[Severity: Medium]
This is also a pre-existing issue, but are the 64-bit ktime_t timer
variables updated without lock protection in bcm_tx_setup()?

When the SETTIMER flag is provided, the variables are updated directly:

	op->kt_ival1 =3D bcm_timeval_to_ktime(msg_head->ival1);
	op->kt_ival2 =3D bcm_timeval_to_ktime(msg_head->ival2);

The timer handler reads these ktime_t values locklessly in
bcm_tx_set_expiry():

	if (op->kt_ival1 && op->count)
		ival =3D op->kt_ival1;
	else if (op->kt_ival2)
		ival =3D op->kt_ival2;

On 32-bit systems, could this result in a torn read of the 64-bit ktime_t
values, causing bogus timer expiration times?

[ ... ]
> @@ -1790,8 +1795,10 @@ static int bcm_release(struct socket *sock)
> =20
>  	synchronize_rcu();
> =20
> -	list_for_each_entry_safe(op, next, &bo->rx_ops, list)
> +	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
> +		list_del_rcu(&op->list);
>  		bcm_remove_op(op);
> +	}
> =20
>  	/* remove device reference */
>  	if (bo->bound) {

[Severity: Medium]
This is a pre-existing issue, but is there a memory leak of the CAN
receiver object due to a race between bcm_delete_rx_op() and
NETDEV_UNREGISTER?

If bcm_delete_rx_op() races with unregister_netdevice(), dev_get_by_index()
returns NULL:

	dev =3D dev_get_by_index(sock_net(op->sk), op->ifindex);
	if (dev) {
		bcm_rx_unreg(dev, op);
		dev_put(dev);
	}

The op is then removed from the list via list_del_rcu(&op->list):

	list_del_rcu(&op->list);
	bcm_remove_op(op);

Making it invisible to the subsequent NETDEV_UNREGISTER event handler in
bcm_notifier(). Since bcm_rx_unreg() is skipped in both places, does this
permanently leak the receiver object allocated in can_rx_register()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v6-0-80710a2bc398@hartkopp.net?part=3D5
