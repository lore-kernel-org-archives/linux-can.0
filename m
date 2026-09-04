Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E133E5A1D
	for <linux-can@vger.kernel.org>; Fri,  4 Sep 2026 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539330; cv=none; b=izYiMXXVELe4lI0zX5+B+nykLmqkYqCQ+dyOsQCDXqvMwgWISJiXe3Ay7kJ2DefUVuPDlDxu+CTGJKEvT/2XW+N6RmDBO6I2pHa+4lQ6DNaeSESnY2PSgoHwkbR7hER1xHhZkLsZtddFApc6k7Gi6rnRwqeqeMbY2QVCxtWytE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539330; c=relaxed/simple;
	bh=K7HCdygcfuxD0i7X1ku+pxuKaOfxVYCDD9gsnbeLI0U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TncQYoTgrJu5O8kBjhgqBYYXV8huIHWULXYNOJ5sRYUQcvgULUpKk+0cMkFQTA9vLb0wNUsi51YeooVtjQZo4Dni2izrJzaW2y7N0pXGav3KY+x2e9O2I7bLExUG21BEQEk/ylc2l/4iSCWMDoBEH6Ib7luWMrJkZxKxoZMGTdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzmCu1aT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzmCu1aT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5831E1F00A3D;
	Fri,  4 Sep 2026 16:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788539328;
	bh=16d+lV4gT1UtaUNij1siiNnTn0hOqiD7JGT339Z6y6o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nzmCu1aTde/3LmRYTzzDs2D2yO5xsPfXe/vU6uMmMYjVXKReJO2RyzXBFr0tyPkQl
	 MV7p8m+kNPVjs/QjTHlvPDszuU4vf7zf9aX6C0bNdEgbr/OW1egC8lQDXbVUYPJlrQ
	 qATx5UoSfLD/oHBvSeoOr2KViju45MMFuBhpfrU6SyOFkhD1ZG1WLzOwfQ86+hrvVr
	 e/Jq9eWgAquOjvoCrfiylrJrHbMXXGAOXWbKiyQ9FqhsiWsLeyLT9f/06j1RzfsD2j
	 qM5vxwPTr/CvJhPguZFQljd70oKla9MJ2MN41LJ7kbtj5TtYWMLTcr2slzzxUwvhaw
	 9gejrOwbUoE8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] can: netlink: fix IFLA_CAN_BITRATE_MAX attribute
 sizing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhu Ling" <zhuling0805@qq.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <tencent_D1C873B86B0E92011A264B0E196B911D5308@qq.com>
References: <tencent_D1C873B86B0E92011A264B0E196B911D5308@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 16:28:47 +0000
Message-Id: <20260904162848.5831E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing netlink payload size underestimation in `can_pwm_get_=
size()` when PWM capabilities exist but `CAN_CTRLMODE_XL_TMS` is disabled, =
leading to `-EMSGSIZE` when filling the response.
--

commit 9a3cf7f66d6ea7a9d4aba48ff7c5376d72db7fe3
Author: Zhu Ling <zhuling0805@qq.com>

can: netlink: fix IFLA_CAN_BITRATE_MAX attribute sizing

This commit fixes an issue in can_get_size() where the size for
IFLA_CAN_BITRATE_MAX was missing the netlink attribute header overhead. By
using nla_total_size(), it prevents -EMSGSIZE errors when the skb has no sl=
ack
left.

> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 766d455950f55..ba26c61a82c2f 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -822,7 +822,7 @@ static size_t can_get_size(const struct net_device *d=
ev)
>  	if (priv->bitrate_const)				/* IFLA_CAN_BITRATE_CONST */
>  		size +=3D nla_total_size(sizeof(*priv->bitrate_const) *
>  				       priv->bitrate_const_cnt);
> -	size +=3D sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
> +	size +=3D nla_total_size(sizeof(priv->bitrate_max));	/* IFLA_CAN_BITRAT=
E_MAX */
>  	size +=3D can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
> =20
>  	size +=3D can_data_bittiming_get_size(&priv->fd,

[Severity: High]
This isn't a bug introduced by this patch, but while looking at
can_get_size(), I noticed another potential size underestimation just below
this diff in can_pwm_get_size():

drivers/net/can/dev/netlink.c:can_pwm_get_size() {
	if (!pwm_const || !pwm_on)
		return 0;
	...
}

If a CAN interface has hardware PWM support (pwm_const is non-NULL) but PWM=
 is
currently disabled (pwm_on is false), can_pwm_get_size() returns 0.

However, can_pwm_fill_info() only checks pwm_const:

drivers/net/can/dev/netlink.c:can_pwm_fill_info() {
	if (!pwm_const)
		return 0;

	nest =3D nla_nest_start(skb, IFLA_CAN_XL_PWM);
	...
}

Could this mismatch cause can_pwm_fill_info() to write 52 bytes that were n=
ot
accounted for by can_get_size() when CAN_CTRLMODE_XL_TMS is disabled?

If so, could this also overflow the skb and cause nla_put() to fail with
-EMSGSIZE, breaking interface notifications and queries like 'ip link show'
for such devices?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_D1C873B86B0=
E92011A264B0E196B911D5308@qq.com?part=3D1
