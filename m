Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285D33AEB4E;
	Sat,  3 Oct 2026 23:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791068444; cv=none; b=TJJR4B7WS8MfxYxDuufyHZUvOgkbYeFazYYon8O96N9jQd689dc7WdfsTCPeNwzRXpT5pIA+Ny3ahBkMPrXwN7O0JWuMU+aGv+1B/Wh6zhFXIy/aIrxH7byAimxe9R2s8M+uMMFAjbX+W//qi3IuCPMppTt2bN1DnjsPNBKCyxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791068444; c=relaxed/simple;
	bh=ozr1pGct8sZ1e3ofHQUeVlWgvWZlxwMC+u7f/qxjDCU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jnZXcYG6NCkwN5stTLrlkPEAK06BdLGQ1gE+ZT7IFtWNx0A0cCgXxssa+Z2w5zBblkelXPtSRkVKAqzG7eK9DbAORy7QSH++5Q4UBXXzpW6YzathO1zyoPJXggeOgBf7jeqISMmqToUIz/ViE7d2l0MeggiMnaPCykPM+uCE6zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3pURTVS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3pURTVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833951F0089D;
	Sat,  3 Oct 2026 23:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791068442;
	bh=wuhkYdIAkqjbbctqV5SZo/cc5Kw50f5heZOpqZaFFBc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l3pURTVSRJnmaW0HQev5l2uXXgOiZXqU0uyuwj5Nn/LeGjIeYmTNbtf+cdb6AcoVR
	 WTgsWz64vJKQPXA3s1CRcT2auOT/8oSHwaI15TgKk2AbZP1F31sCmDxCK6rvKQ+n+q
	 VFsYrH8mfRez69eH3nKurhkppsi2XGh0aEs1DJwq+MeVcnwe/2lKENL6lMm4DLX6an
	 t3nXvorcAg6PeKfQFQCz7OnOz2xziuRIjMSruvQgtIbnRX45+Bj9sJePwSmwlgZasJ
	 x67+AK2rL38vF0ut9CynY3YdW6/aA7o+C6D5iNhauvlSbzYbRBIkk2380lFU1fG0Q3
	 z071tvq01wlAw==
Subject: Re: [PATCH can-next 7/7] can: peak_usb: Add support of loopback mode
 to the PCAN-USB FD family
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, s.grosjean@peak-system.fr, kernel@pengutronix.de,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Sat, 03 Oct 2026 23:00:42 +0000
Message-ID: <179106844209.1406898.13531220510046899289@kernel.org>
In-Reply-To: <20261002-peak_usb_enhancements-v1-7-50e965755c06@pengutronix.de>
References: <20261002-peak_usb_enhancements-v1-7-50e965755c06@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch adds CAN_CTRLMODE_LOOPBACK to the static
  .ctrlmode_supported of all four FD-family adapters: pcan_usb_fd,…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but a malicious or
  faulty USB device that presents itself as a single-channel PCAN-USB FD…

--

can: peak_usb: Add support of loopback mode to the PCAN-USB FD family

