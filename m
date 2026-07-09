Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C53437466
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622633; cv=none; b=jrogTC6SFPrRvFZmp2f4XKo7e+OITp3J6bOz0rcwfEtIJ6DQuibeE0am3W/jmLKAthDSi1Pm9ivI+J8IM6YWubVnahDq4YWG4p9vr35uKem/WNJ8tLuYf0udXVUqXNpBecW3t6aUAAJWj9lx1XcNbOXtxNWTn2QdGYJQgoSN63g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622633; c=relaxed/simple;
	bh=/Lr+soQAptTYOrEq6/2YhlXym5phIEGEuQrSuYNtWZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ksmj9VEqn/TG7WunQdXY3BKQ6Uxj7V8vBctjmb9YvxRPTcTAKbyWUsYtHEGI3glSg6Th+L0YOWtf8z5eCYwKKYe4GqJzNVL9o2GaN/l8m1u4uuNyN7hWdVkWK97iIXXyXQS2LZjwH1jBq3gUOLcRJ0UvTQHbjloC9fcVAtkl2pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0cJ/GGw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0cJ/GGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723F71F000E9;
	Thu,  9 Jul 2026 18:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622631;
	bh=+sBod1MdyvFNZMyLIGiFknSqplcAZJ+o6tugwdO8nEU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o0cJ/GGwIKGZIEoRzpam2sswhwfDfEbP3JJ9gJYiC5gYcXm2VVKN+4Ba6x5Kpuv7G
	 UVMG6bURhTGUFfqu61kEkQKXf3D6xiTKxmN6Dmz55bJnWUqoRYuRyD1zWuL9bdITyb
	 r1PUYIwq8hSypeuiCB3HrwgTuTj4JpjC0awONF16DI9Jiy3coF7emdy9DEHQxd+ZZb
	 6KY64sT0BcBjCNewmaMZbKEuvbuMVoldyCVBQU36GKntQDVCTe5RmYF4zETZhMaRPm
	 VKkZnbY/EFs3QRrOqTK0STFmv6zJYIN4wIyURNr4g5kpROPU0LGOe1IWAD8bv3kPyy
	 quvCsAwVIVR1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 11/11] can: bcm: track a single source interface for
 ANYDEV timeout/throttle ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260709-bcm_fixes-v11-11-067ba11bec5c@hartkopp.net>
References: <20260709-bcm_fixes-v11-0-067ba11bec5c@hartkopp.net>
 <20260709-bcm_fixes-v11-11-067ba11bec5c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 18:43:51 +0000
Message-Id: <20260709184351.723F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Race condition between interface unregistration and in-flight pack=
ets permanently breaks ANYDEV sockets.
- [Medium] Data race and torn read on 64-bit ktime_t variables bypassing AN=
YDEV concurrency protection.
--

--- Patch [11]: [PATCH v11 11/11] can: bcm: track a single source interface=
 for ANYDEV timeout/throttle ops ---
commit ed6fe9660233297822929009c213120acb00229f
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: track a single source interface for ANYDEV timeout/throttle ops

An ANYDEV rx op with an active RX timeout/throttle timer has no defined
semantics when matching frames arrive from multiple interfaces, leading to
data corruption. This patch adds op->if_detected to track the first interfa=
ce
that delivers a matching frame, rejecting frames from other interfaces.
The claim is released on NETDEV_UNREGISTER or timer reconfiguration.

Link: https://lore.kernel.org/linux-can/20260709105031.1A39C1F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 10a883b50fc63..8cc0d2267582f 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -776,6 +777,28 @@ static void bcm_rx_handler(struct sk_buff *skb, void=
 *data)
>  			return;
>  	}
> =20
> +	/* An ANYDEV op with an active RX timeout and/or throttle timer
> +	 * tracks a single source interface: claim the first interface that
> +	 * delivers a matching frame and reject frames from any other one,
> +	 * before hrtimer_cancel() below can touch op->timer - this avoids
> +	 * racing bcm_rx_timeout_handler() across concurrent interfaces.
> +	 * RX_RTR_FRAME ops are excluded, as kt_ival1/kt_ival2 may briefly
> +	 * hold a stale value from an earlier non-RTR configuration.
> +	 */
> +	if (!op->ifindex && !(op->flags & RX_RTR_FRAME) &&
> +	    (op->kt_ival1 || op->kt_ival2)) {

[Severity: Medium]
Can the lockless read of these 64-bit ktime_t variables cause a torn read on
32-bit platforms?

If the torn read evaluates to zero while the timers are actually configured,
wouldn't it bypass the interface-tracking logic and allow concurrent frames
to clobber shared metadata?

> +		bool foreign;
> +
> +		spin_lock_bh(&op->bcm_rx_update_lock);
> +		if (!op->if_detected)
> +			op->if_detected =3D skb->dev->ifindex;

[Severity: High]
Can an in-flight packet spuriously re-claim the stale ifindex here?

In bcm_notify(), the claim is released when an interface goes down. Since
bcm_notify() executes before synchronize_net(), could an already dequeued
packet arrive here, see op->if_detected =3D=3D 0, and re-claim the dead
interface's index?

This seems like it would permanently block future packets from other valid
interfaces.

> +		foreign =3D op->if_detected !=3D skb->dev->ifindex;
> +		spin_unlock_bh(&op->bcm_rx_update_lock);
> +
> +		if (foreign)
> +			return;
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v11-0-067ba11bec5c@hartkopp.net?part=3D11
