Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE8AE54B
	for <linux-can@vger.kernel.org>; Fri, 17 Jul 2026 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306758; cv=none; b=MhPVn+Ge8523MiIC/dGtrdvB4WRvDwjDbDQaz/6wtGlroddXnRxQIBZEYeq3JfsGl38O3k7/5hcIlO12U8wp2Qgu7u7HRG7DGfC2RFqDYhdX8fu/7YJZiKjtlUeKPu1oKLZJHWowwQLWTtAlEk4r067qSLayEO1Lee9gr8sIHpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306758; c=relaxed/simple;
	bh=TU8jdGW/tQTHa/TXPii2wIy3LBzh+S8T0y1yUsNXwBo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CJMkSqF+gjcKozAZkfascaMVwX45MMwGPkiZwUMGzfTwChNfBUurSaz+xQHONMglgqjVCrWI5ixyYNKBDxPLLvch0UDsM08tAkACHO24DtX0VKwl7GRa8BdpGqgqk8CTV2k7H/jPXIZx1TO3ve7OUBu1tgrr6cr6bNTd2gI9qHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB9mF1c1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB9mF1c1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85401F00A3A;
	Fri, 17 Jul 2026 16:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784306756;
	bh=+Fq7aE+cyJ8VjunABJSs7jeHLBpKgp5pf/M7W56QOzE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bB9mF1c1iNnale4OOcbfamUAWL3T6i0dPSadon4kn0YJoqyCWkDwd4sggfV++ECp3
	 eDjWUDmrW8GGmQoWI0Kxq7e6ws6U2+ktGAO7y9mVOo1yQThfo2wjh1TjBpmrlIxHFe
	 2qWCzsazkWrHfpgEqCQgWD62+z7z3s+HXqQEH7YuIkaz2NZ7cO/AS6dVQTfAJjOuMW
	 1pELPca/P4YGHPrkKzajkMjtSEXL11QZAlyZzIzGSw646I1FpPMNOCUAdtZcEfNQAQ
	 f0cL1o0lYqXh4zwro0zEL1bPbQZ2v+VWZ0df+q9fwY9+x4oXRiWoS7uKghqOmw6PrI
	 fkJsNEOLfAvTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 02/19] can: esd_usb: kill anchored URBs before
 freeing netdevs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260716155528.809908-3-mkl@pengutronix.de>
References: <20260716155528.809908-1-mkl@pengutronix.de>
 <20260716155528.809908-3-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 16:45:55 +0000
Message-Id: <20260717164555.E85401F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but a missing bo=
unds check on `dev->net_count` derived from the USB device response leads t=
o a critical heap buffer overflow.
- [High] This problem wasn't introduced by this patch, but a malicious USB =
device can cause an infinite loop and CPU hard lockup by sending a message =
with length 0.
- [High] This problem wasn't introduced by this patch, but a malicious USB =
device can trigger an out-of-bounds memory read by sending a malformed or t=
runcated message payload.
- [High] This problem wasn't introduced by this patch, but a missing NULL c=
heck on partially initialized network interfaces allows a malicious USB dev=
ice to crash the kernel via NULL pointer dereference.
- [High] This problem wasn't introduced by this patch, but there is a perma=
nent leakage of TX contexts on URB submission failure, leading to a permane=
nt DoS of the interface.
--

--- Patch [2]: [PATCH net 02/19] can: esd_usb: kill anchored URBs before fr=
eeing netdevs ---
commit 1a29cc039e833667b5ba86f653b2a7b3b73983e1
Author: Fan Wu <fanwu01@zju.edu.cn>

can: esd_usb: kill anchored URBs before freeing netdevs

esd_usb_disconnect() frees each CAN netdev with free_candev() inside
its per-netdev loop and only calls unlink_all_urbs() afterwards.
The per-netdev private data is embedded in the net_device allocation,
so once free_candev() has run, dev->nets points to freed memory.
Reordering the teardown to match other CAN/USB drivers avoids this.

