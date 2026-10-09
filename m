Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9544998E
	for <linux-can@vger.kernel.org>; Fri,  9 Oct 2026 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531995; cv=none; b=Yn1eEh1KJiodmV1Isl0upMAIKHj9SK5Q90XFMsEFR0bm5can3752uxedRNA6/94G18mkUAicvVU4eRnTqEmaKeqI0A2bqDf5WY3aQcXe2dnGRDuXbmkaKR/TmXMpDfxjf9p4vK5Ea/38J02Axq3ccf5MODde2XK2UU2gmV8o+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531995; c=relaxed/simple;
	bh=a9YGZZqIn7zWlUyQKA83kzTexIMxrbcDQ+/Xl3fnBYY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=B6ZkU316yTD8V/nT1NNhQiWz2PCFhe8dcYDLIWCYp8VymICs6bWX2nWD0BgSGI1oki9lX/n8qNk7x11rWQJjEde0xzxS5+2oCeboSZqyLAmn4hdYmsxsrTVC6YhGJR3ZCtjTay7vNT9Ke2MYfdMdYst5aEMXoLD9WFGj1/vbpU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuILD9bl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuILD9bl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6D11F000FF;
	Fri,  9 Oct 2026 07:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791531994;
	bh=O0q1TzXZkLBboyeH1ro5z/7E6eXhofr/hEkeXLx6Xsg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FuILD9blPvN3fDv+tUCdidJxIGotkYWn43PJ1LVRE9zb09YXOuPtTTzUsFvcmmLQp
	 aZZ0NBT2OX9MZ6CVAuEeiI6T/Q7KQRN2hvb8LkRWpcY09z+Elbjy9BRxuuWNX9+Z4O
	 V+3mzS+yViN/33pKvo2/Otl/u6K4DTDQNTO1pHUJzOAxHrLTHR13OqnxhiO9+Ae1fF
	 XlWYHeVyVPoCQCZ/NJVpu/x+a6CxNA/vxX9fi0ILoBcf1OIyplAu301e8huFwcunj3
	 8grbqrTv8nTH3PI7I+44FMsOCmgMfIJzrO9SbgGM7rfFTXl7yxZcbvpwtBzf4xTasm
	 BQJHccXucY3Gw==
Message-ID: <sashiko-outbox-165031@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] can: peak_usb: validate channel numbers in
 PCAN-USB FD
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <stephane.grosjean@free.fr>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20261009-canfd_check_channel_idx-v2-4-f7b772929791@peak-system.fr>
References: <20261009-canfd_check_channel_idx-v2-0-f7b772929791@peak-system.fr>
 <20261009-canfd_check_channel_idx-v2-4-f7b772929791@peak-system.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 07:46:33 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] can: peak_usb: TOCTOU race in peak_usb_disconnect() allows UAF of =
sibling devices
- [High] can: peak_usb: UAF in RX path due to dangling sibling pointer on p=
robe failure
- [Medium] net/can: undocumented structural fix in disconnect path
--

commit 5ae27b339d4e54171f73db600b5e74ef68206d48
Author: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>

can: peak_usb: validate channel numbers in PCAN-USB FD

The PCAN-USB FD family encodes the CAN channel number in messages
received from the device. This value is used as an index into the
adapter CAN device table. This commit validates the channel number
against the number of CAN controllers supported by the adapter before
performing the lookup.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/c=
an/usb/peak_usb/pcan_usb_core.c
> index 55aad01cd8cac..751cd52cb5486 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> @@ -1038,7 +1038,17 @@ static void peak_usb_disconnect(struct usb_interfa=
ce *intf)
>  	struct peak_usb_device *dev;
>  	struct peak_usb_device *dev_prev_siblings;
> =20
> -	/* unregister as many netdev devices as siblings */
> +	/* First, kill all pending RX URBs. usb_kill_anchored_urbs() waits
> +	 * until all completion handlers have completed, ensuring that no
> +	 * decode_buf() callback can access usb_if->dev[] after this point.
> +	 */
> +	for (dev =3D usb_get_intfdata(intf); dev; dev =3D dev->prev_siblings)
> +		usb_kill_anchored_urbs(&dev->rx_submitted);

[Severity: Medium]
The commit message states the patch only adds channel number validation to =
the
PCAN-USB FD receive path. However, this diff introduces a concurrency fix in
peak_usb_disconnect() that kills all pending RX URBs across all channels be=
fore
unregistering devices.

Should this structural fix be documented in the commit message or split int=
o a
separate patch?

[Severity: High]
This added loop drains RX URBs to prevent UAFs, but runs without holding
rtnl_lock or updating state that would prevent new URB submissions.

Could a concurrent `ifconfig up` call peak_usb_start(), allocating and
submitting new RX URBs that bypass this kill loop?

> +
> +	/* All RX URBs have been drained before reaching this point. No
> +	 * decode_buf() callback can access usb_if->dev[] anymore, making it
> +	 * safe to unregister and free the associated netdevs.
> +	 */
>  	for (dev =3D usb_get_intfdata(intf); dev; dev =3D dev_prev_siblings) {
>  		struct net_device *netdev =3D dev->netdev;
>  		char name[IFNAMSIZ];

[ ... ]

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can=
/usb/peak_usb/pcan_usb_fd.c
> index 82502594a4092..71ac6fdcd99be 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c

[ ... ]

> @@ -536,10 +537,19 @@ static int pcan_usb_fd_decode_canmsg(struct pcan_us=
b_fd_if *usb_if,
>  	struct sk_buff *skb;
>  	const u16 rx_msg_flags =3D le16_to_cpu(rm->flags);
> =20
> -	if (pucan_msg_get_channel(rm) >=3D ARRAY_SIZE(usb_if->dev))
> -		return -ENOMEM;
> +	/* Reject invalid channel numbers reported by the firmware */
> +	if (pucan_msg_get_channel(rm) >=3D usb_if->adapter->ctrl_count)
> +		return -EINVAL;
> =20
>  	dev =3D usb_if->dev[pucan_msg_get_channel(rm)];
> +
> +	/* This should never happen during normal operation. However, do not
> +	 * trust the device and reject records targeting a valid channel
> +	 * without an associated netdev.
> +	 */
> +	if (!dev)
> +		return -EINVAL;

[Severity: High]
If new RX URBs bypass the kill loop in peak_usb_disconnect() as mentioned
above, they could remain active while sibling devices are sequentially free=
d.

If one of those URBs receives a packet targeting an already-freed sibling,
does it result in a use-after-free here, since usb_if->dev[] is never clear=
ed?

Also, could this check fail to protect against a dangling pointer left by a
probe failure?

For example, pcan_usb_fd_init() populates the shared array with the device
pointer. If peak_usb_create_dev() then fails for a sibling device, its error
path frees the device but does not clear the usb_if->dev[] entry. Since this
check assumes unassociated slots are NULL, could an RX packet targeting the
failed channel result in a use-after-free?

> +
>  	netdev =3D dev->netdev;
> =20
>  	if (rx_msg_flags & PUCAN_MSG_EXT_DATA_LEN) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-canfd_chec=
k_channel_idx-v2-0-f7b772929791@peak-system.fr?part=3D4
