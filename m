Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B413F104A;
	Thu, 27 Aug 2026 19:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859853; cv=none; b=JR2s7v8btCzIEZsm4aLlLq2WNOsWrqJD/+ARJNkbeF07lhnefqPnOEiVYjEjsnvtWvPQgxlC7V8Ppkm6FEPOC3by9Kz7Q8YF8AjykeFN145cZqKB7iQDoPxsAwBxVYVh9o9x3acozGE+bmcKDQxCoqVNxcQHhJqRPk0jUdlzELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859853; c=relaxed/simple;
	bh=SPeJ/Y9+cE5dWIQ2wKGN/2wp6ge6udqfcasKBCOoyjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V64myYDOW5304IGKJzAVcPmbZRUmJ0NLIvGzgD/nHDOnlhUd/y57xF7K0Mry61LNcCCrLVNf8oeYEZt0Xy7Xaim8VvQR1QyxLcpe8exp49oluZ8z/f0R4+dE96p4atkH8y9uhal455WUa8mKigO3atDuioYDJQXvF7i3q1uKYcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czEY1u/B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czEY1u/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6061F00A3A;
	Thu, 27 Aug 2026 19:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787859851;
	bh=wspUJIv80awpWSpcUAXc5rAlIEMC4jNZRfPSgq4q1s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=czEY1u/BGiD2+RwEy0NviNURwBQnkMVWz3EX6zjFKwpSFSgSH3f1RhNAvc2ZD+/a2
	 EMEimfmCTjrDwfYayjGIJt4FBtnRUU7MInJ8wE/vSz5xtbWoLupNpN9cDYSFBFYr0F
	 iim84iRnX5bVrMuV3fkymfIa35frmxVZx9zw4VkzC64gjIHEdltcDoamvRUZUyxwRn
	 nAncIA3dkkFQ5pQbC52xAXZnereSK+fBGzOBuiy8Y8JXsJftnsumnCRDEMH2HBoxQg
	 q+ccuolBEm5v5UTWjIRWl6EJ/4oa85exkRy6eONv1uofbs/FLJu1FW6+T+T1r/iAKg
	 jydLWUCcoJ8Eg==
From: Jakub Kicinski <kuba@kernel.org>
To: mkl@pengutronix.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	blbllhy@gmail.com,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu
Subject: Re: [PATCH net 12/14] can: kvaser_usb: validate command format before parsing in hydra receive path
Date: Thu, 27 Aug 2026 12:44:10 -0700
Message-ID: <20260827194410.4023800-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826121036.2706424-13-mkl@pengutronix.de>
References: <20260826121036.2706424-13-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
can: kvaser_usb: validate command format before parsing in hydra receive path

This adds kvaser_usb_hydra_cmd_size_rx() so the hydra receive paths check
that the CMD_EXTENDED 2-byte length field is fully present before reading
it, and rejects a declared length of zero to keep the parse loop making
progress.  The asynchronous path now keeps a partial extended header in the
leftover buffer and completes it from the next transfer.

Link: https://patch.msgid.link/20260826013037.6933-1-blbllhy@gmail.com

> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index efbb7bed34c9d..efe7b3ef489bf 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> @@ -536,6 +536,24 @@ static size_t kvaser_usb_hydra_cmd_size(struct kvaser_cmd *cmd)
>  	return ret;
>  }
>  
> +/* -EAGAIN means incomplete; -EINVAL rejects zero to ensure progress. */
> +static int kvaser_usb_hydra_cmd_size_rx(struct kvaser_cmd *cmd,
> +					size_t remaining, size_t *cmd_len)
> +{
> +	if (remaining < sizeof(cmd->header.cmd_no))
> +		return -EAGAIN;
> +
> +	if (cmd->header.cmd_no == CMD_EXTENDED &&
> +	    remaining < offsetof(struct kvaser_cmd_ext, cmd_no_ext))
> +		return -EAGAIN;
> +
> +	*cmd_len = kvaser_usb_hydra_cmd_size(cmd);
> +	if (!*cmd_len)
> +		return -EINVAL;
> +
> +	return 0;
> +}

[Severity: High]
Should this helper also reject a declared length that is smaller than the
fields the extended-command consumers dereference?

