Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFAB3CD8A4
	for <linux-can@vger.kernel.org>; Fri, 14 Aug 2026 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786731681; cv=none; b=oIZjWQKXNbXInaAan7vuCdIplebGUgTwGWmMPq7brKG3AIBmejnSlfaa4BOHmXNjXo97tFJBiUS1qbchLrztxERXQhIeff+IuoJ3ebr/xpGD0vALoH034yXpSDyISu+c80AvgEN4bHraZWJGJMHiV0bIT3dCwCURsCgjotWNKeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786731681; c=relaxed/simple;
	bh=cKtP/jXfgwKDZeiGHr9FzjisM/brCiA7ruDy0Ngww+4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qa7t1k9Y9MXEFa5IJyXcYwkz9Xcrj3osIPmB5qtl9wgVRNI3JdzZgsWEpnVSXeMYg9+DQb2tPi4l1SIagQIME8M8RIDULsfMPF1Z8ttj6KH0XaY2oFL19s3LYidAzoLU5xRDVuDEVISUtSySE5W/Jb7SNiWFzsBnE32BgJdJu8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdS84gqh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdS84gqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990D61F00A3A;
	Fri, 14 Aug 2026 18:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786731679;
	bh=xYmBhikQF5olaZbnSHCZNAB2nr0kK4Ap1azuPAOWwNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZdS84gqh0iKtDPDLR4ISANkXSSmNRa6gtc0Ni9N71+SM3n/EqJ9b52MHoAszxdtAd
	 +hxucD5ZaX+8OB5mZlTLoGHbX970vP7Z/gG3q9HOPlAcKkiBR/gnoN7Yqumb1R0yam
	 FP+0pIQWTnSLs7o1ujIESfWFwBmvwiS0+ItTLv3Q8CNi0bHsABhenkS+KRpEBUpSqJ
	 MjTOp0GKsp0wTWfeMnr8m3+iI28ky690lwkaflhp2s7WFLY84/vEHQj2FzUONN53qS
	 bLGjuMYtQ/u4r/T9IVGCNC4BbecyxvHoEq6vYX0+WN5QAUn29rWWhJzB2/cS7N1adc
	 kiG+mb1+vOiRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] can: kvaser_usb_hydra: reject too-short commands in
 the receive path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiran Qiu" <eritque-arcus@ikuyo.dev>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260815-can-esd-hydra-fixes-v1-2-de644cbeaec2@ikuyo.dev>
References: <20260815-can-esd-hydra-fixes-v1-0-de644cbeaec2@ikuyo.dev>
 <20260815-can-esd-hydra-fixes-v1-2-de644cbeaec2@ikuyo.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 18:21:19 +0000
Message-Id: <20260814182119.990D61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Processing an unexpected or duplicate TX acknowledge command c=
auses an out-of-bounds array access, leading to memory corruption.
- [High] kvaser_usb_hydra_cmd_size() reads the command length from the URB =
buffer without verifying sufficient data is available, and the patch's newl=
y added minimum length check is insufficient to prevent out-of-bounds acces=
ses during command dispatch.
- [High] The patch fails to validate command lengths in the leftover buffer=
 path, leading to an integer underflow, and an error path fails to reset th=
e leftover length, permanently wedging the receive path.
- [High] The dev_get_berr_counter implementation synchronously transmits a =
USB command using GFP_KERNEL allocations while running inside an RCU read-s=
ide critical section.
- [High] The driver blindly copies CAN frame payload data based on the devi=
ce-supplied DLC without verifying that the command length is large enough, =
leading to a heap information leak.
- [High] The patch fixes an infinite loop in the URB completion callback bu=
t leaves the exact same vulnerability in the synchronous command wait funct=
ion.
--

--- Patch [2]: [PATCH 2/2] can: kvaser_usb_hydra: reject too-short commands=
 in the receive path ---
commit c7aa22e9c2e49b7c5c3858b9afe989871f77d49c
Author: Yiran Qiu <eritque-arcus@ikuyo.dev>

can: kvaser_usb_hydra: reject too-short commands in the receive path

This commit fixes an infinite loop in the URB-completion softirq caused by
extended commands with a length of zero. It adds a minimum-length check bef=
ore
dispatching commands.

Cc: stable@vger.kernel.org

> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/=
net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> index efbb7bed34c9d..d44f9875fbe2f 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
> @@ -2156,6 +2156,15 @@ static void kvaser_usb_hydra_read_bulk_callback(st=
ruct kvaser_usb *dev,
> =20
>  		cmd_len =3D kvaser_usb_hydra_cmd_size(cmd);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but does the call to
kvaser_usb_hydra_cmd_size() read the command length from the URB buffer
without verifying sufficient data is available?

If a malicious device sends an extended command split across URBs, or one w=
ith
a length of 4 or 5 bytes, kvaser_usb_hydra_cmd_size() reads the 16-bit leng=
th
field at offset 4:

kvaser_usb_hydra_cmd_size()
    ret =3D le16_to_cpu(((struct kvaser_cmd_ext *)cmd)->len);

This occurs without checking if the buffer has enough data, leading to an
out-of-bounds read.

> +		/* An extended command carries a device-supplied length; a
> +		 * command shorter than the command header would never advance
> +		 * @pos and would spin this URB-completion softirq forever.
> +		 */
> +		if (cmd_len < sizeof(struct kvaser_cmd_header)) {
> +			dev_err(&dev->intf->dev, "Format error\n");
> +			break;
> +		}
> +

[Severity: High]
This is a pre-existing issue, but is the validation check added here
sufficient to prevent out-of-bounds accesses during command dispatch?

Since a command length of 4 or 5 passes this check, it allows
kvaser_usb_hydra_handle_cmd_ext() to be called. That function then reads
cmd_no_ext at offset 6:

kvaser_usb_hydra_handle_cmd_ext()
    switch (cmd->cmd_no_ext) {

Could this lead to an out-of-bounds array access on the URB buffer and
corrupted command processing?

>  		if (pos + cmd_len > len) {
>  			/* We got first part of a command */
>  			int leftover_bytes;

[Severity: High]
This isn't a bug introduced by this patch, but earlier in
kvaser_usb_hydra_read_bulk_callback(), does the leftover buffer path fail to
validate command lengths?

If the leftover buffer evaluates cmd_len to 0, cmd_len - usb_rx_leftover_len
underflows to a massive unsigned integer. Once usb_rx_leftover_len
accumulates past 128 bytes, the driver prints an error and returns:

kvaser_usb_hydra_read_bulk_callback()
    if (remaining_bytes + usb_rx_leftover_len >
                                    KVASER_USB_HYDRA_MAX_CMD_LEN) {
            dev_err(&dev->intf->dev, "Format error\n");
            spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
            return;
    }

Crucially, it fails to reset usb_rx_leftover_len to 0. Would every subseque=
nt
URB immediately hit this exact overflow condition and be dropped, permanent=
ly
wedging the device receive path?

[Severity: High]
This is a pre-existing issue, but does kvaser_usb_hydra_wait_cmd() contain =
the
exact same infinite loop vulnerability that this patch fixes?

kvaser_usb_hydra_wait_cmd() iterates over incoming USB data using a similar
loop. A malicious device could send an extended command with length 0, caus=
ing
cmd_len to evaluate to 0:

kvaser_usb_hydra_wait_cmd()
    pos +=3D cmd_len;

Since the command is not the expected response, the loop adds 0 to pos and
spins forever without advancing. Will this lock up the kernel during device
probe or configuration?

[Severity: High]
This isn't a bug introduced by this patch, but does the
dev_get_berr_counter implementation synchronously transmit a USB command
using GFP_KERNEL allocations while running inside an RCU read-side critical
section?

The callback is invoked by can_fill_info() when responding to netlink
RTM_GETLINK dumps, which execute under rcu_read_lock(). Inside this RCU
critical section, kvaser_usb_hydra_get_berr_counter() dynamically allocates
memory with GFP_KERNEL and calls wait_for_completion_timeout() to submit a
synchronous URB:

kvaser_usb_hydra_get_berr_counter()
    err =3D kvaser_usb_hydra_send_simple_cmd(priv->dev,
                                           CMD_GET_CHIP_STATE_REQ,
                                           priv->channel);

Could this violate core kernel locking rules, leading to sleeping in atomic
context, lockdep splats, and potential RCU stalls?

[Severity: High]
This is a pre-existing issue, but does the driver blindly copy CAN frame
payload data based on the device-supplied DLC without verifying the command
length?

In kvaser_usb_hydra_rx_msg_ext(), the driver extracts the DLC and converts =
it
to a payload length. It then blindly copies cf->len bytes from the URB buff=
er:

kvaser_usb_hydra_rx_msg_ext()
    memcpy(cf->data, cmd->rx_can.kcan_payload, cf->len);

If a malicious device sends an extended command with a small USB transfer
length but a large DLC, will the driver read out-of-bounds past the end of
the USB transfer buffer, and leak kernel heap memory to userspace?

[Severity: Critical]
This isn't a bug introduced by this patch, but does processing an
unexpected or duplicate TX acknowledge command cause an out-of-bounds array
access?

When processing a duplicate TX ACK, context->echo_index is reset to
dev->max_tx_urbs, which matches the size of the echo_skb array. The driver
directly accesses priv->can.echo_skb[context->echo_index] without bounds
checking:

kvaser_usb_hydra_tx_acknowledge()
    skb =3D priv->can.echo_skb[context->echo_index];
    if (skb)
            skb_hwtstamps(skb)->hwtstamp =3D
                               kvaser_usb_hydra_ktime_from_cmd(dev->cfg, cm=
d);

This accesses exactly one element past the end of the dynamically allocated
echo_skb array. If the out-of-bounds memory contains a non-zero value, it is
treated as a valid sk_buff pointer, and an 8-byte timestamp is written to i=
t.
Could this lead to wild pointer writes and exploitable kernel memory
corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815-can-esd-hy=
dra-fixes-v1-0-de644cbeaec2@ikuyo.dev?part=3D2
