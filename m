Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72133F39E1
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586396; cv=none; b=AdzoYfz6Jy9hA+BlyQExp71fFZ2PCHLUQWr7q2hlBhyxaEghVIu4YytwTqUzAeixaYhwdpYMuYlZW89GK2zjSifSgznk7RD6UgfPoP7mTZv6JCYYVBAkBQFizc4XOUr4YeNpYpG4SFCSZASq3KArannxdR+OfjFoU0Q5NNIIzA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586396; c=relaxed/simple;
	bh=YxTLc9zZB2pqgQbM/xVyy+Jh78bZhWw6n6sGHT4P8tY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lI9buN5o3dj/Z6aONBjfsgciSSXrjuw98dbIq5mqIdhvfXmvoLRYHdsufD1BphYJr5R7jN3JK3FdSJyUFaOCulebB0lUFLnWg2fo1Krn3B74cukdy+/oQKd4cycoVYrv6co438oLWg8iaOnjnHbuvG0HV2RRenv4oEUvzXX/N60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YExAzdob; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YExAzdob"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1901F000E9;
	Thu,  9 Jul 2026 08:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783586390;
	bh=sjcszLGTqlFaB7YNwJr9xDOnMy33TxmngZmcPvdceC0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YExAzdobQl2vzHr8WABZhHUSpAlpyK6q6CepkhnmAW23oiDC3wWGyQYSi5bg+WURg
	 fHV6POJ7hq3x0QQW5sJkfDybHS3SnAa+82MAlm8SHGjLFE+EZ1ery2US6xVeB38NnE
	 2GcB8iF3brz+7b0XvVVU0bLPG4RqfGdhP7L1k8BTPe4VYyPtgkrXT/mtAXD2dRg5HA
	 lk38p/wkPsQ4JQKjxnJcX20h6N3+HYup748e9DpeBN7oBy7WOgg6Ubdhkwf0NAusXW
	 erhxw72X3Fsj8dfZiEuqvotNsfA85FLvmxb/bUEqgQuih5CpkNVR61BeKhnJj+sglX
	 Vo6OaZRoa/uEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/10] can: bcm: add missing device refcount for CAN
 filter removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260709-bcm_fixes-v9-8-6eebb78ccfb2@hartkopp.net>
References: <20260709-bcm_fixes-v9-0-6eebb78ccfb2@hartkopp.net>
 <20260709-bcm_fixes-v9-8-6eebb78ccfb2@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 08:39:49 +0000
Message-Id: <20260709083949.DC1901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] An existing BCM RX filter silently fails to re-register if its bou=
nd device is unregistered and later replaced, or if the socket is bound to =
'any' interface and the device is recreated.
--

--- Patch [8]: [PATCH v9 08/10] can: bcm: add missing device refcount for C=
AN filter removal ---
commit 1ad23d1877e2e80147338573cbaebed867d37fc0
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add missing device refcount for CAN filter removal

This commit fixes a missing device refcount issue in bcm.c when unregisteri=
ng
a CAN filter. It introduces a netdevice_tracker to hold a reference on
op->rx_reg_dev from filter registration until unregistration, preventing
lookups on a stale device index.

Link: https://sashiko.dev/#/patchset/20260707094716.63578-1-socketcan@hartk=
opp.net

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 6668c1c25d923..61725c20f087e 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1464,7 +1463,17 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
>  						      bcm_rx_handler, op,
>  						      "bcm", sk);
> =20
> -				op->rx_reg_dev =3D dev;

[Severity: High]
This isn't a bug introduced by this patch, but is there a scenario where an
existing BCM RX filter silently fails to re-register?

If a BCM socket is bound to interface 0, an RX_SETUP creates an operation
for a specific interface and sets op->rx_reg_dev. If that interface is then
unregistered, bcm_notify() unregisters the filter and clears op->rx_reg_dev
but leaves the operation in bo->rx_ops.

When the device is recreated and another RX_SETUP is sent for the same id
and ifindex, bcm_find_op() in bcm_rx_setup() finds the existing operation.
Because it is found, do_rx_register remains 0. The setup then returns
success but bypasses the can_rx_register() phase entirely.

Does this sequence result in the filter remaining inactive on the newly
created device and silently dropping expected CAN frames?

> +				/* keep a tracked reference so that a later
> +				 * unregister can safely reach the device even
> +				 * if a concurrent NETDEV_UNREGISTER has
> +				 * already unlisted it by ifindex
> +				 */
> +				if (!err) {
> +					op->rx_reg_dev =3D dev;
> +					netdev_hold(dev,
> +						    &op->rx_reg_dev_tracker,
> +						    GFP_KERNEL);
> +				}
>  				dev_put(dev);
>  			} else {
>  				/* the requested device is gone - do not

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v9-0-6eebb78ccfb2@hartkopp.net?part=3D8
