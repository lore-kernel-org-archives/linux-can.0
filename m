Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60AE46D0B0;
	Mon, 12 Oct 2026 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795918; cv=none; b=WCjIa1DMjbX20ubI+VLypojqZ6Q4CIhFNBoWZa9nIdKOUiiGWOg3Pikg2n1qKJ+BvDyqM1ocPQO7hzZhXwFdbIu4acs8JLM6IOggT4RPLitNBZ/KDnywHkMNkt9Y7p5mmPphjmHxTn4G3lsHqOt1DezXWIU0Yd7u3j1D5Fr2QkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795918; c=relaxed/simple;
	bh=6nB5tsWF7Z5RNvLjIg0Icc00GP8xYNd4cXSXM7tiv3s=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=TJALshQKjv2no+L9Xbc6Wka+VNDXS6ng8ReVAs9b/+8tMu/k7lFU9Rk712ybsC4fceTplIKThk3TGkqtc7MkHmI8oRCnsXUnPEHWZylteRMwRMAKScXVqc+OGjahTOt6fUIxSEE6PHi7riT8NddwIEXvUmeR09aMr5VN71EBsh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=F5Fu3Ym2; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="F5Fu3Ym2"
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id ED79FDF88BA;
	Mon, 12 Oct 2026 11:05:03 +0200 (CEST)
Received: from zimbra65-e11.priv.proxad.net (unknown [172.20.243.215])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 8CC9C19F5AF;
	Mon, 12 Oct 2026 11:04:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1791795896;
	bh=6nB5tsWF7Z5RNvLjIg0Icc00GP8xYNd4cXSXM7tiv3s=;
	h=Date:From:To:Cc:In-Reply-To:Subject:From;
	b=F5Fu3Ym2jo9wXFjRkXjt/8qjzX28wvuMihiyQ/Kc/OCuI0iH/zhoiRcQjTJQHKzPB
	 89uwiSasBaBVvZ7TrBrPI2A/7VYe1VUGFlbevxGfeV0DP38yJtk0TqDX2fdpAJM9K3
	 HuHlbk6BmyTWE2kfC9hYi4izp5rkgekzQ5tV76I0gIsRQnbcj3dxCNUNQFPudVZ18O
	 sqACmLdWiM78x6Zf0XxOqVHwvjyTpvz8JFQTQXJXrn8eIXKBmd2Y/0YJzDPTy1amGf
	 vEv2rasJxN6GF7jCMH6WIsYQEDZpqgkisQNnnQEPCuMBMRGoKsUGpZSWpj76LmTGWL
	 n8LxFglSRuaKg==
Date: Mon, 12 Oct 2026 11:04:56 +0200 (CEST)
From: =?utf-8?Q?St=C3=A9phane?= Grosjean <stephane.grosjean@free.fr>
To: mkl@pengutronix.de, mailhol@kernel.org, 
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org
Message-ID: <1269621857.1047936901.1791795896395.JavaMail.root@zimbra65-e11.priv.proxad.net>
In-Reply-To: <179161489475.1406898.15730503460636169751@kernel.org>
Subject: Fwd: [PATCH 4/5] can: peak_usb: validate channel numbers in
 PCAN-USB FD
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - GC154 (Linux)/7.2.0-GA2598)
X-Authenticated-User: stephane.grosjean@free.fr

Hello Marc, Vincent and Oliver,

I need help (or training) to figure out how to deal with these AI bots:

- How many of them are there before the changes are accepted? It seems that=
 even if a patch has passed the Sashiko filter, we should still expect feed=
back from other bots...

- The fact that there are multiple levels of bots isn=E2=80=99t a problem i=
n itself, and is understandable. That feedback arrives on v1 even though v2=
 has already been analysed is also something I=E2=80=99m just learning: so =
when can we consider it safe to push a new version without fear of receivin=
g comments on the previous one?

- And finally, providing more explicit comments on our changes is also a go=
od thing. But when those comments themselves become a source of problems an=
d rejections=E2=80=94due to an overly nitpicky interpretation by a bot=E2=
=80=94it becomes far too time-consuming:

> The "entire message buffer is discarded" wording also reads as if
> this
> patch adds that behaviour. The goto fail path in
> pcan_usb_fd_decode_buf()
> is unchanged. Records decoded before the bad one have already been
> passed
> up via netif_rx(), and only the bad record and the ones after it are
> dropped.

