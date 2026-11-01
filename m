Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499332;
	b=TjDMN7dPEgU6rFF7YsbkLOMJNvUYEBapyHRlO6PaNJze5kFu8cSD0J0OBYRU95kR3sfi
	 VCUOAO3aT5aCdbY7bm3CKWtTXWVSzluDUZ9yiFKI48I1y5xtO2AA2oM59SZV9XDmFrErl
	 ayZndQHgDirqxBfABiUT2+ADQ1W1kPU/GtBPzhl73fwK8KdOBylIlW+jBKBBfr/I1oMOe
	 aWeN8vrlxYLlgasn4kHxYwbeQpIoTjoM8wtkdi10MHw8rXXHYmtrIN6zwAhcZDI0ROttE
	 enGQXX44hunJFLY62UH8mUPULUeOpFyOCRPf/w3o/8NDKj1xTEUM9+pcZ3QCYdIRndA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499332;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pGb/TcMAboBwB3Sj+01ezuTRZ9UzgOLsqeFKfsEFeQw=;
	b=JQ8VwGYVYm9S/BO0YCXCu9Tt2OfzaxymR8GVR++hOTw+0EEsoLFGVpi0Z9TCVL8uCeHL
	 xZ5KV/euh8/mfrrXbSWYAdhNqBixibBz9bsm3V++X6f3lfEqXVWAwB3XuS4SDQZjL7bJL
	 rAezmb/24HLo9qGdHAEjoGT+SrxsoTb4myBEblAP+65fQJKsQyD5ULFW1yUsl5M/+ar96
	 LY0ti7WUy/ypKlVjJWuo4eHoRE7hA7KtlkIGuWIC6T7vZh1FyBBsapCnkmP6tl/I1yqt0
	 oU02kkQj1y5c6KNnhHJ/lAD5mY/2D/64K2TWexHVWA/xyS70/EUQpcvGUVTi1ZWvrkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MI74K84u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CB0606A335;
	Sun,  1 Nov 2026 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MI74K84u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F92B1F00919;
	Sun,  1 Nov 2026 02:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793499332;
	bh=pGb/TcMAboBwB3Sj+01ezuTRZ9UzgOLsqeFKfsEFeQw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MI74K84uSPMHvsO4upj+Fi9xBK4legbXc3FAye3IF4i/18hwubqU+nLDBmwulvz9g
	 NpKn0y7XjOLbyUUJnCZdxqSRa+0AofeYHgeMsaFDo5pHL3/50SKta0rOwOb4NG4e47
	 duSUS3CZGnWuaqjiiEUH9Dus5vE3dKhwvTnVMU+TkztUvYTcfPZ5T1DstaOql5Gew9
	 Br+gvYa+oCj8JHfQxmgvUf3Y7mgoQMYbG4Vpau0XUJLONIyv0NKO640b98I/Qj3EmD
	 DvipekOijX8j1aO53I7wMDporAcomuWvoFRxqW6bX89ikyKWuUaiQuq/4sjv41F3Hx
	 DGULoR1SixRbQ==
Subject: Re: [PATCH v7 13/13] can: peak_usb: don't return an uninitialized
 PCAN-USB CAN channel ID
From: netdev-bot+sashiko@kernel.org
To: s.grosjean@peak-system.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, wg@grandegger.com,
 error27@gmail.com, lukas.magel@posteo.net, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, tristmd@gmail.com, kuba@kernel.org
Date: Sun, 01 Nov 2026 02:15:31 +0000
Message-ID: <179349933109.3127.16204326690893554658@kernel.org>
In-Reply-To:
 <20261030-canfd_check_channel_idx-v7-13-fc4a3faf3acf@peak-system.fr>
References:
 <20261030-canfd_check_channel_idx-v7-13-fc4a3faf3acf@peak-system.fr>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The same ETHTOOL_GEEPROM disconnect-window leak is still open
  for PCAN-USB Pro, through the same shared handler.

Pre-existing issues:
- [Medium] Baseline decision: false (kept only because
  requires_validation=true).
- [Low] Baseline decision: false (kept only because
  requires_validation=true).

--

can: peak_usb: don't return an uninitialized PCAN-USB CAN channel ID

