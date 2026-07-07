Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293F222D7A9
	for <linux-can@vger.kernel.org>; Tue,  7 Jul 2026 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783413435; cv=none; b=UQyGDjSszHKPrhTZJ2IPzT6xWQS4wOXwf3ljnZF/mQEiYgRhQXyUvloPWWvFllZYTT7g+Ab2KXgp7p+lfdtej8H604cMEjsE02qbVirZM0oLbh7s2dFTsZui3sBVhSEEo3VH7e6yO5Pi6WZbTLTWUkD2q1VeVi0VoqYs6Pfnz6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783413435; c=relaxed/simple;
	bh=3AhsJCTycbD2pZpBs8wjfwaJVm3VD++H9iYkttSQm+A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fExLKGbV2bABsyLDLxH83zsLfTDQSJXlYMrqnx9vyOCfOzK9dV6kU3l7ywUZL763N1wv3xW+VqV/vSrp+dzr76qDv2sL3kLGB0edjeSNHS8mr2tikb8XUsMsl6G3fERCrjPz0UaAFpXC/9hXEO1s0PzZ+hC4cnoNLKhpLyF6uhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4Zs0E2X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4Zs0E2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8561F000E9;
	Tue,  7 Jul 2026 08:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783413433;
	bh=FlHiWiD6R9IelqhKbJIYMDd9a3RvOhhf9p3iUlcNZ44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B4Zs0E2XkLQoYByL9kCI121MXjYMeD53tNdx27SxxQjsOXFlih/XbWQXLslzQqov1
	 ZUP5vO6JhUR7eWWhDCli4pLk1Y05yMmRe+QSe4OuuwGx4cPKOtvkPUgyXP95TDZFQe
	 XtglhqvW5QM4LlvWoPKVsxdCYL0pIKt3ZQVpLJJDnQdnAopvJrkOaJhP84BTvA9xwv
	 DTEBqRtPofwCT6yxW3mfKLWMP2sit+eGZfyYiLNMSWNZnf8JvCGjnD3AEHDPMFfmRq
	 MxuTRaP2HL+tsT2pIVgkdFvbTd34gXKU/J+OdW7Y2BC4k9VQiGuw3UG6OehWP41QFm
	 w5HfkHwtrEnDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] can: bcm: fix CAN frame rx/tx statistics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260707-bcm_fixes-v2-4-96620c534b75@hartkopp.net>
References: <20260707-bcm_fixes-v2-0-96620c534b75@hartkopp.net>
 <20260707-bcm_fixes-v2-4-96620c534b75@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 08:37:13 +0000
Message-Id: <20260707083713.8A8561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of bcm_rx_handler() leads to unprotected data=
 races and potential 64-bit torn writes on op->rx_stamp and op->rx_ifindex,=
 causing metadata corruption.
--

--- Patch [4]: [PATCH v2 4/6] can: bcm: fix CAN frame rx/tx statistics ---
commit c40daefa12b560d84d208b978162b5b62f34aade
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix CAN frame rx/tx statistics

This commit fixes a KCSAN-detected data race in bcm_rx_handler() when multi=
ple
CAN frames are processed concurrently. It transitions the statistics counte=
rs
to atomic long operations and consolidates overflow checking into a new
bcm_update_stats() function.

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -742,7 +752,7 @@ static void bcm_rx_handler(struct sk_buff *skb, void =
*data)
>  	/* save originator for recvfrom() */
>  	op->rx_ifindex =3D skb->dev->ifindex;

[Severity: High]
This is a pre-existing issue, but can concurrent execution of bcm_rx_handle=
r()
lead to unprotected data races on op->rx_stamp and op->rx_ifindex here?

If an application creates a BCM socket listening on all interfaces (ifindex=
=3D0),
and multiple CAN frames arrive concurrently from different interfaces match=
ing
the same bcm_op, bcm_rx_handler() can be invoked concurrently on multiple C=
PUs.

CPU A and CPU B could both write op->rx_stamp and op->rx_ifindex outside of
any lock. If CPU A then acquires the lock and reads these values later in
bcm_send_to_user():

net/can/bcm.c:bcm_send_to_user() {
    ...
		/* restore rx timestamp */
		skb->tstamp =3D op->rx_stamp;
    ...
	addr->can_ifindex =3D op->rx_ifindex;
    ...
}

Could CPU A pick up CPU B's ifindex or a torn timestamp? This might lead to
CAN frames being delivered to userspace with mismatched interface indices or
corrupted 64-bit timestamps on 32-bit systems, potentially breaking
time-sensitive control loops.

>  	/* update statistics */
> -	op->frames_abs++;
> +	bcm_update_stats(op);
> =20
>  	/* snapshot the flag under lock: op->flags/op->frames may be updated
>  	 * concurrently by bcm_rx_setup(). Do not call bcm_can_tx() while

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-bcm_fixes-=
v2-0-96620c534b75@hartkopp.net?part=3D4
