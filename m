Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B27395AF2
	for <linux-can@vger.kernel.org>; Thu, 18 Jun 2026 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771287; cv=none; b=KncmNoiT76Z0HoLsgNx//3tU4BHhUgTfc3STGFXXkisRdHoQrfIJRYlFkxqSfgB2EwODs9t8oHStSgkpSxQB9tkgPL97GI463BBMSn3ifLnS4yymDJbnS+RX8kIJnVxb5BAoMg6JLYhG0IHB1m5GRKIHb3V6a/B71orkWOW7tU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771287; c=relaxed/simple;
	bh=g+mF2NLxwp7bxkMNexW65s+tWhMeT0GBEeQ8/0k98AU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HYmj7OBPt6QC5nia05+nCVAOr44tezdDdYliCR4vEjO+1uBSZmhlTFBrLbw5xb/TQIlbMPqebs572DUd0Zw/kB2TdVV88Ur5ejG1qHAlSWVonkhho2gz2e8IpxMBUDChns8EPoaupymKzLachNLE+U+Wv+3sWY8HQzzu86Ojsx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIKg9g6u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIKg9g6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4E71F000E9;
	Thu, 18 Jun 2026 08:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781771285;
	bh=Py1CHHAEEQSsUCtNIfRZl8+T1xwrPISFy/zap1DbzQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oIKg9g6uZFBi2iSej2S3zjvVMfbGgutuvqACyogoW43Mi3pvASyAwCGLJ/CtCiyRp
	 gY/bGtCZFboFnrrbfC1ttFIVouqI3abMkNkT3Qs8Z08fQBPuQtxoa8gWweh6Y/ElPO
	 DZ8fm0k/qQwXMhj6HQugiOBTaEYhnp8s0FDPb78TIjfLqEFu2yOFGbYpOigkmTeEpw
	 R6FvawsznCHcT2ehfqzIQ2UHU3MbuDyu3C/y8oFvd5Fu2Uclw3DWMBq4aTmZcIcUTo
	 s5zopty4qQ0Tqxxxco0vLrklQPU2srg80VkIHDi88VZ/5vkpUQ6KHSIl9ryihdkeNk
	 ekK7QeKN+EPzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y] net: add missing ns_capable check for peer netns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maximilian Heyne" <mheyne@amazon.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260617-keyed-dude-3493dbdb@mheyne-amazon>
References: <20260617-keyed-dude-3493dbdb@mheyne-amazon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 08:28:05 +0000
Message-Id: <20260618082805.6A4E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Approximating `netlink_ns_capable()` with `ns_capable()` introduce=
s a confused deputy vulnerability, allowing privilege escalation via socket=
 passing.
--

commit fbf821e5c53ccbfb6a6615992ef20fa8b86e79bd
Author: Maximilian Heyne <mheyne@amazon.de>

net: add missing ns_capable check for peer netns

This patch attempts to backport a capability check for peer netns
creation in vxcan and veth interfaces. It replaces the upstream
netlink_ns_capable() check with an ns_capable() check to accommodate
older stable kernels.

> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> index 98c669ad51414..da4affff65476 100644
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c
[ ... ]
> @@ -211,6 +211,11 @@ static int vxcan_newlink(struct net *net, struct net=
_device *dev,
>  	if (IS_ERR(peer_net))
>  		return PTR_ERR(peer_net);
> =20
> +	if (!ns_capable(peer_net->user_ns, CAP_NET_ADMIN)) {
> +		put_net(peer_net);
> +		return -EPERM;
> +	}
> +

[Severity: High]
Could approximating netlink_ns_capable() with ns_capable() introduce a
confused deputy vulnerability?

Because ns_capable() checks the credentials of the currently executing
thread rather than the credentials of the process that originally opened
the netlink socket, this might be bypassed via socket passing.

If an unprivileged attacker opens a netlink socket, crafts a malicious
RTM_NEWLINK message to create a vxcan peer in a privileged namespace,
and passes the socket file descriptor to a privileged setuid binary, the
message could be processed synchronously in the context of the privileged
thread. The ns_capable() check would then incorrectly succeed based on the
privileged process executing it.

Should this validate the socket's opener credentials instead to prevent
unauthorized interface creation?

[ ... ]
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index e1e8c825483aa..dac8cc5a79f5a 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
[ ... ]
> @@ -1707,6 +1707,11 @@ static int veth_newlink(struct net *src_net, struc=
t net_device *dev,
>  	if (IS_ERR(net))
>  		return PTR_ERR(net);
> =20
> +	if (!ns_capable(net->user_ns, CAP_NET_ADMIN)) {
> +		put_net(net);
> +		return -EPERM;
> +	}
> +

[Severity: High]
Does this have the same confused deputy issue as mentioned above in
vxcan_newlink() since it relies on the current thread's credentials?

If a privileged process is tricked into writing to an attacker-controlled
netlink socket, ns_capable() would evaluate the privileged current thread
instead of the unprivileged socket creator.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-keyed-dude=
-3493dbdb@mheyne-amazon?part=3D1
