Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE752BEFFD
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414218; cv=none; b=q1BkpkLXBAsHE5tlxWp5Rve7Kas2RSj1vnGtPRWxj+4bGM4t7suExgzId9tYcQb0HyN7Hp00OKqL1q8NuN2Lz1f3xKQVQ3RmlETXW8lcvAZmErgzj99IxRMiMzDID8jp3zD9CxwV4ks5Ia6OoUfRLHjHqlvvysdz530gRbZniZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414218; c=relaxed/simple;
	bh=VFRjNakw38o8FRLUiB2b4lAryotMmsgXlpvt5FMqNuI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k7Y8FrKOBXo7EbsRTOpy9GrAF/SSQG/FLIugGihagCKuen/8ym6HTSmqAttNs/y5XQjeBtDAww6iUkN3ahS7J0hwNNCQlb2lSsMSX4rkUjcAzNzTeYKMPLM1m7tCz/LHuk+za0cMcqZviCmgcbO0b10bF7PptJLl8z4ENQI+auQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2eo1Hhp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2eo1Hhp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0A11F000E9;
	Tue,  7 Jul 2026 08:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783414216;
	bh=17VYtIjJ5CmlgtmbG2T4bq0WLCV/bhS5CT0Ui9pj8ak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a2eo1Hhp+sBL4GmWDkf48zh72p/fofXThjAkfRt29yPJECZjeIZOOaTervDYzNDqB
	 /1VdjPsM+YmCLEqhH/vuzSqIbfl1DdlPAENcRhqt2kbvhE4aa4Ud6m16C78NX66uKN
	 E2Vn1b5+qu8Wq+5SUS9OqSQOC0q2yO6JOonhGVJEdfkcl/6aDgVJO79CyFh9S+66/s
	 b2RCGIYJDxmaZTneLFP+7cqNr8l/3Iypi+pgbynmtjlcMN79gINoIH6xKm4EiXeqMX
	 M16blfvH8M/0VOyUD0GVGuviAM4dLg4bNDBnhHEu2o3Utpineqrkre5TyO1nwHywpa
	 MC4J7wRAXcuxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] can: bcm: add missing rcu list annotations and
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260707-bcm_fixes-v2-5-96620c534b75@hartkopp.net>
References: <20260707-bcm_fixes-v2-0-96620c534b75@hartkopp.net>
 <20260707-bcm_fixes-v2-5-96620c534b75@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 08:50:16 +0000
Message-Id: <20260707085016.7E0A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent updates to CAN frames and timers in bcm_tx_setup() race=
 with bcm_tx_timeout_handler() and bcm_can_tx().
--

--- Patch [5]: [PATCH v2 5/6] can: bcm: add missing rcu list annotations an=
d operations ---
commit 6cbc186daf031268589b88c789ab291e31165918
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add missing rcu list annotations and operations

This commit adds missing list_add_rcu() calls in bcm_tx_setup() and
bcm_rx_setup() to ensure proper initialization of bcm_op structures during
RCU traversal. It also fixes the removal side in bcm_release() by properly
unlinking ops with list_del_rcu() before freeing them via call_rcu().

Closes: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.=
kernel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 20b1bdc87414a..3609178a1367d 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -1156,6 +1156,10 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
>  		op->flags |=3D TX_ANNOUNCE;
>  	}
> =20
> +	/* add this bcm_op to the list of the tx_ops? */
> +	if (add_op_to_list)
> +		list_add_rcu(&op->list, &bo->tx_ops);
> +

[Severity: High]
This is a pre-existing issue, but can concurrent updates to CAN frames and
timers in bcm_tx_setup() race with bcm_tx_timeout_handler() and
bcm_can_tx()?

While a previous commit in the series fixed this exact issue for RX ops by
using a staging buffer and lock, the TX path appears to be left unprotected.

When an existing BCM TX op is running its cyclic transmission via the
hrtimer bcm_tx_timeout_handler(), and user-space calls sendmsg() with
TX_SETUP to update the op's frames or timers, bcm_tx_setup() directly
copies new data into op->frames using memcpy_from_msg() without holding
bcm_tx_lock or using a staging buffer. It also updates op->kt_ival1 and
op->kt_ival2 without locking.

Concurrently, bcm_tx_timeout_handler() reads the unprotected timer values
and invokes bcm_can_tx().

bcm_can_tx() acquires bcm_tx_lock only to resolve the cf pointer to the
current frame, but drops the lock before calling skb_put_data().

Could this allow skb_put_data(skb, cf, op->cfsiz) to copy the frame payload
out of op->frames simultaneously with memcpy_from_msg() writing to it,
resulting in a torn read that transmits corrupt or partially updated CAN
frames onto the network?

>  	if (op->flags & TX_ANNOUNCE)
>  		bcm_can_tx(op, NULL);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v2-0-96620c534b75@hartkopp.net?part=3D5
