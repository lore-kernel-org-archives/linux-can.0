Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE00A39A07D
	for <linux-can@vger.kernel.org>; Thu, 18 Jun 2026 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771287; cv=none; b=PEE4MszrmqkOYjkCLFvC0gJtqMyLWiY0QrcqX6+cfkrpYaIlt5dFacv8pPFamFQkTk2cqAdB2LtVBdo4nTY6tdf3pT+7/qeMao4N0lshBxBmPh13XfyY4glJK9fsrAHV2d8P+OlOkqFujf1HhyOqBcD+kWYloIw/JWRo9W+4dVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771287; c=relaxed/simple;
	bh=FUrSYnK8WGW1DiEYrCuzXNl+E7/t4VPTyxsQWMlNM7o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jVdCIuu8jT8r/P5KgfB0NkQzsuYpuSJHevFPI8lwg3ZdRpEMuQMvt3U+YN+8ldLUb5gt/JLEu59GHrVi9zU77dKlg4wdQum479frp8LrKo0XU4PG6k0Db72Oa1A9iT3zOZOT+YKYiyKMlVOJyl39RZXW3zMkshU0Qz2KJbO2KKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC321LAV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC321LAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4123D1F00A3A;
	Thu, 18 Jun 2026 08:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781771286;
	bh=l0fylYSfbRnLcVDcfslexYZV7NNu5hthcOKJyuQUSZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AC321LAVV+bmgP9PqFnIko85/lz94Lsbrw6xJs8u3H1YQJ2CD3plZckUnKlpOlhyU
	 glI4F3NWUQFkfvYhUkVjN9BH72nH0Jt83p/1AthluFyIZ+Xo3GAnnHsmK0A8lx/HUO
	 wQRSCTsaw198nizNUorC0BDqMQIJ/Ir/LnSbXYuQ3WCIxd4E2ppoJAg8SR6DKnFFft
	 /Jn7tqUZqeb1UkaFoECT17j6VSI+leEaAFPiHp8RtJsQpnNNMCvb+f0Yks2caf8JQ6
	 jWjsfMwdkOx8+nhkuaIUWX1YWEMoMXpE23ebHhBAeJHjX6n/31naFOxFWL7BOX7h7e
	 68w9yQjVjfjAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y] net: add missing ns_capable check for peer netns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maximilian Heyne" <mheyne@amazon.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260617-forgot-manic-27dda774@mheyne-amazon>
References: <20260617-forgot-manic-27dda774@mheyne-amazon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 08:28:05 +0000
Message-Id: <20260618082806.4123D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Approximating `netlink_ns_capable()` with `ns_capable()` introduce=
s a confused deputy vulnerability by omitting the netlink socket opener cre=
dential check.
--

commit a7cbbc451870d23c0dbb2059e0abb94c500f495c
Author: Maximilian Heyne <mheyne@amazon.de>

net: add missing ns_capable check for peer netns

This commit attempts to fix CVE-2026-31692 by approximating
netlink_ns_capable() with ns_capable() directly in the vxcan and veth
interface types, as the upstream fix doesn't apply cleanly to older stable
kernels.

> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> index afd9060c5421c..8a61011fdaeef 100644
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c
> @@ -198,6 +198,11 @@ static int vxcan_newlink(struct net *net, struct net=
_device *dev,
>  	if (IS_ERR(peer_net))
>  		return PTR_ERR(peer_net);
> =20
> +	if (!ns_capable(peer_net->user_ns, CAP_NET_ADMIN)) {

[Severity: High]
Does approximating netlink_ns_capable() with ns_capable() here introduce a
confused deputy vulnerability?

netlink_ns_capable() ensures that both the opener of the netlink socket and
the current sender have the required capability. By directly using
ns_capable() in vxcan_newlink(), the netlink socket opener credential check
appears to be bypassed.

Could an unprivileged attacker open a netlink socket, connect it, and trick
a privileged SUID process into writing a crafted RTM_NEWLINK payload to it?

Since the SUID process performs the write, ns_capable() would see the
privileged credentials and succeed, potentially allowing the unprivileged
attacker to bypass the security fix and create devices in arbitrary
privileged network namespaces.

> +		put_net(peer_net);
> +		return -EPERM;
> +	}
> +
>  	peer =3D rtnl_create_link(peer_net, ifname, name_assign_type,
>  				&vxcan_link_ops, tbp, extack);

[ ... ]

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index cfacf8965bc59..c644d59d70900 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1664,6 +1664,11 @@ static int veth_newlink(struct net *src_net, struc=
t net_device *dev,
>  	if (IS_ERR(net))
>  		return PTR_ERR(net);
> =20
> +	if (!ns_capable(net->user_ns, CAP_NET_ADMIN)) {

[Severity: High]
Does this ns_capable() check in veth_newlink() have the same confused
deputy vulnerability as the one in vxcan_newlink(), allowing a bypass of
the socket opener credential check?

> +		put_net(net);
> +		return -EPERM;
> +	}
> +
>  	peer =3D rtnl_create_link(net, ifname, name_assign_type,
>  				&veth_link_ops, tbp, extack);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-forgot-man=
ic-27dda774@mheyne-amazon?part=3D1
