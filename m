Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00743468C1E
	for <linux-can@vger.kernel.org>; Fri, 31 Jul 2026 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516331; cv=none; b=F694mxZB4+frIbmZIw8++ikHXFUK54n/zUVbV5Z8OIEvpI80dSNU2TzzsQiDBk3E9376/vI6jmhfOkj+/WYP+2WzVA8uWiq3ntkBBo5V3B5LI3BWjMAvuY6/TN+WwdHi0z8hEgXfcawU/HOela1HcpEpjeAOoDKGiNzaaq5qjP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516331; c=relaxed/simple;
	bh=p7+bX/WJesJrNb5L+a1NZMfB7UU55LNF2i9QWGBRmo8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TWKm8xt0lygjfBx6p0ywOY62vo7IQSsRqFtdnKRdPmtapRB7lh6plRydO9yLiFAU0RwrQDHkgQSfjVVvG+1NqFWvSx05GBe3p+SPQoj8ogO6fqP7QbVgXgABA8SzjfaZEM/CdSJmZ98EtB0PZJ/vjvnWc4VSkFMuUJHsvl6YmXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfqOphlU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfqOphlU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500821F00AC4;
	Fri, 31 Jul 2026 16:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785516329;
	bh=KRkNNUVRWM3hjD3eJxxV/8cYjWNu7xthiOvCMR964rA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mfqOphlUeCoasvAfEGhG3m1iRC2wUbTvK9LOnvvTp687mAVa6D1lD2XmyBr1V2TU1
	 fnQO/2hUT5NteeZmGSO62vtB8ysAWcsNdEAFMNu0gnjTR/uKTk6+mCONx6LzDJ1MLJ
	 +Dn7FQp6H3z2cFk+oG6bj1pD/YkO7wbfrmZkMN21l/nyAItBhpZvjy5ZL5wORGMcky
	 OMbzYXSZ8m+0UNRjsNoSiQP/nxVTC4PuRNTk5zagE7SCdzbhlGfahJpHzuDNkle6od
	 +pB52g3IyG9jdDwuSzhChpcELBwyCtpz8GmZ5hYCSBQyVm+sOTimPb7yrtHAwxwFjM
	 OuWYxc7x3lLvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: dev: can_dropped_invalid_skb: drop CAN XL frames
 on non-CAN XL devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Mailhol" <mailhol@kernel.org>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260731-drop_canxl_frames-v1-1-7387b70353b3@kernel.org>
References: <20260731-drop_canxl_frames-v1-1-7387b70353b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 16:45:28 +0000
Message-Id: <20260731164529.500821F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `can_skb_init_valid()` directly modifies `skb->data` without check=
ing if the SKB is cloned or shared, violating SKB shared buffer rules and c=
ausing data corruption.
--

--- Patch [1]: [PATCH] can: dev: can_dropped_invalid_skb: drop CAN XL frame=
s on non-CAN XL devices ---
commit 4602c4bbb604b601116708346040725e0603f25d
Author: Vincent Mailhol <mailhol@kernel.org>

can: dev: can_dropped_invalid_skb: drop CAN XL frames on non-CAN XL devices

Sending a PF_PACKET bypasses the CAN framework logic and can directly
reach a CAN driver's xmit() function. The PF_PACKET framework only
checks that skb->len does not exceed the net_device MTU.

For a CAN device that is not CAN XL capable, anything above CANFD_MTU
(72 bytes) is therefore dropped before it reaches the driver. However,
CAN XL frames are variable length. can_is_canxl_skb() accepts lengths in
the range CANXL_HDR_SIZE + CANXL_MIN_DLEN up to CANXL_MTU, i.e. 13 to
2060 bytes.

As a result, an ETH_P_CANXL skb with a length between 13 and 72 bytes
can pass both the MTU and the can_dropped_invalid_skb() checks.

A driver that does not support CAN XL will interpret canxl_frame->flags
as a length because of the overlap with can_frame->len. And because
CANXL_XLF is set, the resulting length is between 128 and 255. For
drivers that do not check can_frame->len before copying can_frame->data,
as most drivers do, this results in a buffer overflow of up to 247
bytes.

Drop ETH_P_CANXL skbs if the device does not have the CAN_CAP_XL
capability. Keep can_is_canxl_skb() for the validation of CAN XL skbs.

Closes: https://sashiko.dev/#/patchset/20260731-master-v5-0-5b27029dee20@qq=
.com?part=3D1
Fixes: fb08cba12b52 ("can: canxl: update CAN infrastructure for CAN XL fram=
es")

> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index 95fcdc1026f80..4f7a189de265d 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c

[ ... ]

> @@ -384,7 +385,7 @@ bool can_dropped_invalid_skb(struct net_device *dev, =
struct sk_buff *skb)
>  		break;
> =20
>  	case ETH_P_CANXL:
> -		if (!can_is_canxl_skb(skb))
> +		if (!can_cap_enabled(dev, CAN_CAP_XL) || !can_is_canxl_skb(skb))
>  			goto inval_skb;
>  		break;

[Severity: High]
This isn't a bug introduced by this patch, but looking at can_skb_init_vali=
d()
which is called right after this switch statement:

drivers/net/can/dev/skb.c:can_skb_init_valid() {
    ...
		/* set CANFD_FDF flag for CAN FD frames */
		if (can_is_canfd_skb(skb)) {
			struct canfd_frame *cfd;

			cfd =3D (struct canfd_frame *)skb->data;
			cfd->flags |=3D CANFD_FDF;
		}
    ...
}

Can this modification of skb->data happen without ensuring exclusive owners=
hip
via skb_unshare() or skb_cow_head()?

If a local user constructs a linear CANFD packet via AF_PACKET, which is th=
en
cloned (e.g., via TC mirred or BPF redirect) and queued to a CAN interface,=
 it
seems can_skb_init_valid() will directly modify cfd->flags in the shared da=
ta
buffer.

Since the network core's validate_xmit_skb() does not unclone an already-li=
near
SKB, could this corrupt other users of the same buffer data and lead to sil=
ent
data corruption in unrelated code paths?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-drop_canxl=
_frames-v1-1-7387b70353b3@kernel.org?part=3D1