Right now the only constraint on the device-supplied length is that it is
non-zero, but struct kvaser_cmd_ext is 96 bytes with cmd_no_ext at offset 6,
rx_can.flags at 8, kcan_header at 20, timestamp at 24 and kcan_payload at
32..95:

	struct kvaser_cmd_ext {
		struct kvaser_cmd_header header;
		__le16 len;
		u8 cmd_no_ext;
		u8 reserved;
		union {
			struct kvaser_cmd_ext_rx_can rx_can;
			...
	} __packed;

kvaser_usb_hydra_handle_cmd_ext() reads cmd->cmd_no_ext and then
kvaser_usb_hydra_rx_msg_ext() reads all the way up to kcan_payload,
without any relation to cmd->len:

	drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:kvaser_usb_hydra_rx_msg_ext() {
		...
		memcpy(cf->data, cmd->rx_can.kcan_payload, cf->len);
		...
	}

The sibling leaf driver already enforces per-command minimums before
dispatch via kvaser_usb_leaf_verify_size() in
kvaser_usb_leaf_handle_command().  Would it make sense to require
cmd_len >= offsetof(struct kvaser_cmd_ext, cmd_no_ext) + 2 here, or better a
per-cmd_no_ext minimum up to sizeof(struct kvaser_cmd_ext), instead of only
rejecting zero?

> @@ -675,8 +693,8 @@ static int kvaser_usb_hydra_wait_cmd(const struct kvaser_usb *dev, u8 cmd_no,
>  			size_t cmd_len;
>  
>  			tmp_cmd = buf + pos;
> -			cmd_len = kvaser_usb_hydra_cmd_size(tmp_cmd);
> -			if (pos + cmd_len > actual_len) {
> +			err = kvaser_usb_hydra_cmd_size_rx(tmp_cmd, actual_len - pos, &cmd_len);
> +			if (err || pos + cmd_len > actual_len) {
>  				dev_err_ratelimited(&dev->intf->dev,
>  						    "Format error\n");
>  				break;

[Severity: High]
In kvaser_usb_hydra_wait_cmd(), a CMD_EXTENDED declaring a small positive
length (say 1) still returns 0 from the helper, and cmd_len is then used as
the stride:

			pos += cmd_len;

Does this leave the parser resynchronising from the middle of the malformed
extended header for the rest of the buffer?  The accesses stay inside the
kzalloc'd buffer here, but the interpretation of the following bytes is
attacker-chosen.

> @@ -2120,23 +2138,47 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
>  	spin_lock_irqsave(usb_rx_leftover_lock, irq_flags);
>  	usb_rx_leftover_len = card_data->usb_rx_leftover_len;
>  	if (usb_rx_leftover_len) {
> +		const size_t cmd_size_field_end = offsetof(struct kvaser_cmd_ext, cmd_no_ext);
>  		int remaining_bytes;
> +		int err;
>  
>  		cmd = (struct kvaser_cmd *)card_data->usb_rx_leftover;
>  
> -		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
> +		if (cmd->header.cmd_no == CMD_EXTENDED &&
> +		    usb_rx_leftover_len < cmd_size_field_end) {
> +			remaining_bytes = min_t(int, len, cmd_size_field_end - usb_rx_leftover_len);
> +
> +			memcpy(card_data->usb_rx_leftover + usb_rx_leftover_len, buf, remaining_bytes);
> +			usb_rx_leftover_len += remaining_bytes;
> +			card_data->usb_rx_leftover_len = usb_rx_leftover_len;
> +			pos += remaining_bytes;
>  
> -		remaining_bytes = min_t(unsigned int, len,
> +			if (usb_rx_leftover_len < cmd_size_field_end) {
> +				spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
> +				return;
> +			}
> +		}
> +
> +		err = kvaser_usb_hydra_cmd_size_rx(cmd, usb_rx_leftover_len, &cmd_len);
> +		if (err || cmd_len < usb_rx_leftover_len) {
> +			dev_err(&dev->intf->dev, "Format error\n");
> +			card_data->usb_rx_leftover_len = 0;
> +			spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
> +			return;
> +		}
> +
> +		remaining_bytes = min_t(unsigned int, len - pos,
>  					cmd_len - usb_rx_leftover_len);

[Severity: High]
On the reassembly path, once the top-up above has filled exactly the 6 bytes
up to cmd_size_field_end, a device-declared cmd_len of 6, 7 or 8 passes the
helper and then satisfies the completion test straight away:

		if (remaining_bytes + usb_rx_leftover_len == cmd_len) {
			kvaser_usb_hydra_handle_cmd(dev, cmd);

Does this dispatch an extended command whose cmd_no_ext and payload bytes
come from whatever was previously left in the 128-byte
card_data->usb_rx_leftover array, since only the first 6 bytes have been
written by this transfer?

> @@ -2152,11 +2194,17 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
>  	spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
>  
>  	while (pos < len) {
> +		int err;
> +
>  		cmd = buf + pos;
>  
> -		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
> +		err = kvaser_usb_hydra_cmd_size_rx(cmd, len - pos, &cmd_len);
> +		if (err && err != -EAGAIN) {
> +			dev_err(&dev->intf->dev, "Format error\n");
> +			return;
> +		}
>  
> -		if (pos + cmd_len > len) {
> +		if (err == -EAGAIN || pos + cmd_len > len) {
>  			/* We got first part of a command */
>  			int leftover_bytes;
>  

[Severity: High]
Can a crafted transfer still reach the same class of out-of-bounds read that
this commit describes?

Here err == 0 together with pos + cmd_len <= len is the complete gate before
kvaser_usb_hydra_handle_cmd(), and pos is advanced by the device's own
declared lengths, so pos can be placed anywhere in the 3072-byte URB buffer
allocated in kvaser_usb_setup_rx_urbs():

	buf = usb_alloc_coherent(dev->udev, KVASER_USB_RX_BUFFER_SIZE,
				 GFP_KERNEL, &buf_dma);

For a full 3072-byte transfer holding a CMD_EXTENDED with len 3064, followed
at pos 3064 by a CMD_EXTENDED with len 8 and cmd_no_ext CMD_RX_MESSAGE_FD:

  remaining is 8, which is >= offsetof(struct kvaser_cmd_ext, cmd_no_ext)
  cmd_len is 8, so the zero check passes
  pos + cmd_len == 3072 == len, so the truncation check passes

kvaser_usb_hydra_handle_cmd() -> kvaser_usb_hydra_handle_cmd_ext() ->
kvaser_usb_hydra_rx_msg_ext() then reads rx_can.flags, kcan_header and
timestamp past the end of the transfer buffer and finishes with:

		memcpy(cf->data, cmd->rx_can.kcan_payload, cf->len);

with cf->len up to 64 taken from the device-supplied DLC, i.e. up to roughly
88 bytes beyond the 3072-byte allocation.  On host controllers where
hcd_uses_dma() is false (dummy_hcd, vhci) hcd_buffer_alloc() falls back to
kmalloc(3072), so KASAN would report a slab-out-of-bounds read here, and the
bytes read are then handed to netif_rx() inside a CAN FD frame.

Would adding the minimum-length check inside kvaser_usb_hydra_cmd_size_rx()
close this as well, rather than leaving it for a follow-up?
