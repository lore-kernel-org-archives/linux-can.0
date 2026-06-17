Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B939138B15E;
	Wed, 17 Jun 2026 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781685452; cv=none; b=Kc/De2U63GMeinRSlPkj5+w0riqk4j+kzz/tHLa2Fx/JKjHEPnadjgUvoZWfd2lVte6t6ns/OsA2mnA8e1OLA+pd39PPKGIfErZIHh3xSs+kJr7Z2xgI1DCdCXxkkndytRKItngQym86JEVVb7EkAgIZynjt+6o6J2SzwPeCQfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781685452; c=relaxed/simple;
	bh=SXJKkRNli6oniNxAn5C9S1DK+QZTnsw7KxnNf8U2bjY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h3HPH0Imr/fnQKSnBzHsNZeIZ5Br9WEfUGLV+mFjZGVXI4io/k9Az6VAexrozj01O93Ov45ZQ5LFo7nn4hxaWMLHrxkWK/Fq8vfjTcIf2NTFvg0FknC9r01ttftoMBOUssQHkgVwkJwBQYEygm9Le9vfZSANTdUZ0DwHa1dCUsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k69taR5j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k69taR5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0C31F000E9;
	Wed, 17 Jun 2026 08:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781685451;
	bh=4vskoaQKonxH7hnmSLOG+ZNeos4J8OvFNf32tfN6+8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k69taR5jh56PmaaYv+wTiE2nhf07y6j+fAGeD5a7LojGVv0Da7sfzzprv7EttusUj
	 LKVvQuvK+Ek7b1uSWjGxVJiy7lOaxYfx5M6Xg9YYy7AN503UHhA56BZgOBFdN4sNW/
	 Gd4tpUFhnmLl3XX8I2c/zIOKWl7rLN/yQaTGAFo833C9GNvRjoeUIPa+noY++5VsdQ
	 5sWMp53JcxhGf7x+gFWnmnKIPKZ49H8POh1U5raZwmh3SinaBhryo/QhINzX0nmcgU
	 jw2/w8VcowtiPD6S112cSTd1tdSntJYASsUfOGkreT4Vb+c5ft1WOIndlG76o25CGH
	 fRzU3Pj8uU0aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] net: add missing ns_capable check for peer netns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maximilian Heyne" <mheyne@amazon.de>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, bpf@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260617-pats-coif-316245c6@mheyne-amazon>
References: <20260617-pats-coif-316245c6@mheyne-amazon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 08:37:30 +0000
Message-Id: <20260617083731.2B0C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The patch approximates `netlink_ns_capable()` with `ns_capable=
()`, leaving the system vulnerable to a Confused Deputy attack via passed n=
etlink sockets.
--

commit 2a12959cedf2cc9c8b0a31fb916efbc1495579b3
Author: Maximilian Heyne <mheyne@amazon.de>

net: add missing ns_capable check for peer netns

This patch attempts to fix CVE-2026-31692 on older stable kernels by
adding capability checks to vxcan, netkit, and veth when creating peer
interfaces. It replaces the upstream netlink_ns_capable() check with
ns_capable(), relying on the synchronous nature of the newlink operation.

> Approximate the netlink_ns_capable check with an ns_capable check. As
> the newlink operation is synchronous this should result in the same
> behavior.

[Severity: Critical]
Does replacing netlink_ns_capable() with ns_capable() leave the system
vulnerable to a Confused Deputy attack, despite the synchronous behavior?

While the newlink operation is synchronous, ns_capable() only checks the
current thread's capabilities. netlink_ns_capable() also checks the
capabilities of the process that originally opened the netlink socket.

If an unprivileged attacker creates a netlink socket, crafts an RTM_NEWLINK
payload to create a peer interface in a privileged namespace, and passes the
socket file descriptor to a privileged SUID binary, could the SUID binary be
tricked into writing the payload? In this scenario, ns_capable() would see
the SUID binary's CAP_NET_ADMIN and allow the operation, bypassing the
intended security boundary since the unprivileged socket creator's
capabilities are ignored.

> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> index 9e1b7d41005f8..851c93bf0b310 100644
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

[Severity: Critical]
Does this ns_capable() call in vxcan_newlink() introduce the confused
deputy vulnerability described above?

>  	peer =3D rtnl_create_link(peer_net, ifname, name_assign_type,
>  				&vxcan_link_ops, tbp, extack);
>  	if (IS_ERR(peer)) {

> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index fba2c734f0ec7..e0c42fa0c835c 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
[ ... ]
> @@ -413,6 +413,11 @@ static int netkit_new_link(struct net *src_net, stru=
ct net_device *dev,
>  	if (IS_ERR(net))
>  		return PTR_ERR(net);
> =20
> +	if (!ns_capable(net->user_ns, CAP_NET_ADMIN)) {
> +		put_net(net);
> +		return -EPERM;
> +	}
> +

[Severity: Critical]
Does this ns_capable() call in netkit_new_link() introduce the confused
deputy vulnerability described above?

>  	peer =3D rtnl_create_link(net, ifname, ifname_assign_type,
>  				&netkit_link_ops, tbp, extack);
>  	if (IS_ERR(peer)) {

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 77e4b0d1ca557..6ffde7ee2119d 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
[ ... ]
> @@ -1854,6 +1854,11 @@ static int veth_newlink(struct net *src_net, struc=
t net_device *dev,
>  	if (IS_ERR(net))
>  		return PTR_ERR(net);
> =20
> +	if (!ns_capable(net->user_ns, CAP_NET_ADMIN)) {
> +		put_net(net);
> +		return -EPERM;
> +	}
> +

[Severity: Critical]
Does this ns_capable() call in veth_newlink() introduce the confused
deputy vulnerability described above?

>  	peer =3D rtnl_create_link(net, ifname, name_assign_type,
>  				&veth_link_ops, tbp, extack);
>  	if (IS_ERR(peer)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-pats-coif-=
316245c6@mheyne-amazon?part=3D1
