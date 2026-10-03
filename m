Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF7D3A5E89;
	Sat,  3 Oct 2026 04:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791003451; cv=none; b=qaWiBvYkbcMT1cXCvOEBJYQvrbu1HYSxiHbtgF9TV+12Yt+2f0kwDX/5fyZVP7HVxjDGgzMWJI/X8JuANLbZttnazzhXwRclNuwXJh+sU8jkZ4WmUFpgFuf6MmpXxKjaJ65ruWORm4DcSPQGhfZ+a4HPoXjRJ6xbsGOJJpcBXIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791003451; c=relaxed/simple;
	bh=mjI5rIRp4ceSGqL3LOrwT7RsadqTsWrl4aJOHPxocFM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iEdkdQupbJQEl5M9vxC+L1XsnO/CuTuD6MfoyGGJLcfFq8rYKsq5S6mEYHgyY5pcdMUadurHUS6W7siZ7LVlaOc4+n0GCTRUVwUrlWZy5sMCprfvZRdbd1g/sgrUiKHlcTLvL2xYiGfU6t8wylvqGg0aDqO3MSLugI7o/2d1gC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ9WqFlD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ9WqFlD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6298C1F000FF;
	Sat,  3 Oct 2026 04:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791003446;
	bh=KsveYxtkVFv9pW4s77/pBg15j1mxmMyYR2mwFFni1FQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XJ9WqFlD7jRMcGeFfdft+Ezg5k2OVkaR27+77q+OHOqGDAWhB3FmFBQCf3ibjKhPg
	 ndUI8pF/vpaOP5ozCcuFuGx+k5dsow3VVp5cRozojn/1joOxc/6YelnsaocuK+H1LF
	 8qqLU50zimNLxX8W9HsoC0G+gl4IrbxBEJfhziTiUdX/U/C/DmbY8njgVfkmUAHHCw
	 Jg14VxhsHigEJi8kGiXS50FhI8+e4GUNnTIeBc+lY60uES8xuS3P1ULAp59AGMmdTn
	 I7/luxsaEtqCgb1g1N2GDDO1xGEiana4vBWPw0GGT+lp6hIl099NnPdovVGAlaHY4l
	 PNYf2samTTHAg==
Subject: Re: [PATCH v3] can: peak_usb: Add bus error reporting for the
 PCAN-USB FD family
From: netdev-bot+sashiko@kernel.org
To: stephane.grosjean@free.fr
Cc: mkl@pengutronix.de, mailhol@kernel.org, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, s.grosjean@peak-system.fr, kuba@kernel.org
Date: Sat, 03 Oct 2026 04:57:25 +0000
Message-ID: <179100344592.1406898.12578802093404470362@kernel.org>
In-Reply-To: <20260930-peak_usb-canfd-berr-v3-1-0506dfba9fb4@peak-system.fr>
References: <20260930-peak_usb-canfd-berr-v3-1-0506dfba9fb4@peak-system.fr>
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

- [High] The new channel check covers only one of the four decoders that
  look up usb_if->dev[].
- [Medium] This feature commit also fixes two existing user-visible bugs
  without saying so, without Fixes: tags, and without splitting them out…
- [Low] pcan_usb_fd_decode_error() copies the raw 7-bit firmware code
  (`PUCAN_ERMSG_CODE(er)`, i.e. FIELD_GET(GENMASK(6,0), er->code_g))…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch
  makes it reachable on more paths.

--

can: peak_usb: Add bus error reporting for the PCAN-USB FD family

This adds CAN bus error reporting for the PEAK-System USB-to-CAN FD
adapters. On every open, each channel now enables PUCAN_OPTION_ERROR in
the firmware. pcan_usb_fd_decode_error() builds CAN_ERR_BUSERROR frames,
and all four adapters now advertise CAN_CTRLMODE_BERR_REPORTING.

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> index 0d46f4ce5dca7..5840623662afa 100644
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
The commit message says "Parsing of the entire URB is aborted if the
firmware reports an invalid channel". However, this check is only added to
pcan_usb_fd_decode_error(). Can a channel 1 report still crash the other
decoders that pcan_usb_fd_decode_buf() calls?

PCAN-USB FD and PCAN-Chip USB set ctrl_count to PCAN_USBFD_CHANNEL_COUNT
(1). pcan_usb_fd_init() only fills usb_if->dev[dev->ctrl_idx], so
usb_if->dev[1] stays NULL.

ARRAY_SIZE(usb_if->dev) is 2 (PCAN_USB_MAX_CHANNEL), so channel 1 passes
the bound check in each of these:

pcan_usb_fd_decode_canmsg():
	if (pucan_msg_get_channel(rm) >= ARRAY_SIZE(usb_if->dev))
		return -ENOMEM;

	dev = usb_if->dev[pucan_msg_get_channel(rm)];
	netdev = dev->netdev;

pcan_usb_fd_decode_status():
	dev = usb_if->dev[pucan_stmsg_get_channel(sm)];
	pdev = container_of(dev, struct pcan_usb_fd_device, dev);
	netdev = dev->netdev;

pcan_usb_fd_decode_overrun():
	dev = usb_if->dev[pufd_omsg_get_channel(ov)];
	netdev = dev->netdev;

