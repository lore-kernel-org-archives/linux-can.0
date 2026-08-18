Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711565474F
	for <linux-can@vger.kernel.org>; Tue, 18 Aug 2026 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787092871; cv=none; b=lcasgIJczFZLGZ2kTMCcHauNeU//HrAfF/y0fFVwonbA0wekD1KhBM6Gii/1XtyP44s1sxCZ+RZwiDGVpo8Usq2Gw+flNfiiyfKKf7T6lxopPjQKuPG5ADw4yd0s/CyQVjYTaLbvLZwHe9GftKtZN/GPQx/IGnTcXuiXEIfCy18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787092871; c=relaxed/simple;
	bh=r9S7bVztW0IzhC82JddD2Aw3Gm5pV9X6fdBZuPwLpfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ed1opJDqAy9bn56CaNxfxNwjZwJJsT3RM3hHcdWwNDpgYBGdPPm72/rzpDtbjIhfYJivqkn2YIUz2R2oS1sS9NRke+WBsKZlKta5yHMzkwtl2ZVJqudXx+sBuROw/FL5Ag1NPEarJ1gU/6hbD0+A3RrWV3/M/sjr0L2gBFKcpkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeIEu5pM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeIEu5pM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE451F000E9;
	Tue, 18 Aug 2026 22:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787092870;
	bh=Pjhuat9/+u0nAFOkzD25nf7q8g9P6LyJOs/abdZOcYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VeIEu5pMVRjPOH3z4Q0hmR7bXl3Cnko+9B7zbxYxpHcLZp0V1OkvUXreda422pwLW
	 h4sB88BOmmDidEKKJQ1CKjE99+LxdDJ3XGafkx9R+75Mv0YhfgeyOyoobdtX6xENap
	 QSyNLoSXcKpFdlt5qzvlOdSQEXDqThQCpJfFEmfADWch80lswRI/BH2fjnfLbbp0Jv
	 J6prB98nYMJRbSvr0pRaCB9FVI0EkuNC1oWtuF3y+44n7fueJo3EVjdve5lsZuIlLi
	 ekChp7oTDPzFZig5NpOtOEjUs6pVsYi6MRmcCIyeWJSz0akX4KSoo5hwmTaJhTWsSw
	 jFfsp1Y8UdcWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] can: can327: Fix out-of-bounds write in
 can327_parse_frame()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Baul Lee" <baul.lee@xbow.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260818221818.49430-1-baul.lee@xbow.com>
References: <20260818221818.49430-1-baul.lee@xbow.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 22:41:09 +0000
Message-Id: <20260818224109.CBE451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Injecting a CAN XL frame causes a stack buffer overflow in `ca=
n327_handle_prompt()` due to an unvalidated `frame->len`.
- [High] Valid Classical CAN frames with a Data Length Code (DLC) greater t=
han 8 are improperly rejected, leading to a state machine reset loop (DoS).
--

--- Patch [1]: [PATCH net v2] can: can327: Fix out-of-bounds write in can32=
7_parse_frame() ---
commit dd9b0d69813d53aa1dc1be8d8a99a15956ba7c3d
Author: Baul Lee <baul.lee@xbow.com>

can: can327: Fix out-of-bounds write in can327_parse_frame()

This patch fixes an out-of-bounds write in can327_parse_frame() by
validating the CAN payload length from the adapter. It adds checks to
reject frames if the DLC is not a valid hex digit or exceeds CAN_MAX_DLEN.

Link: https://lore.kernel.org/linux-can/20260818215029.47758-1-baul.lee@xbo=
w.com/

> diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
> index 90f5e35f3c8f9..c76a6378d4d62 100644
> --- a/drivers/net/can/can327.c
> +++ b/drivers/net/can/can327.c

[ ... ]

> @@ -460,7 +461,13 @@ static int can327_parse_frame(struct can327 *elm, si=
ze_t len)
>  	 */
> =20
>  	/* Read CAN data length */
> -	frame->len =3D (hex_to_bin(elm->rxbuf[datastart - 2]) << 0);
> +	dlc =3D hex_to_bin(elm->rxbuf[datastart - 2]);
> +	if (dlc < 0 || dlc > CAN_MAX_DLEN) {
> +		/* Not a hex digit, or more than CAN_MAX_DLEN bytes. */
> +		kfree_skb(skb);
> +		return -ENODATA;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but does returning -ENODATA for
frames with a DLC greater than 8 lead to a state machine reset loop?

Classical CAN frames can have a DLC between 9 and 15 on the bus. The ELM327
adapter outputs the raw DLC nibble. If this check fails and returns -ENODAT=
A,
can327_parse_line() treats it as an unrecoverable error and calls
can327_kick_into_cmd_mode() to reset the adapter:

drivers/net/can/can327.c:can327_parse_line() {
    ...
    if (ret =3D=3D -ENODATA) {
        /* Start afresh. */
        can327_kick_into_cmd_mode(elm);
    ...
}

Will this cause a denial of service by continuously resetting the CAN
interface whenever a valid frame with DLC > 8 is received?

> +	frame->len =3D dlc;
> =20
>  	/* Read CAN ID */
>  	if (frame->can_id & CAN_EFF_FLAG) {

[Severity: Critical]
This is a pre-existing issue, but is there a stack buffer overflow in
can327_handle_prompt() when handling CAN XL frames?

If can_dev_dropped_skb() in include/linux/can/dev.h fails to drop ETH_P_CAN=
XL
frames for devices lacking CAN XL support, an attacker could send a CAN XL
frame via a PF_PACKET or PF_CAN raw socket.

When can327_netdev_start_xmit() copies the first 16 bytes into
elm->can_frame_to_send, the CAN XL flags field aliases with frame->len,
setting it to 128 or more (since CANXL_XLF is 0x80).

In can327_handle_prompt(), the loop iterates over this attacker-controlled
length:

drivers/net/can/can327.c:can327_handle_prompt() {
    ...
    for (i =3D 0; i < frame->len; i++) {
        snprintf(&local_txbuf[2 * i],
                 sizeof(local_txbuf), "%02X",
                 frame->data[i]);
    }
    ...
}

Since sizeof(local_txbuf) is only 18, will this loop overflow local_txbuf[]
by writing hex bytes far past the end of the stack buffer, overwriting the
stack frame and return address?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818221818.4943=
0-1-baul.lee@xbow.com?part=3D1
