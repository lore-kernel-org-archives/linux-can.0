Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B56447807
	for <linux-can@vger.kernel.org>; Thu, 27 Aug 2026 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832654; cv=none; b=IQKCNSatd1rgLGhLfFX7s5C40KVnn4u7jZ//6GTHnxQXNOo6gdafYr6Njqmz58f1yxo/5On1MkuB9KgLg0Ur8SHcTwOewIGn7yRANxgoXnlPpshiCXRDNnPXathv1y8GV2xTpDZ6a5NHeRMbaF2GIOjx9e8s2/XoVmC48KOS1mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832654; c=relaxed/simple;
	bh=YS3QdjyGSfyYUfTjxchncXWdb5iYba/jiZPljLnnd7w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GwGP2TBIWkU6KlFmghtKBIWciX5PwxpclGZjB18oLkZxRbd4i8JCjpMjHnDBXZq5Sq8t3lPiD/xcBS//F5XnKYMZBC9gErwvV0DXAXPAJ4EZOgcsaIDqyu+MXK3+Lcb7TB4XtzyvEmukUX0hm3QtPieSApxJCi+BYpo9HG2eNjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJoWuONM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJoWuONM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975831F00A3D;
	Thu, 27 Aug 2026 12:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787832652;
	bh=uNLvJQ1zhMrfqAvrZg2KaF7ZCfP6QXfiCm8gpOdkjuI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VJoWuONMMZ2fOKbTl1XoTOqHiSxSHFvKAc3fm67QXtPRs1OxRiyNO/FZbxh6lT+Sr
	 Uym9l7LuMUJ00uly0V/kSc9767sXRuAyi5pT24D2jdzMf92AoDCNUuyGbh4czOqWTr
	 jMMbPB73yQ2nxe7qlws56xa3eNPGHHSujuRoRcQ68zMR0Nxdz1FWzxzcL9/y3xD7p9
	 4IutCoywO2rRkz1mVeN0BfMGHTlKdt4doqs68llpW7fwHC0W41HR+4y7OrGqOVJAN+
	 e8TkaBxLIdSTqeNL/+ApB3RWNZl98vQ8txu2o3Lb3SGpAm6EWz1Qw3WVaTNBJ1/Uas
	 89XFhSHv6ePMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 10/14] can: dev: can_put_echo_skb(): free skb on
 invalid echo index
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260826121036.2706424-11-mkl@pengutronix.de>
References: <20260826121036.2706424-1-mkl@pengutronix.de>
 <20260826121036.2706424-11-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 12:10:52 +0000
Message-Id: <20260827121052.975831F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Modifying SKB payload in can_skb_init_valid() without unsharing ca=
uses data corruption for concurrent observers.
--

commit 6a48fe2d96b6f1ca706da34b2f7bdd872d06941f
Author: Cunhao Lu <1579567540@qq.com>
can: dev: can_put_echo_skb(): free skb on invalid echo index

This patch fixes a potential leak in can_put_echo_skb() when the echo index
is out of bounds. It ensures the socket buffer is freed before returning
-EINVAL so that all error paths correctly consume the SKB.

Link: https://patch.msgid.link/tencent_683AA16E643DE00211CD2FB62991264DC605=
@qq.com

> diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
> index c7be21ed70ddf..faafb1033d423 100644
> --- a/drivers/net/can/dev/skb.c
> +++ b/drivers/net/can/dev/skb.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but already existed in the
codebase. Does can_skb_init_valid() in this same file modify shared memory
without unsharing it first?

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

If a user with CAP_NET_RAW injects a CAN FD frame via an AF_PACKET socket,
the packet goes to dev_queue_xmit() where it may be cloned for packet
sniffers like tcpdump.

When the original SKB reaches the driver's transmit function and calls
can_dev_dropped_skb() -> can_dropped_invalid_skb() -> can_skb_init_valid(),
it modifies the payload (cfd->flags |=3D CANFD_FDF) without verifying
skb_cloned(skb) or calling skb_unshare().

Can this cause data corruption for concurrent observers receiving the clone=
s?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826121036.2706=
424-1-mkl@pengutronix.de?part=3D10