Wouldn't a CAN_RX, STATUS or OVERRUN record with channel 1 still
dereference a NULL dev in the URB completion path? Could the channel be
checked once in pcan_usb_fd_decode_buf(), or could all four decoders get
the same NULL check?

The out-of-range return values also differ: -ENOMEM in decode_canmsg and
decode_status, but -EINVAL in decode_error and decode_overrun.

>  	pdev = container_of(dev, struct pcan_usb_fd_device, dev);

[ ... ]

> +	switch (PUCAN_ERMSG_TYPE(er)) {
> +	case PUCAN_ERMSG_BIT_ERROR:
> +		cf->data[2] |= CAN_ERR_PROT_BIT;
> +		break;
> +	case PUCAN_ERMSG_FORM_ERROR:
> +		cf->data[2] |= CAN_ERR_PROT_FORM;
> +		break;
> +	case PUCAN_ERMSG_STUFF_ERROR:
> +		cf->data[2] |= CAN_ERR_PROT_STUFF;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	cf->data[3] = PUCAN_ERMSG_CODE(er);

[Severity: Low]
Does the firmware code_g value use the same numbering as the
CAN_ERR_PROT_LOC_* values in include/uapi/linux/can/error.h?

The uAPI defines data[3] as the error location, using 5-bit SJA1000 style
segment codes (0x00 to 0x1f). PUCAN_ERMSG_CODE() copies the raw 7-bit
value selected by GENMASK(6, 0), so values from 0x20 to 0x7f can also end
up in data[3].

I couldn't find anything in-tree that documents the uCAN code_g encoding.
pucan_handle_error() in peak_canfd.c never reads code_g.

If the numbering differs, wouldn't candump -e and libsocketcan decode the
wrong error location? Could the code be translated explicitly? The other
option is to document that it matches the SJA1000 segment codes and narrow
the mask to 0x1f.

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
This isn't a bug introduced by this patch, but the patch makes it
reachable on more paths. pcan_usb_fd_start() increments dev_opened_count
even when pcan_usb_fd_set_options() fails, and then returns the error.

In peak_usb_start(), both failure paths jump to err_adapter, which never
calls adapter->dev_stop():

	if (dev->adapter->dev_start) {
		err = dev->adapter->dev_start(dev);
		if (err)
			goto err_adapter;
	}
	...
	if (dev->adapter->dev_set_bus) {
		err = dev->adapter->dev_set_bus(dev, 1);
		if (err)
			goto err_adapter;
	}

So the increment is never undone. Before this patch, a set_options
failure could only happen on the first open. Now it can happen on every
channel open.

A dev_set_bus() failure also now leaves PUCAN_OPTION_ERROR enabled in the
firmware for that channel.

For example, on a 2-channel adapter:

open can0                         count 0 -> 1
open can1, set_options fails      count 1 -> 2, open fails
close can0                        count == 2, calibration disable
                                  skipped, count -> 1

After that, PCAN_UFD_FLTEXT_CALIBRATION stays enabled with no channel
open. The next first open also sees a non-zero count, so it skips
peak_usb_init_time_ref() and keeps a stale time reference.

Should the count only be incremented on success, or should the failure
paths in peak_usb_start() undo it?

[ ... ]

> @@ -955,12 +1017,15 @@ static int pcan_usb_fd_stop(struct peak_usb_device *dev)
>  {
>  	struct pcan_usb_fd_device *pdev =
>  			container_of(dev, struct pcan_usb_fd_device, dev);
> +	u16 usb_opts = 0;
>  
>  	/* turn off special msgs for that interface if no other dev opened */
>  	if (pdev->usb_if->dev_opened_count == 1)
> -		pcan_usb_fd_set_options(dev, 0,
> -					PUCAN_OPTION_ERROR,
> -					PCAN_UFD_FLTEXT_CALIBRATION);
> +		usb_opts |= PCAN_UFD_FLTEXT_CALIBRATION;
> +
> +	/* turn off bus error option, as well as any USB-specific options */
> +	pcan_usb_fd_set_options(dev, 0, PUCAN_OPTION_ERROR, usb_opts);
> +
>  	pdev->usb_if->dev_opened_count--;

[Severity: Medium]
The commit message only describes new features, but the patch also seems
to fix two existing bugs. Should these be split out with Fixes: tags so
stable trees can pick them up?

First, before this patch pcan_usb_fd_decode_error() did this with no NULL
check:

	dev = usb_if->dev[pucan_ermsg_get_channel(er)];
	pdev = container_of(dev, struct pcan_usb_fd_device, dev);
	pdev->bec.txerr = er->tx_err_cnt;

A channel 1 error record on a single-channel adapter therefore wrote
through a NULL pointer. The new if (!dev) check fixes that.

Second, PUCAN_OPTION_ERROR was only enabled when dev_opened_count == 0
and only disabled when dev_opened_count == 1. The command is per channel
(pucan_cmd_opcode_channel(dev->ctrl_idx, ...)).

On the PCAN-USB Pro FD and X6, the second channel opened therefore never
received error records. Its pdev->bec stayed at 0/0. Those zero counters
were reported through do_get_berr_counter and used by
pcan_usb_fd_decode_status() to compute the tx/rx state. The option could
also be left enabled on the channel that closed first.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930-peak_usb-canfd-berr-v3-1-0506dfba9fb4%40peak-system.fr