Best regards,

-- St=C3=A9phane


----- Mail transf=C3=A9r=C3=A9 -----
> De: netdev-bot+sashiko@kernel.org
> =C3=80: "stephane grosjean" <stephane.grosjean@free.fr>
> Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com, wg@grandeg=
ger.com, linux-can@vger.kernel.org,
> linux-kernel@vger.kernel.org, "s grosjean" <s.grosjean@peak-system.fr>, k=
uba@kernel.org
> Envoy=C3=A9: Samedi 10 Octobre 2026 08:48:14
> Objet: Re: [PATCH 4/5] can: peak_usb: validate channel numbers in PCAN-US=
B FD
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to
> each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let
> patchwork
> know by including "pw-bot: cr" as a separate line at the end of your
> reply
> (one such reply per series is enough).
>=20
> - [High] The new check `channel >=3D usb_if->adapter->ctrl_count` only
>   keeps the index inside dev[].
> - [Low] The commit message for "can: peak_usb: validate channel
> numbers
>   in PCAN-USB FD" says the patch "prevents potential out-of-bounds=E2=80=
=A6
>=20
> --
>=20
> can: peak_usb: validate channel numbers in PCAN-USB FD
>=20
> This patch changes the channel number check in the four PCAN-USB FD
> decoders. The old bound was ARRAY_SIZE(usb_if->dev). The new bound is
> the
> adapter's ctrl_count, read through an adapter pointer that is now
> stored in
> struct pcan_usb_fd_if. Invalid channels now return -EINVAL instead of
> -ENOMEM.
>=20
> > Validate the channel number against the number of CAN controllers
> > supported by the adapter before performing the lookup. Any message
> > containing an invalid channel number is treated as malformed and
> > the
> > entire message buffer is discarded, as the device is considered to
> > be
> > providing untrusted data.
>=20
> [ ... ]
>=20
> > This prevents potential out-of-bounds accesses when handling
> > unexpected or corrupted messages received from PCAN-USB FD family
> > devices.
>=20
> [Severity: Low]
> Is "out-of-bounds" the right description here? This was the old
> check:
>=20
> =09if (pucan_msg_get_channel(rm) >=3D ARRAY_SIZE(usb_if->dev))
>=20
> dev[] has PCAN_USB_MAX_CHANNEL (2) entries. No index outside
> dev[0..1]
> could get past that check before this patch.
>=20
> What this patch seems to fix is a NULL pointer dereference on the
> single-channel adapters, PCAN-USB FD and PCAN-Chip USB. Both use
> .ctrl_count =3D PCAN_USBFD_CHANNEL_COUNT (1). pcan_usb_fd_init() only
> fills
> usb_if->dev[dev->ctrl_idx], and usb_if comes from kzalloc. On those
> adapters dev[1] therefore stays NULL.
>=20
> Before this patch, a device record with channel 1 passed the "< 2"
> check.
> Then, in URB completion context:
>=20
>   pcan_usb_fd_decode_canmsg(), _decode_status() and _decode_overrun()
>       read dev->netdev
>   pcan_usb_fd_decode_error()
>       wrote pdev->bec through container_of(NULL)
>=20
> Could the commit message name this device-triggered NULL dereference
> and
> the affected adapters? There is no Cc: stable tag, so this matters
> for
> backport decisions.
>=20
> The "entire message buffer is discarded" wording also reads as if
> this
> patch adds that behaviour. The goto fail path in
> pcan_usb_fd_decode_buf()
> is unchanged. Records decoded before the bad one have already been
> passed
> up via netif_rx(), and only the bad record and the ones after it are
> dropped.
>=20
> On the -EINVAL change: pcan_usb_fd_decode_error() and
> pcan_usb_fd_decode_overrun() already returned -EINVAL before this
> patch.
> peak_usb_read_bulk_callback() also ignores the returned error code.
>=20
> > diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > index 82502594a4092..ddbb2be1de0dd 100644
> > --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
>=20
> [ ... ]
>=20
> > @@ -536,8 +537,12 @@ static int pcan_usb_fd_decode_canmsg(struct
> > pcan_usb_fd_if *usb_if,
> >  =09struct sk_buff *skb;
> >  =09const u16 rx_msg_flags =3D le16_to_cpu(rm->flags);
> > =20
> > -=09if (pucan_msg_get_channel(rm) >=3D ARRAY_SIZE(usb_if->dev))
> > -=09=09return -ENOMEM;
> > +=09/* Reject invalid channel numbers reported by the firmware.
> > +=09 * Any channel below ctrl_count is guaranteed to have a valid
> > +=09 * entry in usb_if->dev[].
> > +=09 */
> > +=09if (pucan_msg_get_channel(rm) >=3D usb_if->adapter->ctrl_count)
> > +=09=09return -EINVAL;
> > =20
> >  =09dev =3D usb_if->dev[pucan_msg_get_channel(rm)];
> >  =09netdev =3D dev->netdev;
>=20
> [Severity: High]
> Does this guarantee hold? The ctrl_count check keeps the index inside
> dev[], but nothing makes sure usb_if->dev[channel] points to a live
> device.
>=20
> On the 2-channel adapters (PCAN-USB Pro FD and PCAN-USB X6,
> ctrl_count =3D
> PCAN_USBPROFD_CHANNEL_COUNT =3D 2), the new check is the same as the
> old
> ARRAY_SIZE() check.
>=20
> pcan_usb_fd_decode_status(), pcan_usb_fd_decode_error() and
> pcan_usb_fd_decode_overrun() repeat the same comment and check.
>=20
> The first case is a NULL entry during probe. peak_usb_probe() creates
> channels one at a time, and peak_usb_create_dev() registers the
> netdev
> before it calls dev_init():
>=20
> peak_usb_create_dev()
>     register_candev(netdev);
>     ...
>     dev->adapter->dev_init(dev);
>         pcan_usb_fd_init()
>             pdev->usb_if->dev[dev->ctrl_idx] =3D dev;
>=20
> Once channel 0 is registered and initialised, can0 can be brought up
> while
> dev[1] is still NULL. The window covers channel 0's dev_set_bus() and
> dev_get_can_channel_id() bulk commands, which the device can stall
> for up
> to 1000 ms each. It also covers register_candev() for can1.
>=20
> Opening can0 submits RX URBs on the bulk-IN endpoint that both
> channels
> share. pcan_usb_fd_decode_buf() routes each record by its own channel
> field.
>=20
> Could a channel-1 record then pass the "1 >=3D 2" test and dereference
> NULL
> through dev->netdev here? The same would apply to dev->can.state in
> pcan_usb_fd_decode_status() and to the write to pdev->bec in
> pcan_usb_fd_decode_error().
>=20
> The second case is a dangling entry when probe fails. If channel 1's
> dev_set_bus() fails after dev_init(), peak_usb_create_dev() takes
> this
> path:
>=20
> adap_dev_free:
> =09if (dev->adapter->dev_free)
> =09=09dev->adapter->dev_free(dev);
>=20
> lbl_unregister_candev:
> =09unregister_candev(netdev);
>=20
> pcan_usb_fd_free() does nothing for a device that has prev_siblings
> set,
> and it never clears usb_if->dev[1]:
>=20
> static void pcan_usb_fd_free(struct peak_usb_device *dev)
> {
> =09/* last device: can free shared objects now */
> =09if (!dev->prev_siblings && !dev->next_siblings) {
>=20
> dev1 is then freed. peak_usb_probe() calls peak_usb_disconnect()
> directly,
> without usb_disable_interface(), so can0's RX URBs are still live.
>=20
> Can a channel-1 record arriving in that window reach freed memory?
> That
> includes the write in pcan_usb_fd_decode_error().
>=20
> Disconnects started by the USB core (unplug, sysfs unbind, rmmod) do
> not
> seem to be affected. peak_usb_driver does not set soft_unbind, so
> usb_unbind_interface() kills the URBs before ->disconnect().
>=20
> The follow-up commit "can: peak_usb: harden PCAN-USB message
> validation"
> only touches pcan_usb.c and does not cover this.
>=20
> Would it be more complete to treat a NULL usb_if->dev[ch] as a
> malformed
> message in each FD decoder? That would also cover the single-channel
> case
> this patch targets.
>=20
> Clearing the entry on per-channel teardown or failure would handle
> the
> dangling case. The comment would also need to be corrected.
>=20
> [ ... ]
>=20
> --
> Sashiko AI review =C2=B7
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-canfd_check_=
channel_idx-v1-0-0a3bb82f4e09%40peak-system.fr
>=20
