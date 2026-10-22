Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792628969;
	b=EWrJ2p3paBL5wbzcALP7/DPReUzA8ktA8iRKwWkTXExu6noWo2Bj6X5n3IkudEy+g5lq
	 k447PwICIc8bcBjrQMSzEkZjT+E9BeyNBnXzVf3W434YMiJLGE3fXVGjbW7kgGFz9AG0S
	 tHrrjB5dV6qpJzSoO1mqR6LYSuRjXG9lheIO4f7fsgla78wEnIK19YQI1Cd35lEkTL75Z
	 6a/elxAjg9SOLhL+va+wztNjzCn/NAR7NiwgUmVfhZA6AidyoflGQRn4ErtveDIHLqVhl
	 0mhpRM85htJQsSE1zc4Kj6S3CAxv41ZP866EVtMTtLxGP/up7jmq7n+O25RPTYUj8EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792628969;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rZct/Lel8zJTBY12234Z+EPTuMdyz1ZasuapRcQJ1AU=;
	b=4AUqSo21qG5KNG7tIZVyqzc27Vk+/OUoxcIm/XBWOIcjtDCvOk5RLf1r5+Nw57gVFhYd
	 hqYep3gSpVhaZ3VjugEPekh4d+8fdf3IvhhKGP62TqBGO+vW3tHpL2vym0erc0Sq0crrZ
	 5fDs/qHcXkAZcXTH0dQqKadxXnUXlmQC0HFL+t0K+WOCcYhlDdZuWY96/AGgXdynq10iE
	 2wjQ0J3oxNqok2UkKbHArVkjsWl++WFZqxaVwSriUz3wPzsiYNh0JK7/zIdl+uaAfvKTj
	 0GkTWEAKfrwFO8qbWwjdrYjkb48BUOSc4iCORUxkqDZzCh9pF08jUHk7DHeAsXfQZvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PX2LvZZ8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA24606A32C;
	Thu, 22 Oct 2026 00:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PX2LvZZ8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2AC1F000C1;
	Thu, 22 Oct 2026 00:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792628968;
	bh=rZct/Lel8zJTBY12234Z+EPTuMdyz1ZasuapRcQJ1AU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PX2LvZZ8DKtJlIP7ILoOAMcdXeJosnvpv8kXYOFrkRdW0pcj6Pk7ZET9PRZ8u0AT3
	 dJRFWPQOYiASaHNxeM7RF69wr8Xho3hegMA/gqAKEh10VHd88qQmlzJaWAivCr9FMg
	 +6zpn8WE0M8/MaB3v/qj+l694Ilq8+qbogkr4PhIUAMVvA6jWBqJnId/w4x6IGJ+Xg
	 FsKOSdzSszzWTdrRZ+RSqDQTsKzdQXJPV4vdzCDrR6J+Zais1LhcbkZ5d6uhJ8Hf5Q
	 QluDzdkgKlF6xYqUIIsVRRN75ZPTKBHI2my2LV57Wly+9SPdokiUNWrzkepGd9x404
	 oqA/IHjfUXAoQ==
Subject: Re: [PATCH v4 09/10] can: peak_usb: register the netdev only once the
 channel is set up
From: netdev-bot+sashiko@kernel.org
To: stephane.grosjean@free.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com,
 wg@grandegger.com, s.grosjean@peak-system.fr, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 22 Oct 2026 00:29:27 +0000
Message-ID: <179262896798.3131.8641593926434967283@kernel.org>
In-Reply-To:
 <20261020-canfd_check_channel_idx-v4-9-bfbde81f8bab@peak-system.fr>
