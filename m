Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1790390CAB
	for <linux-can@vger.kernel.org>; Wed, 19 Aug 2026 06:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119528; cv=none; b=VNSqVEtQRHLY5HVSGfGTpKFBTPk26Dq5NgibLzem708Y/Iq0npj5amkq/8sqXSOxKz5F7NkafXGkrDxYe0mAbs/UUjN3XSktuSEN3KNMHV65iHPJfORCKE/bFHyw33gue4hsqU3O2oSbIcCpXjQ24o5GORAo5g+c2QzPu6ECy9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119528; c=relaxed/simple;
	bh=rFc5oIEY5SeGAP8ukMj65eu8BJVI0gY6clQweo3T9Pw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CcPKB96MYlPiGz25Dux/zsLnL9ZxinG6L8KAfrBLE3uoU0Vdi4GHuPqVyoMzQXgFszYSk6dCNgebZcEphrF2athydOFIMyHW+/9yfiEuVMmB1zWLPSe/EkeZVC24FBkHqV38USW/v9iwNlovprDz84PONxYWyuD11EMlwmZk/lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c213VCIx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c213VCIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266201F000E9;
	Wed, 19 Aug 2026 06:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787119527;
	bh=/7XrFcL4v51exBS3eaN5ZLWt5TpCbj+QzoDncWJJ07M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c213VCIxe+V3WpknA4HdHVoDibwFMJInfix5PZstD+ElW0QH6ABEjJcoDhlBw3D2d
	 STKO0CMxr6vuxbmZUO0HEBfsIN3AfmBwn72cIbNmo1DynCTI0orsG6CxZtiXtMb8Fq
	 0ec3y2UtV81kfbmwKVKKpaUHp6d3+s56xP4SiwKvi/GnDLG80XHzSvwACY4DWeQVIq
	 kuNLadD4DsI8Wjcdu2mIxMpcRDbPT8PwOkQwxddUTTxiJKTLCxqMzDCadVphnZFqG9
	 yfsX92hKVqYQq2lMM0Llk0RZfVHtzdDeVOVUM480cX4awQfcYvuOFVP9jNv6ZpuNnC
	 S4Wb5zrGHKs+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] can: can327: Fix stack out-of-bounds write in
 can327_handle_prompt()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Baul Lee" <baul.lee@xbow.com>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260819054201.67294-1-baul.lee@xbow.com>
References: <20260819054201.67294-1-baul.lee@xbow.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 06:05:26 +0000
Message-Id: <20260819060527.266201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The patch prevents a stack crash but results in transmitting an =
invalid CAN XL frame as garbage classical CAN data.

Pre-existing issues:
- [High] The patch addresses a local stack out-of-bounds write in can327 bu=
t fails to fix the subsystem-wide root cause: can_dev_dropped_skb() does no=
t reject CAN XL frames for non-XL devices.
- [High] Sending a short (13-byte) CAN XL frame via an AF_PACKET RAW socket=
 leaks 3 bytes of uninitialized kernel heap memory over UART.
- [High] Missing bounds check on parsed frame->len causes a heap array out-=
of-bounds write in can327_parse_frame().
--

--- Patch [1]: [PATCH net] can: can327: Fix stack out-of-bounds write in ca=
n327_handle_prompt() ---
commit 07e6406926056d156de760bd7d0a03a7acd9ad40
Author: Baul Lee <baul.lee@xbow.com>

can: can327: Fix stack out-of-bounds write in can327_handle_prompt()

This commit addresses a stack out-of-bounds write in can327_handle_prompt()
caused by an aliased CAN XL frame length. It clamps the hexdump loop to
CAN_MAX_DLEN to prevent writing past the 18-byte local_txbuf.

>    A CAN XL frame aliases struct can_frame such that canxl_frame.flags,
>    which must carry CANXL_XLF, overlaps can_frame.len, so it arrives with
>    frame->len =3D=3D 0x80. can327 is a classical CAN device, but
>    can_dev_dropped_skb() only rejects CAN FD for a non-FD device; for
>    ETH_P_CANXL, can_dropped_invalid_skb() checks only that the frame is a
>    well-formed CAN XL frame, not that the device supports one.

[Severity: High]
This isn't a bug introduced by this patch, but does can_dev_dropped_skb() in
include/linux/can/dev.h need to drop CAN XL frames for non-XL hardware to
prevent a subsystem-wide issue?

Because canxl_frame.flags aliases with can_frame.len (resulting in a length
of 128), classical CAN drivers misinterpret the length. For example, does
this allow slcan_encaps() in drivers/net/can/slcan/slcan-core.c to hex-dump
128 bytes into a 33-byte heap buffer, or sja1000_start_xmit() in
drivers/net/can/sja1000/sja1000.c to write 128 out-of-bounds bytes to
hardware registers?

> diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
> index 90f5e35f3c8f9..396db56775a64 100644
> --- a/drivers/net/can/can327.c
> +++ b/drivers/net/can/can327.c
> @@ -624,9 +624,10 @@ static void can327_handle_prompt(struct can327 *elm)
>  			snprintf(local_txbuf, sizeof(local_txbuf), "ATRTR\r");
>  		} else {
>  			/* Send a regular CAN data frame */
> +			int dlc =3D min_t(int, frame->len, CAN_MAX_DLEN);

[Severity: Medium]
Instead of artificially clamping the length to 8, should we drop the
unsupported CAN XL frame entirely?=20

By clamping it, it looks like we might transmit internal CAN XL headers as
classical CAN payload bytes. Does this cause a CAN XL frame to be
transmitted as garbage classical CAN data over the bus?

>  			int i;
> =20
> -			for (i =3D 0; i < frame->len; i++) {
> +			for (i =3D 0; i < dlc; i++) {
>  				snprintf(&local_txbuf[2 * i],
>  					 sizeof(local_txbuf), "%02X",
>  					 frame->data[i]);

[Severity: High]
This is a pre-existing issue, but does sending a short (13-byte) CAN XL
frame via an AF_PACKET RAW socket leak uninitialized kernel heap memory
over UART?

In can327_netdev_start_xmit(), the driver passes a 13-byte SKB to
can327_send_frame(), which performs a 16-byte by-value struct copy:

can327_send_frame()
   elm->can_frame_to_send =3D *frame;

This captures 3 bytes of uninitialized heap memory. Then here in
can327_handle_prompt(), the loop formats offsets 8 through 15 of the
struct and queues them to be sent over the serial line.

[ ... ]

[Severity: High]
This is another pre-existing issue, but does can327_parse_frame() lack
bounds checking on the parsed frame->len?

If a malicious or faulty ELM327 device sends a malformed CAN data line
with a parsed length up to 15, frame->len is set directly:

drivers/net/can/can327.c:can327_parse_frame() {
    ...
    /* Read CAN data length */
    frame->len =3D (hex_to_bin(elm->rxbuf[datastart - 2]) << 0);
    ...
    /* Parse the data nibbles. */
    for (i =3D 0; i < frame->len; i++) {
        frame->data[i] =3D
            (hex_to_bin(elm->rxbuf[datastart + 3 * i]) << 4) |
            (hex_to_bin(elm->rxbuf[datastart + 3 * i + 1]));
    }
    ...
}

Since the skb is allocated via alloc_can_skb() (which allocates exactly
16 bytes for a classical CAN frame), does writing 15 bytes starting at
offset 8 corrupt adjacent heap memory like skb_shared_info?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819054201.6729=
4-1-baul.lee@xbow.com?part=3D1
