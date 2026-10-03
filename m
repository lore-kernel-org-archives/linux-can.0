Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDA4365A19;
	Sat,  3 Oct 2026 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791068443; cv=none; b=KZ/eXnGas7xRwcDpbCP1xxus67q1qaYm8ZAnuueUAMfeAFB84mkmIyr1dvFASTM0D0ylZrOC/cTtS98LDxVcS37fI7t8PiznSBE1j/2XqyFVWC9xSuuDJ7t2J7NpZT5U3xs8eUUf+tDluQeBJZ+P55EQjbyCCzHTTgcQD6GXEOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791068443; c=relaxed/simple;
	bh=HiTCW8m6Vkl5rGJ/sqEY8PujCVkVlaHlGLnOU8GeLA8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S8/bUl+0MrK2BJ/s79b5IMaTIZ1x/DlufPzfUOJvnLSwkFFnW4dimBj+MQKEigOpLBCPkApuxOowp+2dbxNH2kAWYkS93kS1N3/zGfLDLj15z+T+dd5M/Hu7tc4h1Y3FFF+iDxFD8cwIB1WQohRTR8/vvZLZfAw9KTr30ifGx+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+FCHuTN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+FCHuTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9B81F0089C;
	Sat,  3 Oct 2026 23:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791068441;
	bh=q9klnfyBRKEZ/2q57qxE3dBtwm7vxTJ9S+yaDYZzPi0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M+FCHuTNCrbtV1+sy9tvlxTr0y/OHnRfS19v5LSsv+/a4Gi6QMvOYaEa6qTOt798D
	 Ju7F74am9Kij21ONe235NOFlj2LprxHbq0+nXz02S8LLYcUiHuzqwlYIAwI5PUkh7y
	 YFLqH+BA0mz3O87a4J8xFvBKp4WJesa3VOYjzGKREF91ajiGGMBs8k6TlIA7wDK46d
	 a1AD6pAXAApRv/KFccFUcJTrrRjwyXTg1eg0BC3ntCUChl8epqMwlGPDZ0++A+DJhN
	 o2V/MS1lnLM5tqbDh4jXeWcf7iNjw44BbKGnN7fnTW5njgTHyExw1oHZN7FZj2QY44
	 r3N4Ces52FMug==