References:
 <20261020-canfd_check_channel_idx-v4-9-bfbde81f8bab@peak-system.fr>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix does not close the command-buffer race on multi-channel
  PCAN-USB FD family adapters (PCAN-USB Pro FD and PCAN-USB X6,…
- [Low] The patch moves register_candev() (pcan_usb_core.c:1024) after
  dev_init(), dev_set_bus(dev, 0) and dev_get_can_channel_id().

--

can: peak_usb: register the netdev only once the channel is set up

This patch moves register_candev() in peak_usb_create_dev() after
dev_init(), dev_set_bus() and dev_get_can_channel_id(). The netdev then
can't be opened or configured while the channel is still being set up.
The error paths no longer unregister the netdev, and PCAN-USB now uses
dev_err() when reading the channel id fails.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> index 4c08656e77681..ccfc26d3e5a6b 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c

[ ... ]

> @@ -1027,6 +1018,18 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
>  	/* get CAN channel id early */
>  	dev->adapter->dev_get_can_channel_id(dev, &dev->can_channel_id);
>  
> +	/* register the netdev only once the channel is fully set up, so that
> +	 * it can't be opened or configured while being initialized.
> +	 */
> +	err = register_candev(netdev);

[Severity: High]
Does this fully close the command buffer race on the multi-channel
PCAN-USB FD adapters (PCAN-USB Pro FD and PCAN-USB X6)?

The commit message says the patch addresses this case:

  the commands sent by the open or bittiming callbacks may race with
  the ones sent by dev_init() on the same command buffer;

On those adapters, pcan_usb_fd_init() makes every channel after the
first share the previous sibling's command buffer:

drivers/net/can/usb/peak_usb/pcan_usb_fd.c:pcan_usb_fd_init() {
    ...
		pdev->usb_if = ppdev->usb_if;
		pdev->cmd_buffer_addr = ppdev->cmd_buffer_addr;
    ...
}

So one buffer, and one fw_info, serves the whole interface. Nothing in
peak_usb appears to lock either of them.

peak_usb_probe() calls peak_usb_create_dev() for each channel in turn.
With this patch, can0 is registered at the end of channel 0's
peak_usb_create_dev(). Channel 1's peak_usb_create_dev() then runs
without RTNL:

peak_usb_create_dev(ch1)
  dev_init() -> pcan_usb_fd_init()
    pcan_usb_fd_set_clock_domain()
    pcan_usb_fd_set_can_led(dev, PCAN_UFD_LED_DEF)
  dev_set_bus(dev, 0) -> pcan_usb_fd_set_bus()
  dev_get_can_channel_id() -> pcan_usb_fd_get_can_channel_id()
    pcan_usb_fd_read_fwinfo(dev, &usb_if->fw_info)
      pcan_usb_pro_send_req()   /* memsets the shared fw_info */

Meanwhile, userspace holding only RTNL can bring up can0:

peak_usb_ndo_open() -> pcan_usb_fd_start()
  pcan_usb_fd_set_filter_std() / pcan_usb_fd_set_options()

Userspace can also set can0's bittiming through
pcan_usb_fd_set_bittiming_slow(). Both paths build commands in the same
buffer and send them with pcan_usb_fd_send_cmd(). That function writes
the EOC marker into the buffer and reads the shared fw_info->cmd_out_ep:

drivers/net/can/usb/peak_usb/pcan_usb_fd.c:pcan_usb_fd_send_cmd() {
    ...
		memset(cmd_tail, 0xff, sizeof(u64));
    ...
		err = usb_bulk_msg(dev->udev,
				   usb_sndbulkpipe(dev->udev,
						   fw_info->cmd_out_ep),
    ...
}

Could channel 1's RESET_MODE and EOC overwrite can0's 64 FILTER_STD
records, or the other way round? Could can0's bulk transfer use a
cmd_out_ep that pcan_usb_pro_send_req() has just zeroed?

The cross-channel form of this race was already there before this
patch. Moving register_candev() within a single channel can't prevent
it, though.

A fix probably needs to serialize command building and sending per
interface. Two options are a mutex in struct pcan_usb_fd_if, or holding
RTNL across the probe-time command sequence.

The last patch in the series, "can: peak_usb: only dump received bytes
on decode error", only touches peak_usb_read_bulk_callback(). So this
race seems to remain at the end of the series.

> +	if (err) {
> +		dev_err(&intf->dev, "couldn't register CAN device: %d\n", err);
> +		goto adap_dev_free;
> +	}

[Severity: Low]
Can this error path now leave the firmware reporting that a driver is
loaded?

register_candev() now runs after dev_init() has already sent commands
to the hardware. For channel 0, pcan_usb_fd_init() sends
pcan_usb_fd_drv_loaded(dev, 1), programs the clock domain and sets the
CAN LEDs to PCAN_UFD_LED_DEF. In the same way, pcan_usb_pro_init() sends
pcan_usb_pro_drv_loaded(dev, 1) and turns the device LED on.

register_candev() can fail, for example with -ENOMEM from
register_netdev(), a netdevice notifier veto, or a can_get_termination()
error. In that case the adap_dev_free path only calls peak_usb_stop_rx()
and dev_free(). pcan_usb_fd_free() and pcan_usb_pro_free() only clear
usb_if->dev[] and free memory.

Only pcan_usb_fd_exit() and pcan_usb_pro_exit() send drv_loaded(0) and
switch the LEDs off. dev_exit() is only called from
peak_usb_do_device_exit() at module unload.

Before this patch, register_candev() ran before any command reached the
device, so a registration failure left the hardware untouched.

The existing dev_set_bus() failure path and peak_usb_disconnect()
already leave the device in this state. The effect is limited to the
firmware status and the LEDs.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020-canfd_check_channel_idx-v4-0-bfbde81f8bab%40peak-system.fr
