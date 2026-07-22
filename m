Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B355F3DA5A8
	for <linux-can@vger.kernel.org>; Wed, 22 Jul 2026 04:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784694916; cv=none; b=J9KRAhXqBkO/YAFkQqSLJ8LSLyk6pV0YUKUS1kTHxpPedu3VSKUo/b82di3Gx8LKl2yHL86ZtU0c0Z2yFiepGr7SVfP1K0lAx3Yit0o4PQIwxRviU9iQRIAHjlfmfUU/FsPu90uxyTnqabMSBp22Ozy4AAjKzI5XGW19/VJJLz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784694916; c=relaxed/simple;
	bh=kysJkZUhzV+n1eOY4WeQ4KChz/O0iyar+wpfV7y7M9k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IWg5Dxh9jk4TnqytTZjnpwjsN6CSfzfIUkGuNZOD5ofvUe34p++i3ve/7tRdrRTAaVpohiROKALMZmbJyd228Z3k/Oi/6KCkJ7I0LZSh44YSFDlCweJW+5IsWnRY1SyloZbBK5ubc3ZR3d5kMcMPZjEtQ1ZcmCONZBq6x5WB5oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gM2pPXQT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gM2pPXQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B051F000E9;
	Wed, 22 Jul 2026 04:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784694915;
	bh=GfQVhJvutHwU9sKtzbuuSup4TfUWn0ncvQgPrGz8+jY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gM2pPXQT9t0yfoKVRxegOlnIrAeOwpQBWJXCAgulBlUDGXETN03NeXH7h/UBD5B19
	 grjMO/eRT3p+cSvM7efzlnDv6LcQIkOI9ecG2+xT/S8MxombjuFdFahn391thJQE7s
	 nNkr5LSpc1iSUVa2UziqVf/RNixsal0/2Ns6scRq9tzzwboaOJhI3rpwrwoc7HYDfo
	 i4ihia3LElAcnBFpWYcJvJ0Bc7BHs3rJcihfqSu+icCr7cpUOKLkwm8/NreuEHMhpI
	 4qOs28HhxMmmKM9LxPkdMnrzhyixUPTByhtuzjqDmT8EQVhgJiPzTxDMIwTDaFVp5n
	 jdaQdfO6cH4iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: kvaser_usb_leaf: validate received command extents
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260722042221.44066-1-pengpeng@iscas.ac.cn>
References: <20260722042221.44066-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 04:35:14 +0000
Message-Id: <20260722043515.23B051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A malicious USB device can cause an infinite loop in the driver's =
receive paths by presenting a bulk endpoint with a wMaxPacketSize of 0.
- [High] Missing length bounds validation in Hydra command parsing allows o=
ut-of-bounds reads and infinite loops.
- [High] The driver does not validate that `max_outstanding_tx` is non-zero=
, allowing a malicious device to trigger a divide-by-zero panic.
--

--- Patch [1]: [PATCH] can: kvaser_usb_leaf: validate received command exte=
nts ---
commit 25c3dede7931a0e156ff3db1ab14070a92252c33
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

can: kvaser_usb_leaf: validate received command extents

The wait and bulk receive paths walk variable-length commands from a
USB buffer. A nonzero command shorter than CMD_HEADER_LEN can still be
dispatched, and the wait path copies a matching command into a fixed
caller-owned struct kvaser_cmd using the device-provided length. Reject
nonzero commands that do not contain the fixed header or that extend
beyond the current USB buffer item. In the wait path, also reject a
matching command that exceeds the destination before copying it.

> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/n=
et/can/usb/kvaser_usb/kvaser_usb_leaf.c
> index df737cfc5ea0c..a876c7819b81c 100644
> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
> @@ -691,13 +691,22 @@ static int kvaser_usb_leaf_wait_cmd(const struct kv=
aser_usb *dev, u8 id,
>  				continue;
>  			}

[Severity: High]
This isn't a bug introduced by this patch, but looking at the lines just ab=
ove
this in kvaser_usb_leaf_wait_cmd():

			if (tmp->len =3D=3D 0) {
				pos =3D round_up(pos + 1,
					       le16_to_cpu
						(dev->bulk_in->wMaxPacketSize));
				continue;
			}

If a malicious USB device supplies a wMaxPacketSize of 0, will round_up()
evaluate to 0?

Does this cause the loop variable pos to continually reset to 0 and create
an infinite loop?

> =20
> -			if (pos + tmp->len > actual_len) {
> +			if (tmp->len < CMD_HEADER_LEN ||
> +			    tmp->len > actual_len - pos) {
>  				dev_err_ratelimited(&dev->intf->dev,
>  						    "Format error\n");
>  				break;
>  			}

[ ... ]

> @@ -1737,7 +1746,7 @@ static void kvaser_usb_leaf_read_bulk_callback(stru=
ct kvaser_usb *dev,
>  			continue;
>  		}

[Severity: High]
This is a pre-existing issue, but the same round_up() logic with wMaxPacket=
Size
appears right above here in kvaser_usb_leaf_read_bulk_callback():

		if (cmd->len =3D=3D 0) {
			pos =3D round_up(pos + 1, le16_to_cpu
						(dev->bulk_in->wMaxPacketSize));
			continue;
		}

Can this also result in an infinite loop in softirq context if wMaxPacketSi=
ze
is 0?

> =20
> -		if (pos + cmd->len > len) {
> +		if (cmd->len < CMD_HEADER_LEN || cmd->len > len - pos) {
>  			dev_err_ratelimited(&dev->intf->dev, "Format error\n");
>  			break;
>  		}

[Severity: High]
This is a pre-existing issue, but does kvaser_usb_hydra.c have a similar la=
ck
of length bounds validation?

In kvaser_usb_hydra_read_bulk_callback() and kvaser_usb_hydra_wait_cmd():

drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:kvaser_usb_hydra_cmd_size=
() {
    ...
    if (cmd->header.cmd_no =3D=3D CMD_EXTENDED)
        ret =3D le16_to_cpu(((struct kvaser_cmd_ext *)cmd)->len);
    ...
}

If a fragmented or malicious packet leaves fewer than 6 bytes, could reading
the len field at offset 4 access out-of-bounds memory?

Additionally, if the extracted cmd_len is 0:

drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c:kvaser_usb_hydra_read_bul=
k_callback() {
    ...
    cmd_len =3D kvaser_usb_hydra_cmd_size(cmd);
    if (pos + cmd_len > len) {
        ...
    }
    ...
    pos +=3D cmd_len;
}

Does the boundary check (pos + cmd_len > len) evaluate to false since pos <=
 len,
causing the driver to update pos +=3D 0 and loop infinitely?

[Severity: High]
This is a pre-existing issue, but is dev->max_tx_urbs validated when receiv=
ed
from the device firmware?

drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c:kvaser_usb_leaf_get_softwa=
re_info_leaf() {
    ...
    dev->max_tx_urbs =3D le16_to_cpu(softinfo->max_outstanding_tx);
    ...
}

If a malicious device reports a max_outstanding_tx of 0, could this cause a
divide-by-zero panic later when handling transmit acknowledgments?

drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c:kvaser_usb_leaf_tx_acknowl=
edge() {
    ...
    context =3D &priv->tx_contexts[tid % dev->max_tx_urbs];
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722042221.4406=
6-1-pengpeng@iscas.ac.cn?part=3D1