This patch zero-initializes args[] in pcan_usb_get_can_channel_id().
After disconnect has cleared PCAN_USB_STATE_CONNECTED, pcan_usb_wait_rsp()
returns success without filling args[]. Without the initializer, an
ETHTOOL_GEEPROM request in that window copies an uninitialized stack byte
to userspace.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
> index 626593251e5d7..4f255f2a33feb 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> @@ -386,7 +386,7 @@ static int pcan_usb_get_serial(struct peak_usb_device *dev, u32 *serial_number)
>   */
>  static int pcan_usb_get_can_channel_id(struct peak_usb_device *dev, u32 *can_ch_id)
>  {
> -	u8 args[PCAN_USB_CMD_ARGS_LEN];
> +	u8 args[PCAN_USB_CMD_ARGS_LEN] = {};

[Severity: Medium]
Is the same ETHTOOL_GEEPROM disconnect window still open for the PCAN-USB
Pro? It goes through the same peak_usb_get_eeprom() handler.

In pcan_usb_pro.c, pcan_usb_pro_get_can_channel_id() builds the GETDEVID
record with only one variadic argument:

	pcan_msg_add_rec(&um, PCAN_USBPRO_GETDEVID, dev->ctrl_idx);

pcan_msg_add_rec() handles GETDEVID in the same case as SETBTR and
SETDEVID. That case reads a second u32 argument, which this caller never
passes:

	case PCAN_USBPRO_SETBTR:
	case PCAN_USBPRO_GETDEVID:
	case PCAN_USBPRO_SETDEVID:
		*pc++ = va_arg(ap, int);
		pc += 2;
		*(__le32 *)pc = cpu_to_le32(va_arg(ap, u32));

That va_arg() is undefined behavior. In practice, whatever leftover
register or stack value it picks up ends up in the dev_num field of the
record in dev->cmd_buf.

The window opens after peak_usb_stop_rx() clears PCAN_USB_STATE_CONNECTED
and drops rtnl, and closes when unregister_candev() runs. Inside it,
pcan_usb_pro_send_cmd() and pcan_usb_pro_wait_rsp() both return 0 without
doing any USB I/O. Then this returns those leftover bytes as the channel
ID:

	pdn = (struct pcan_usb_pro_devid *)pc;
	*can_ch_id = le32_to_cpu(pdn->dev_num);

peak_usb_get_eeprom() then copies them to userspace. It also caches them
in dev->can_channel_id, which backs the can_channel_id sysfs attribute.

While the device is connected, the same 4 bytes are also sent to the
device with every GETDEVID request.

Would passing an explicit 0 as the second argument to pcan_msg_add_rec()
in pcan_usb_pro_get_can_channel_id() fix the Pro adapter? That could go
in a separate follow-up patch.

>  	int err;
>  
>  	err = pcan_usb_wait_rsp(dev, PCAN_USB_CMD_DEVID, PCAN_USB_GET, args);

[Severity: Low]
This isn't a bug introduced by this patch, but pcan_usb_wait_rsp() ignores
actual_length from the CMDIN usb_bulk_msg(). It also doesn't check that
cmd_buf[PCAN_USB_CMD_FUNC] and cmd_buf[PCAN_USB_CMD_NUM] match the
request:

	err = usb_bulk_msg(dev->udev,
		usb_rcvbulkpipe(dev->udev, PCAN_USB_EP_CMDIN),
		dev->cmd_buf, PCAN_USB_CMD_LEN, &actual_length,
		PCAN_USB_COMMAND_TIMEOUT);
	if (err)
		...
	else if (p)
		memcpy(p, dev->cmd_buf + PCAN_USB_CMD_ARGS,
			PCAN_USB_CMD_ARGS_LEN);

Suppose the device sends a short reply, or a late reply to an earlier
command that timed out. Could stale bytes from dev->cmd_buf then
overwrite the new zero initializer in args[]?

pcan_usb_send_cmd(..., NULL) only rewrites cmd_buf[0] and cmd_buf[1]. So
pcan_usb_get_can_channel_id() could report a byte left over from an
earlier outgoing command as the channel ID, for example btr1 from
pcan_usb_set_bittiming().

[Severity: Medium]
This is a pre-existing issue, but two setters in this file have the same
uninitialized args[] problem on the transmit side.
pcan_usb_set_can_channel_id() only sets args[0]:

	u8 args[PCAN_USB_CMD_ARGS_LEN];
	...
	args[0] = can_ch_id;
	return pcan_usb_send_cmd(dev, PCAN_USB_CMD_DEVID, PCAN_USB_SET, args);

pcan_usb_set_bittiming() only sets args[0] and args[1].

pcan_usb_send_cmd() copies all PCAN_USB_CMD_ARGS_LEN bytes into
dev->cmd_buf and sends the whole command over the bulk OUT endpoint:

	if (p)
		memcpy(dev->cmd_buf + PCAN_USB_CMD_ARGS,
			p, PCAN_USB_CMD_ARGS_LEN);

Does this send 12 or 13 bytes of uninitialized kernel stack to the USB
device on every channel ID write and every bitrate change?

The other setters in pcan_usb.c, such as pcan_usb_set_sja1000(),
pcan_usb_set_bus() and pcan_usb_set_led(), zero-initialize their args[].

Could these two args[] arrays get the same {} initializer?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf%40peak-system.fr
