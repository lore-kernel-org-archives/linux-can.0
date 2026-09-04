Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A675A36D500
	for <linux-can@vger.kernel.org>; Fri,  4 Sep 2026 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536447; cv=none; b=GlNev4+7CRV29DnzHYDeMnqRy1BBLpI1PP/xthjUEPGpIIYdIsCgnhCTlhWlNxbL3JMftA9/guixVrqjN6ZEfJRVLIqNrHnuZp2jqas6lT+oDU1U3CMQqHvyJhHLaWMgggrpETgQwV7EyayBwvLRbPwEdSjtdjcpIsSJdQlEx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536447; c=relaxed/simple;
	bh=qMH8BnzvXF6SF2Q392dMQR0qlkk6CWw1Ynk2U4uk+WY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pSMWCsQGdtmH9pVCfMIfLBXxFRsJTykm6iXdUWbFIdxVQNzxwiqx9LE+L7F4oncQbW9Gk7owhwHPxd+LUMTuKpac82CvEro66FAue+egHgNgy5J+FCzTjHgRrhl9aHNzjSrlCDy8UDWQg+mhdvvzYjc/toJmjiODVa5/4YhB6Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gekFWrYh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gekFWrYh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E548A1F00A3D;
	Fri,  4 Sep 2026 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788536446;
	bh=rNrUoCply4YCRVum1Qe0eA0BZuIm66uH5jLWwc5kxJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gekFWrYhYn74YXdWrnVpqSmfM85wwDabbU2bfvvAfCZsF0b4vUM65rXjpmk5ZELxp
	 tO2nubvVsaOCeitmcAAcUjupSJVnfdSCAd4wrPQXAuWn6bCMwOG4OOT6KhZhS1dK82
	 Jb1NJNXgov3r/ZGSij44jcdzTNozdsiPotG2sikFYs0QySlf92Y6Dg/PXxxGUirPgz
	 8HgFbGiZJiTkkXrQWH1m728RtJG2TCIOChHg+VaVj3vMr4BpNjTJE+Y8+uVS5HeGpA
	 KHNofzsHafqBi34FltfT4NPuJGjt9YcmlIIG2zYsBtltQEIXMpqp+yHmyw1BNXP9XH
	 pgXz+ePm98HQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] can: netlink: fix CAN XL PWM attribute sizing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhu Ling" <zhuling0805@qq.com>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <tencent_9A525E0656A4F7D4CA9CFA1AB1A4BFC6D706@qq.com>
References: <tencent_9A525E0656A4F7D4CA9CFA1AB1A4BFC6D706@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:40:45 +0000
Message-Id: <20260904154045.E548A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] can_get_size() underestimates the netlink message size by not usin=
g nla_total_size() for the IFLA_CAN_BITRATE_MAX attribute.
--

commit 65a98e250b77c16c65b20dbe5d32fe88f1c06e1b
Author: Zhu Ling <zhuling0805@qq.com>

can: netlink: fix CAN XL PWM attribute sizing

can_pwm_fill_info() emits the PWM capability limits whenever pwm_const is
present, regardless of whether TMS is enabled. In contrast,
can_pwm_get_size() currently returns zero when TMS is disabled. It
therefore underestimates the required netlink message size by the nested
attribute header and six u32 attributes.

Always account for the PWM capability attributes when pwm_const is
present, and account for the three runtime PWM values only when TMS is
enabled.

> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 766d455950f55..0eac5a3f577ec 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -780,7 +780,7 @@ static size_t can_pwm_get_size(const struct can_pwm_c=
onst *pwm_const,
>  {
>  	size_t size;
> =20
> -	if (!pwm_const || !pwm_on)
> +	if (!pwm_const)
>  		return 0;
> =20
>  	size =3D nla_total_size(0);			/* nest IFLA_CAN_PWM */

[ ... ]

> @@ -792,9 +792,11 @@ static size_t can_pwm_get_size(const struct can_pwm_=
const *pwm_const,
>  	size +=3D nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWMO_MIN */
>  	size +=3D nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWMO_MAX */
> =20
> -	size +=3D nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWMS */
> -	size +=3D nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWML */
> -	size +=3D nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWMO */
> +	if (pwm_on) {
> +		size +=3D nla_total_size(sizeof(u32));	/* IFLA_CAN_PWM_PWMS */
> +		size +=3D nla_total_size(sizeof(u32));	/* IFLA_CAN_PWM_PWML */
> +		size +=3D nla_total_size(sizeof(u32));	/* IFLA_CAN_PWM_PWMO */
> +	}
> =20
>  	return size;
>  }

[Severity: High]
This is a pre-existing issue, but while looking at the netlink message size
calculations, I noticed a potential under-allocation in the caller:

drivers/net/can/dev/netlink.c:can_get_size() {
	...
	if (priv->bitrate_const)				/* IFLA_CAN_BITRATE_CONST */
		size +=3D nla_total_size(sizeof(*priv->bitrate_const) *
				       priv->bitrate_const_cnt);
	size +=3D sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
	size +=3D can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
	...
}

Does the IFLA_CAN_BITRATE_MAX size calculation underestimate the required
netlink message size? It appears to add only the payload size instead of
wrapping it in nla_total_size() to account for the NLA header.

If the allocation doesn't happen to have enough slack to cover the calculat=
ion
error, couldn't this cause userspace netlink requests (like `ip link show`)=
 to
randomly fail with -EMSGSIZE and truncate the response?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_9A525E0656A=
4F7D4CA9CFA1AB1A4BFC6D706@qq.com?part=3D1
