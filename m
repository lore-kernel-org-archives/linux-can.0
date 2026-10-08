Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4052447F3DC
	for <linux-can@vger.kernel.org>; Thu,  8 Oct 2026 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452215; cv=none; b=otB/KXcmYUVMeX1/OkCtV03U6FZgKmBib7X66urWdGH2WN/AJfcyXEqqHOPsmFGwjFS0aMmzqiiJ+1J37NS9cEZH4rjNAVFZ3x5u6rtOewScql/9hINxrMyjcYHoCvu+OCAGVlJvb3BlzpFZiy2pB6CYo5z8PFU2PwhFzLHb6DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452215; c=relaxed/simple;
	bh=GMDJBoHE4iwhFFerlAQ0uwhC+xQNNzr6ZQ0KDIzFBjU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ezu8xp5u9S10iZb9K3ohaIFsowDEtJTzq2K7elY7EVz3QRSGYICyiTtQT7JZvqcDW2mAm50W1K0EKqVIpGR3oCFfp78wy7SyCXCEPUKNVbx/RT1QtwfNVdYXSgCfq6636yJJsxOiT5pfLG+qlW6yJQcL/XsxMX0DV37PSzA0hXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV9eUlBe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV9eUlBe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E6B1F000FF;
	Thu,  8 Oct 2026 09:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791452213;
	bh=rzsYtF/HgZNorC25jqL7l1VA1dc8wnborSHKBNijo0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WV9eUlBekFxFYA3dTEMlKB6dJHtu0ummTItfqhKrMXEsAtVv7oPFnE5Dc8Y+0MZ9+
	 JQThEHrWB5fh9kJgisGngYGPjh/I5q+zEENBnduNfkdvN+nZEieB5ctOjgicmRV+JL
	 2Z8yLQBTJcF5GErD2ju1/ybgY4jTrsXtc9C7IMUBfGQXdX7JOH24YVGW0k5S24ubpy
	 VMg4r9JQasyVJQfgL1ZYgaR6AvxHvZvKi3cOdq7nl5Wrj/h2H4JE0YRi5TsCC4EQ9d
	 8V2Ghaz7esq7a3aubftS4SuMLjfzz03GwxW+FfS13/pKiEd/bEcAPXkYT6Z28L1Tht
	 VFLniFX1sJKdA==
Message-ID: <sashiko-outbox-163954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] can: peak_usb: validate channel numbers in PCAN-USB
 FD
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <stephane.grosjean@free.fr>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20261008-canfd_check_channel_idx-v1-4-0a3bb82f4e09@peak-system.fr>
References: <20261008-canfd_check_channel_idx-v1-0-0a3bb82f4e09@peak-system.fr>
 <20261008-canfd_check_channel_idx-v1-4-0a3bb82f4e09@peak-system.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 09:36:52 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: peak_usb: missing NULL check on sibling channels leads to UAF=
 and NULL deref
--

commit bb6a3841806ddddd6a5d411fd8594a762ea452bd
Author: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>

can: peak_usb: validate channel numbers in PCAN-USB FD

This patch adds validation for CAN channel numbers encoded in messages
received from PCAN-USB FD devices. The channel number is checked against
the number of controllers supported by the adapter to prevent out-of-bounds
array accesses.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can=
/usb/peak_usb/pcan_usb_fd.c
> index 82502594a4092..ddbb2be1de0dd 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
[ ... ]
> @@ -536,8 +537,12 @@ static int pcan_usb_fd_decode_canmsg(struct pcan_usb=
_fd_if *usb_if,
>  	struct sk_buff *skb;
>  	const u16 rx_msg_flags =3D le16_to_cpu(rm->flags);
> =20
> -	if (pucan_msg_get_channel(rm) >=3D ARRAY_SIZE(usb_if->dev))
> -		return -ENOMEM;
> +	/* Reject invalid channel numbers reported by the firmware.
> +	 * Any channel below ctrl_count is guaranteed to have a valid
> +	 * entry in usb_if->dev[].
> +	 */
> +	if (pucan_msg_get_channel(rm) >=3D usb_if->adapter->ctrl_count)
> +		return -EINVAL;
> =20
>  	dev =3D usb_if->dev[pucan_msg_get_channel(rm)];
>  	netdev =3D dev->netdev;

[Severity: High]
Does this actually guarantee that the usb_if->dev[] entry is valid?

Since sibling channels are initialized sequentially during device probe, can
this lead to a NULL pointer dereference? For example, if can0 is brought up
and receives a message from the shared USB endpoint with a channel number
for can1 before can1 completes its initialization, usb_if->dev[channel]
might still be NULL, causing a crash when accessing dev->netdev.

Additionally, what happens during device disconnect? If peak_usb_disconnect=
()
frees sibling channels in reverse order (e.g., can1 then can0), the freed
channel's pointer seems to remain in the shared usb_if->dev[] array. If can0
is still active and receives a message for the freed channel, could this
result in a use-after-free?

This same pattern appears to be repeated in pcan_usb_fd_decode_status(),
pcan_usb_fd_decode_error(), and pcan_usb_fd_decode_overrun() modified
further down in this patch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-canfd_chec=
k_channel_idx-v1-0-0a3bb82f4e09@peak-system.fr?part=3D4