Link: https://patch.msgid.link/20260709164159.497640-1-fanwu01@zju.edu.cn

> diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
> index d257440fa01ff..f41d4a0d140f7 100644
> --- a/drivers/net/can/usb/esd_usb.c
> +++ b/drivers/net/can/usb/esd_usb.c
[ ... ]
> @@ -1390,10 +1390,13 @@ static void esd_usb_disconnect(struct usb_interfa=
ce *intf)
>  				netdev =3D dev->nets[i]->netdev;
>  				netdev_info(netdev, "unregister\n");
>  				unregister_netdev(netdev);
> -				free_candev(netdev);
>  			}
>  		}
>  		unlink_all_urbs(dev);
> +		for (i =3D 0; i < dev->net_count; i++) {
> +			if (dev->nets[i])
> +				free_candev(dev->nets[i]->netdev);
> +		}
>  		kfree(dev);
>  	}
>  }

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the driver=20
code I noticed a potential CPU hard lockup in esd_usb_read_bulk_callback() =
in=20
drivers/net/can/usb/esd_usb.c:

    while (pos < urb->actual_length) {
        ...
        pos +=3D msg->hdr.len * sizeof(u32);=20

If a USB device sends a message where len is set to 0, won't this loop run=
=20
infinitely since pos is never advanced?

[Severity: High]
This is a pre-existing issue, but could a USB device trigger an out-of-boun=
ds=20
memory read by sending a malformed message payload?=20

In esd_usb_read_bulk_callback() in drivers/net/can/usb/esd_usb.c:

    msg =3D (union esd_usb_msg *)(urb->transfer_buffer + pos);
    switch (msg->hdr.cmd) {
    ...

Are the message fields dereferenced here before verifying if the remaining=
=20
bytes in the transfer buffer are sufficient to back the structure?

[Severity: High]
This problem wasn't introduced by this patch, but could a USB device crash=
=20
the kernel via a NULL pointer dereference?=20

In esd_usb_probe() in drivers/net/can/usb/esd_usb.c, we have:

    for (i =3D 0; i < dev->net_count; i++)
        esd_usb_probe_one_net(intf, i);

If esd_usb_probe_one_net() fails, it returns an error but the driver ignores
the return value, leaving dev->nets[i] as NULL.=20

Later, if esd_usb_read_bulk_callback() receives a message targeted at this=
=20
failed index:

    case ESD_USB_CMD_CAN_RX:
        ...
        esd_usb_rx_can_msg(dev->nets[msg->rx.net], msg);

Is it possible this unconditionally dereferences dev->nets[msg->rx.net] wit=
hout=20
checking if it is NULL first?

[Severity: Critical]
This isn't a bug introduced by this patch, but is there a missing bounds=20
check on dev->net_count in drivers/net/can/usb/esd_usb.c?

In esd_usb_probe():

    dev->net_count =3D (int)msg->version_reply.nets;

The array upper bound is set based on untrusted USB input with no validatio=
n=20
against the structural maximum (ESD_USB_MAX_NETS).=20

Later in esd_usb_probe_one_net():

    dev->nets[index] =3D priv;

Could a USB device claim a large number of nets and cause a heap buffer=20
overflow by writing past the end of the dev->nets array?

[Severity: High]
This is a pre-existing issue, but does the error handling in=20
esd_usb_start_xmit() in drivers/net/can/usb/esd_usb.c leak TX contexts?

    err =3D usb_submit_urb(urb, GFP_ATOMIC);
    if (err) {
        can_free_echo_skb(netdev, context->echo_index, NULL);
        atomic_dec(&priv->active_tx_jobs);
        usb_unanchor_urb(urb);
        stats->tx_dropped++;

If the URB submission fails, the path drops the SKB and untracks the job, b=
ut=20
forgets to reset context->echo_index (e.g. to ESD_USB_MAX_TX_URBS).=20

Could this permanently leak the context slot, eventually exhausting all=20
available contexts and leading to a denial of service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716155528.8099=
08-1-mkl@pengutronix.de?part=3D2
