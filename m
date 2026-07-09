Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6CF3BB101
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629354; cv=none; b=Naihk3mqsqDRupbKBofCoAjJWgrCYHBEPI375gsV3jTX2vYxTr6gttNgbgF8OhuZn7xptfxlKN5iJu7YTtBEDa8fGh97dx7fNfs2VBpdwrhI/3+6zgnn1hwkl9cGk/EED59DFr+458QtKR20Nt+IU71eDDwOUus9y5uLjurE/ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629354; c=relaxed/simple;
	bh=X4IV0ZzpMUfxEfmuzWB7oImxhh0GESZZ+aYtwRNKWms=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jS/LNzQvwY3+zJWMsmDTCeX37GkxJ4d/M7I4H9+NOu2F9ymlx1dFTn3Tmpd+vf7S34IzJZ7J6RwwVSsFVt8wTbYjfRsfZIs5bDi3KzqF1as33PfIIs2JaSAdtknpNFGK2xzY9oGNzp+WEYbwhFCXxxaHOiYw6Wqn83YoxrG80gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd0SwSf7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd0SwSf7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D473D1F00A3D;
	Thu,  9 Jul 2026 20:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783629353;
	bh=GYXyNdYcv2AfWaqtLxntJa1uEVa+aeLkXgmEbC6oFKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dd0SwSf7roKtYmUeZ933F/yXeHNrA3ZURMiAuEed4Vvikw47x0jje7K/kDRzL8qVC
	 taDEkmbKXDLgurnMT4KsNWyxt3lRHbyGhavcxvdG2SH6yizIE7eXlDuIDooyD3g6sR
	 z+etWXSauHjAb1yZNw1sudF0F0yp/d7hvESzftCM75kulm4M8iOd6JnLU3vSM/5+U/
	 ryXgSe89Ha0tloodPeYqbyWsgpZOPhyEFuSSxIikTNgfRz3nHRfwkgxBMl+MRkeOR9
	 0bIimSd8bePMimGaCIxE/6dVq/aBsVFs0Fg3eqzyhyG2pa0ht9eX9kfpCAcDaNLH9/
	 OVSAwn0PawJBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 05/11] can: bcm: add missing rcu list annotations
 and operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260709-bcm_fixes-v12-5-61c06291bf1c@hartkopp.net>
References: <20260709-bcm_fixes-v12-0-61c06291bf1c@hartkopp.net>
 <20260709-bcm_fixes-v12-5-61c06291bf1c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 20:35:52 +0000
Message-Id: <20260709203552.D473D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] List corruption when updating an existing RX operation after a dev=
ice unregistration.
--

--- Patch [5]: [PATCH v12 05/11] can: bcm: add missing rcu list annotations=
 and operations ---
commit d541f7be2b7c689e5da6382dd975710ba6b59607
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add missing rcu list annotations and operations

This commit adds missing list_add_rcu() calls in the BCM setup paths to ens=
ure
proper initialization before traversing bcm_op structures under RCU. It also
fixes the removal side by explicitly unlinking ops with list_del_rcu() befo=
re
freeing them.

Closes: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.=
kernel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 38c3f690c1cd0..940cd9df1cca3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1357,9 +1361,6 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
>  		hrtimer_setup(&op->thrtimer, bcm_rx_thr_handler, CLOCK_MONOTONIC,
>  			      HRTIMER_MODE_REL_SOFT);
> =20
> -		/* add this bcm_op to the list of the rx_ops */
> -		list_add(&op->list, &bo->rx_ops);
> -
>  		/* call can_rx_register() */
>  		do_rx_register =3D 1;
> =20

[ ... ]

> @@ -1431,10 +1432,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
>  					      bcm_rx_handler, op, "bcm", sk);
>  		if (err) {
>  			/* this bcm rx op is broken -> remove it */
> -			list_del_rcu(&op->list);
>  			bcm_remove_op(op);
>  			return err;
>  		}
> +
> +		/* add this bcm_op to the list of the rx_ops */
> +		list_add_rcu(&op->list, &bo->rx_ops);

[Severity: High]
Can this unconditionally add an already-linked operation to the list?

If a CAN interface is unregistered, the NETDEV_UNREGISTER notifier clears
op->rx_reg_dev but leaves the operation linked in bo->rx_ops.

If bcm_rx_setup() is called again for the same CAN ID on this existing op,
it sees op->rx_reg_dev is NULL and sets do_rx_register to 1:

		do_rx_register =3D (ifindex && !op->rx_reg_dev) ? 1 : 0;

After successfully re-registering with the CAN core, this list_add_rcu()
executes. Since the op was never removed from bo->rx_ops, won't this
overwrite the list pointers and corrupt the RCU list?

Should this be guarded by the new_op flag, similar to how bcm_tx_setup()
guards its list_add_rcu() with add_op_to_list?

>  	}
> =20
>  	return msg_head->nframes * op->cfsiz + MHSIZ;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v12-0-61c06291bf1c@hartkopp.net?part=3D5