This commit adds CAN_CTRLMODE_LOOPBACK to the supported modes of the
PCAN-USB FD, PCAN-Chip USB, PCAN-USB Pro FD and PCAN-USB X6 adapters. When
loopback is on, pcan_usb_fd_encode_msg() sets PUCAN_MSG_LOOPED_BACK and
PUCAN_MSG_SELF_RECEIVE in the uCAN TX message flags. This follows the
peak_pciefd driver, but local echo still comes from USB write completions.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> index 9081f30e3d356..59debe009f922 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -934,6 +934,12 @@ static int pcan_usb_fd_encode_msg(struct peak_usb_device *dev,
>  	if (dev->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
>  		tx_msg_flags |= PUCAN_MSG_SINGLE_SHOT;
>  
> +	/* Request controller loopback and mark the frame as self-received,
> +	 * matching the behavior of the peak_pciefd driver.
> +	 */
> +	if (dev->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
> +		tx_msg_flags |= PUCAN_MSG_LOOPED_BACK | PUCAN_MSG_SELF_RECEIVE;
> +
>  	tx_msg->flags = cpu_to_le16(tx_msg_flags);
>  	tx_msg->channel_dlc = PUCAN_MSG_CHANNEL_DLC(dev->ctrl_idx, dlc);
>  	memcpy(tx_msg->d, cfd->data, cfd->len);
> @@ -1263,7 +1269,8 @@ const struct peak_usb_adapter pcan_usb_fd = {
>  	.name = "PCAN-USB FD",
>  	.device_id = PCAN_USBFD_PRODUCT_ID,
>  	.ctrl_count = PCAN_USBFD_CHANNEL_COUNT,
> -	.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY |
> +	.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
> +			      CAN_CTRLMODE_LISTENONLY |
>  			      CAN_CTRLMODE_3_SAMPLES |
>  			      CAN_CTRLMODE_ONE_SHOT |
>  			      CAN_CTRLMODE_BERR_REPORTING |

[Severity: Low]
Does every firmware revision of these adapters support loopback?

LOOPBACK is added statically here, and also in pcan_usb_chip,
pcan_usb_pro_fd and pcan_usb_x6. All the new mode does is set
PUCAN_MSG_LOOPED_BACK | PUCAN_MSG_SELF_RECEIVE in pcan_usb_fd_encode_msg().
The host does not program any controller mode, and
pcan_usb_fd_decode_canmsg() never reads these flags. Whether the mode works
is therefore up to the firmware.

pcan_usb_fd_init() already gates modes that depend on the firmware:

	if (fw_info->fw_version[0] >= 2) {
		/* firmware >= 2.x supports ISO/non-ISO switching */
		dev->can.ctrlmode_supported |= CAN_CTRLMODE_FD_NON_ISO;

If a firmware revision ignored these TX flags, "ip link set canX type can
loopback on" would be accepted but would do nothing.

This may well be fine. ONE_SHOT is already advertised statically, and it
is also just a uCAN TX flag (PUCAN_MSG_SINGLE_SHOT). The non-FD driver's
pcan_usb_init() does gate LOOPBACK on device_rev >= 41, but it gates
ONE_SHOT the same way, so that comparison may not apply here. The commit
message also says all USB-to-CAN FD interfaces support this mode.

Is there any FD firmware version that should be excluded here?

[ ... ]

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Can a
single-channel adapter cause a NULL pointer dereference in the bulk-IN
decode path?

PCAN-USB FD and PCAN-Chip USB use ctrl_count = PCAN_USBFD_CHANNEL_COUNT
(1). struct pcan_usb_fd_if, however, has dev[PCAN_USB_MAX_CHANNEL] (2).
pcan_usb_fd_init() only fills the slot of the controller being registered:

	pdev->usb_if->dev[dev->ctrl_idx] = dev;

On those adapters, usb_if->dev[1] stays NULL.

Before dereferencing, pcan_usb_fd_decode_canmsg() only checks the channel
against the array size:

	if (pucan_msg_get_channel(rm) >= ARRAY_SIZE(usb_if->dev))
		return -ENOMEM;

	dev = usb_if->dev[pucan_msg_get_channel(rm)];
	netdev = dev->netdev;

A faulty or malicious device could send a PUCAN_MSG_CAN_RX record with
channel 1. That record passes this check, and the code then dereferences
NULL in URB completion context.

pcan_usb_fd_decode_status() and pcan_usb_fd_decode_overrun() use the same
pattern, for PUCAN_MSG_STATUS and PCAN_UFD_MSG_OVERRUN records.

pcan_usb_fd_decode_error() already handles this case. The guard came in
with "can: peak_usb: Add bus error reporting for the PCAN-USB FD family",
but it was added only to this decoder:

	/* Guard against bogus channel 1 reports from single-channel adapters.
	 * Treat the entire URB as invalid in that case.
	 */
	dev = usb_if->dev[pucan_ermsg_get_channel(er)];
	if (!dev)
		return -EINVAL;

Should the CAN_RX, STATUS and OVERRUN decoders get the same NULL check?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-peak_usb_enhancements-v1-0-50e965755c06%40pengutronix.de