Subject: Re: [PATCH can-next 6/7] can: peak_usb: Add bus error reporting for
 the PCAN-USB FD family
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, s.grosjean@peak-system.fr, kernel@pengutronix.de,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Sat, 03 Oct 2026 23:00:41 +0000
Message-ID: <179106844116.1406898.10605612528694983606@kernel.org>
In-Reply-To: <20261002-peak_usb_enhancements-v1-6-50e965755c06@pengutronix.de>
References: <20261002-peak_usb_enhancements-v1-6-50e965755c06@pengutronix.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The invalid-channel guard is incomplete.
- [Medium] pcan_usb_fd_start() now calls `err =
  pcan_usb_fd_set_options(dev, 1, PUCAN_OPTION_ERROR, usb_opts);` (line…
- [Low] The new `if (!dev)` check in pcan_usb_fd_decode_error() fixes an
  existing NULL pointer dereference, but the fix is folded into a…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but when
  peak_usb_start() fails at dev_set_bus(dev, 1) after…

--

can: peak_usb: Add bus error reporting for the PCAN-USB FD family

This patch adds CAN bus error reporting for the PEAK-System USB-to-CAN FD
devices. pcan_usb_fd_start() now enables PUCAN_OPTION_ERROR for each
channel, pcan_usb_fd_decode_error() turns firmware error records into CAN
error frames, and the adapters now advertise CAN_CTRLMODE_BERR_REPORTING.
It also adds a NULL check for an invalid channel in
pcan_usb_fd_decode_error().

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> index 82502594a4092..9081f30e3d356 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -661,17 +661,73 @@ static int pcan_usb_fd_decode_error(struct pcan_usb_fd_if *usb_if,
>  	struct pucan_error_msg *er = (struct pucan_error_msg *)rx_msg;
>  	struct pcan_usb_fd_device *pdev;
>  	struct peak_usb_device *dev;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +	u8 can_err_tx = 0;
>  
>  	if (pucan_ermsg_get_channel(er) >= ARRAY_SIZE(usb_if->dev))
>  		return -EINVAL;
>  
> +	/* Guard against bogus channel 1 reports from single-channel adapters.
> +	 * Treat the entire URB as invalid in that case.
> +	 */
>  	dev = usb_if->dev[pucan_ermsg_get_channel(er)];
> +	if (!dev)
> +		return -EINVAL;
> +

[Severity: High]
This check covers pcan_usb_fd_decode_error(). Do the other decoders that
read a channel from the same URB need it too?

On PCAN-USB FD and PCAN-Chip USB, ctrl_count is PCAN_USBFD_CHANNEL_COUNT
(1). pcan_usb_fd_init() therefore sets only usb_if->dev[0], and dev[1]
stays NULL. The ARRAY_SIZE(usb_if->dev) bound is PCAN_USB_MAX_CHANNEL (2),
so channel 1 passes that check.

The other three decoders still dereference without a NULL check:

pcan_usb_fd_decode_canmsg():
	dev = usb_if->dev[pucan_msg_get_channel(rm)];
	netdev = dev->netdev;

pcan_usb_fd_decode_status():
	dev = usb_if->dev[pucan_stmsg_get_channel(sm)];
	pdev = container_of(dev, struct pcan_usb_fd_device, dev);
	netdev = dev->netdev;

pcan_usb_fd_decode_overrun():
	dev = usb_if->dev[pufd_omsg_get_channel(ov)];
	netdev = dev->netdev;

Suppose the firmware sends the bogus channel 1 described in the new comment
on a CAN_RX, STATUS or OVERRUN record. Wouldn't that dereference NULL in
peak_usb_read_bulk_callback()->pcan_usb_fd_decode_buf()?

The commit message says "Parsing of the entire URB is aborted if the
firmware reports an invalid channel". As far as I can tell, that only holds
for error records. The later loopback patch in this series doesn't seem to
change these decoders either.

[Severity: Low]
The code itself is fine, but this check also fixes an existing NULL pointer
dereference. Before this patch, pcan_usb_fd_decode_error() did:

	dev = usb_if->dev[pucan_ermsg_get_channel(er)];
	pdev = container_of(dev, struct pcan_usb_fd_device, dev);
	pdev->bec.txerr = er->tx_err_cnt;

PUCAN_OPTION_ERROR was already enabled on first open, so a channel 1 error
record on a single-channel adapter could already fault there.

Could this fix be split out with a Fixes: tag and Cc: stable, as was done
for the earlier "fix missing CAN_ERR_FLAG ..." patch in this series? That
way stable trees would pick it up.

[ ... ]

> @@ -912,12 +969,17 @@ static int pcan_usb_fd_start(struct peak_usb_device *dev)
>  		peak_usb_init_time_ref(&pdev->usb_if->time_ref,
>  				       &pcan_usb_pro_fd);
>  
> -		/* enable USB calibration messages */
> -		err = pcan_usb_fd_set_options(dev, 1,
> -					      PUCAN_OPTION_ERROR,
> -					      PCAN_UFD_FLTEXT_CALIBRATION);
> +		/* enable USB calibration messages (needed only once for the
> +		 * entire interface)
> +		 */
> +		usb_opts |= PCAN_UFD_FLTEXT_CALIBRATION;
>  	}
>  
> +	/* set channel device options: always asks for bus error notifications
> +	 * to get (at least) rxerr/txerr, as well as any USB-specific option.
> +	 */
> +	err = pcan_usb_fd_set_options(dev, 1, PUCAN_OPTION_ERROR, usb_opts);
> +
>  	pdev->usb_if->dev_opened_count++;

[Severity: Medium]
Can dev_opened_count end up one too high here?

pcan_usb_fd_set_options() now runs on every open. If it fails, the counter
is still incremented before err is returned. peak_usb_start() then takes
the err_adapter path:

	if (dev->adapter->dev_start) {
		err = dev->adapter->dev_start(dev);
		if (err)
			goto err_adapter;
	}

err_adapter frees the tx URBs and kills the rx URBs, but it never calls
adapter->dev_stop(). ndo_stop isn't called after a failed open either.

With the count stuck too high:

- the == 0 check here no longer resets time_ref or re-enables calibration
  on the next first open
- the == 1 check in pcan_usb_fd_stop() never matches, so calibration
  messages are never turned off
- the > 0 check in pcan_usb_fd_exit() gives the wrong result

Before this patch, a non-first open could only fail in
pcan_usb_fd_set_filter_std(), which returns before the increment. Should
the increment be skipped when pcan_usb_fd_set_options() fails?

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch, but a
related path exists when pcan_usb_fd_start() succeeds and bus-on then fails
in peak_usb_start():

	err = dev->adapter->dev_set_bus(dev, 1);
	if (err)
		goto err_adapter;

err_adapter doesn't call dev_stop() here either. dev_opened_count stays
incremented and the firmware notification options stay enabled. With this
patch, the per-channel PUCAN_OPTION_ERROR is also left armed in that case.

Should peak_usb_start() undo dev_start() on this path?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-peak_usb_enhancements-v1-0-50e965755c06%40pengutronix.de
