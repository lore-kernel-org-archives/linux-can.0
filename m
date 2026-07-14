Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FA639CCE2
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048671; cv=none; b=ZoSmAti9PlaHGtRTvw3aCsCdKBIhKEGYAuu7GOyNGQRtMomF7obtHxATfR2WYVsrdOoA1TnFxY8RufG3bu8sor9gM9jdS355mNmytN36+29xQh6M9t83a+A06mG4QD+3kOYyZ6BG+1zOVQeOzkXLVzJlDWBccIiNpk6kMM/Hzdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048671; c=relaxed/simple;
	bh=MVYwxMlzDUbRE8lmw+EJN4xTbF3uPufbnOoBNqoqRIc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=joa1CzgINKVMnGGiTMvI6Qfw0rNhi3m8LXBfaO3hQkTCEf3KvCFe9hoqcdxA+lxuveg20+CsgXarftpeLSrQ7OAdFGjzF4b/p08Hp8MDkOfwWW7gOJWrJWR39XJyYFAbLC+7gjQ2dTCf5frPW1Y7BubnuN5S+kP1Ww9+IoNFLNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MltQ6Ony; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MltQ6Ony"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2FA1F000E9;
	Tue, 14 Jul 2026 17:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784048669;
	bh=FQ/g0U41HM16G9qFNPwrGaimidD5rT0BkpfjF0wPpoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MltQ6OnyuZ3wQqIVxgZBnAz8NPomZ6lhwL+XAO4rRAqTO+rIBG8l6WM99n3uZTmgn
	 R9g7zYYpWCjBMGikLOd8YRLa2L1IFNZQngGdZ6/a08CjrsGErPPoyceHpSJH5z3Qyd
	 kMh22+IhY2lh46hE+3M0AX587sSaHD5pHzDZL4G5GXMaE4IFT8yGwlVa26Qq8FQ6z4
	 6InvIzvF352cyE20+esbBJnnMdesE8k7iN/sIRAOrzpMJzADvqIDFbilWVsxwlgYBB
	 9T6gV95g/kubS9DTaVvd09nM1NMWkENCQOgJkcSPB5iljAfB9/md5hSttXUIIF8zDc
	 x486LNhRhIPDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 05/11] can: bcm: add missing rcu list annotations
 and operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260714-bcm_fixes-v15-5-562f7e3e42da@hartkopp.net>
References: <20260714-bcm_fixes-v15-0-562f7e3e42da@hartkopp.net>
 <20260714-bcm_fixes-v15-5-562f7e3e42da@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 17:04:28 +0000
Message-Id: <20260714170429.6F2FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Unconditional `list_add_rcu()` on the success path in `bcm_rx_=
setup()` corrupts the list for existing operations.
- [Critical] Removing `list_del_rcu()` from the registration error path in =
`bcm_rx_setup()` causes a Use-After-Free for existing operations.
--

--- Patch [5]: [PATCH v15 05/11] can: bcm: add missing rcu list annotations=
 and operations ---
commit 493e1bc1997871e18b09125c187a88444720b12c
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add missing rcu list annotations and operations

This commit updates the broadcast manager (BCM) to use proper RCU list
operations when adding and removing operations. It addresses missing
list_add_rcu() calls in setup functions and ensures ops are unlinked
before being handed to bcm_remove_op().

Closes: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.=
kernel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 03c98e4cc677d..5c1e83eeb4ff3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -1449,10 +1450,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
>  					      bcm_rx_handler, op, "bcm", sk);
>  		if (err) {
>  			/* this bcm rx op is broken -> remove it */
> -			list_del_rcu(&op->list);
>  			bcm_remove_op(op);
>  			return err;
>  		}

[Severity: Critical]
Does removing this list_del_rcu() cause a use-after-free for existing
operations?

If a user updates an existing BCM RX operation for a specific device that
was unregistered, the op remains in the list but op->rx_reg_dev is cleared.

If the update occurs and the interface is gone, dev_get_by_index() fails,
and this error path is taken.

Since bcm_remove_op() frees the operation via call_rcu(), removing
list_del_rcu() leaves a freed operation linked in bo->rx_ops. Any
subsequent operation traversing the list, such as bcm_release() or procfs
reads, would then dereference freed memory.

> +
> +		/* add this bcm_op to the list of the rx_ops */
> +		list_add_rcu(&op->list, &bo->rx_ops);
>  	}

[Severity: Critical]
Could this unconditional list_add_rcu() corrupt the list if the operation
is already linked?

When updating an existing operation that needs to be re-registered (for
example, if the interface was unregistered and a new device reuses the
ifindex), do_rx_register will be 1 for an operation that is already linked
in bo->rx_ops.

Calling list_add_rcu() on a node that is already part of the list corrupts
the list pointers, which could lead to an infinite loop or panic during RCU
traversal.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v15-0-562f7e3e42da@hartkopp.net?part=3D5
