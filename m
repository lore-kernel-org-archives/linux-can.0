Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241004A341D;
	Mon,  5 Oct 2026 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210169; cv=none; b=X1+L2EZUUEfwLhZ1NEgbNoqwk1BgpUT4FNAp35pcU2PRrIL1ZucUEQB4BS3PPR2Xrks3SFdspzDfPC3O/K6ad6mJCnBIDPlTx9FHsxE6wCe1+WjZx59n3amAfz42FzMivXq5gv8fy43imWrL8JCOxp4s+uEPV8yfRphmIS3jHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210169; c=relaxed/simple;
	bh=PxpMxYtO9jOTvLd9gPf9HskQg0Y1AaKEfqBx8ttbcig=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=n4/cJjA8dPlLquqUEqctNg0vBmepcmG53qqNpGATXWzvxMwEJfTnCRswYeXRJuTpI6+Lo/xP1J+6g6/EiBQzy8DXaGvah3KmlP4l8yunNx84QqSlXliaNrOKQJvqCevx49X8gvzm5obfdLcuC2UiRu75HMMCISXG1Np+uM89T4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=TjZFngIf; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="TjZFngIf"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id EA9AFDF8A03;
	Mon,  5 Oct 2026 16:22:20 +0200 (CEST)
Received: from zimbra65-e11.priv.proxad.net (unknown [172.20.243.215])
	by smtp2-g21.free.fr (Postfix) with ESMTP id B2295200410;
	Mon,  5 Oct 2026 16:22:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1791210132;
	bh=PxpMxYtO9jOTvLd9gPf9HskQg0Y1AaKEfqBx8ttbcig=;
	h=Date:From:To:Cc:In-Reply-To:Subject:From;
	b=TjZFngIfVc408y9R0ACJj7zGvxMmgAlx+E2skaCwNyLGjvvtN9fWhjrnX17jHAE2Y
	 6z0Zw8XnAzssPXkHEQvoc108OzuoInhdcp/LuZ85tlHzJW5XhufgQ+Q4TyPsW5TgW6
	 StWfBBQVPfUE55WRUpUSAdeauf+V/cTdHgukWUVFa2xqK0glaV2NDLdTkazxgZyQxI
	 SphVB471qEy6o6LJNMtcColR5cRQKTMcY2GESV1YAqZiA1IgAXm5dgHSTMpnJQSv/d
	 JYM+878LgPzMYpGGEaqjVFNGrlmWmgzlaDWeQGdo5W/9atp7BEILmhWIb1UzZlQJg7
	 18lATZgVfocDQ==
Date: Mon, 5 Oct 2026 16:22:12 +0200 (CEST)
From: =?utf-8?Q?St=C3=A9phane?= Grosjean <stephane.grosjean@free.fr>
To: mkl@pengutronix.de
Cc: mailhol@kernel.org, s grosjean <s.grosjean@peak-system.fr>, 
	kernel@pengutronix.de, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kuba@kernel.org
Message-ID: <1730786945.910525984.1791210132571.JavaMail.root@zimbra65-e11.priv.proxad.net>
In-Reply-To: <179106844116.1406898.10605612528694983606@kernel.org>
Subject: Re: [PATCH can-next 6/7] can: peak_usb: Add bus error reporting for
 the PCAN-USB FD family
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - GC151 (Linux)/7.2.0-GA2598)
X-Authenticated-User: stephane.grosjean@free.fr

Hello Marc,

Can you let me know if I need to make changes myself to these patches you s=
ent, and if so, how? (Should the new requested changes=E2=80=94which are un=
related to the original patch=E2=80=94be included in a new version? Or in a=
 different series?...)

Thank you for your help!

Best regards,

-- St=C3=A9phane

----- Mail original -----
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 (1) =C2=B7 Low: 1
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
> - [High] The invalid-channel guard is incomplete.
> - [Medium] pcan_usb_fd_start() now calls `err =3D
>   pcan_usb_fd_set_options(dev, 1, PUCAN_OPTION_ERROR, usb_opts);`
>   (line=E2=80=A6
> - [Low] The new `if (!dev)` check in pcan_usb_fd_decode_error() fixes
> an
>   existing NULL pointer dereference, but the fix is folded into a=E2=80=
=A6
>=20
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but when
>   peak_usb_start() fails at dev_set_bus(dev, 1) after=E2=80=A6
>=20
> --
>=20
> can: peak_usb: Add bus error reporting for the PCAN-USB FD family
>=20
> This patch adds CAN bus error reporting for the PEAK-System
> USB-to-CAN FD
> devices. pcan_usb_fd_start() now enables PUCAN_OPTION_ERROR for each
> channel, pcan_usb_fd_decode_error() turns firmware error records into
> CAN
> error frames, and the adapters now advertise
> CAN_CTRLMODE_BERR_REPORTING.
> It also adds a NULL check for an invalid channel in
> pcan_usb_fd_decode_error().
>=20
> > diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > index 82502594a4092..9081f30e3d356 100644
> > --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> > @@ -661,17 +661,73 @@ static int pcan_usb_fd_decode_error(struct
> > pcan_usb_fd_if *usb_if,
> >  =09struct pucan_error_msg *er =3D (struct pucan_error_msg *)rx_msg;
> >  =09struct pcan_usb_fd_device *pdev;
> >  =09struct peak_usb_device *dev;
> > +=09struct can_frame *cf;
> > +=09struct sk_buff *skb;
> > +=09u8 can_err_tx =3D 0;
> > =20
> >  =09if (pucan_ermsg_get_channel(er) >=3D ARRAY_SIZE(usb_if->dev))
> >  =09=09return -EINVAL;
> > =20
> > +=09/* Guard against bogus channel 1 reports from single-channel
> > adapters.
> > +=09 * Treat the entire URB as invalid in that case.
> > +=09 */
> >  =09dev =3D usb_if->dev[pucan_ermsg_get_channel(er)];
> > +=09if (!dev)
> > +=09=09return -EINVAL;
> > +
>=20
> [Severity: High]
> This check covers pcan_usb_fd_decode_error(). Do the other decoders
> that
> read a channel from the same URB need it too?
>=20
> On PCAN-USB FD and PCAN-Chip USB, ctrl_count is
> PCAN_USBFD_CHANNEL_COUNT
> (1). pcan_usb_fd_init() therefore sets only usb_if->dev[0], and
> dev[1]
> stays NULL. The ARRAY_SIZE(usb_if->dev) bound is PCAN_USB_MAX_CHANNEL
> (2),
> so channel 1 passes that check.
>=20
> The other three decoders still dereference without a NULL check:
>=20
> pcan_usb_fd_decode_canmsg():
> =09dev =3D usb_if->dev[pucan_msg_get_channel(rm)];
> =09netdev =3D dev->netdev;
>=20
> pcan_usb_fd_decode_status():
> =09dev =3D usb_if->dev[pucan_stmsg_get_channel(sm)];
> =09pdev =3D container_of(dev, struct pcan_usb_fd_device, dev);
> =09netdev =3D dev->netdev;
>=20
> pcan_usb_fd_decode_overrun():
> =09dev =3D usb_if->dev[pufd_omsg_get_channel(ov)];
> =09netdev =3D dev->netdev;
>=20
> Suppose the firmware sends the bogus channel 1 described in the new
> comment
> on a CAN_RX, STATUS or OVERRUN record. Wouldn't that dereference NULL
> in
> peak_usb_read_bulk_callback()->pcan_usb_fd_decode_buf()?
>=20
> The commit message says "Parsing of the entire URB is aborted if the
> firmware reports an invalid channel". As far as I can tell, that only
> holds
> for error records. The later loopback patch in this series doesn't
> seem to
> change these decoders either.
>=20
> [Severity: Low]
> The code itself is fine, but this check also fixes an existing NULL
> pointer
> dereference. Before this patch, pcan_usb_fd_decode_error() did:
>=20
> =09dev =3D usb_if->dev[pucan_ermsg_get_channel(er)];
> =09pdev =3D container_of(dev, struct pcan_usb_fd_device, dev);
> =09pdev->bec.txerr =3D er->tx_err_cnt;
>=20
> PUCAN_OPTION_ERROR was already enabled on first open, so a channel 1
> error
> record on a single-channel adapter could already fault there.
>=20
> Could this fix be split out with a Fixes: tag and Cc: stable, as was
> done
> for the earlier "fix missing CAN_ERR_FLAG ..." patch in this series?
> That
> way stable trees would pick it up.
>=20
> [ ... ]
>=20
> > @@ -912,12 +969,17 @@ static int pcan_usb_fd_start(struct
> > peak_usb_device *dev)
> >  =09=09peak_usb_init_time_ref(&pdev->usb_if->time_ref,
> >  =09=09=09=09       &pcan_usb_pro_fd);
> > =20
> > -=09=09/* enable USB calibration messages */
> > -=09=09err =3D pcan_usb_fd_set_options(dev, 1,
> > -=09=09=09=09=09      PUCAN_OPTION_ERROR,
> > -=09=09=09=09=09      PCAN_UFD_FLTEXT_CALIBRATION);
> > +=09=09/* enable USB calibration messages (needed only once for the
> > +=09=09 * entire interface)
> > +=09=09 */
> > +=09=09usb_opts |=3D PCAN_UFD_FLTEXT_CALIBRATION;
> >  =09}
> > =20
> > +=09/* set channel device options: always asks for bus error
> > notifications
> > +=09 * to get (at least) rxerr/txerr, as well as any USB-specific
> > option.
> > +=09 */
> > +=09err =3D pcan_usb_fd_set_options(dev, 1, PUCAN_OPTION_ERROR,
> > usb_opts);
> > +
> >  =09pdev->usb_if->dev_opened_count++;
>=20
> [Severity: Medium]
> Can dev_opened_count end up one too high here?
>=20
> pcan_usb_fd_set_options() now runs on every open. If it fails, the
> counter
> is still incremented before err is returned. peak_usb_start() then
> takes
> the err_adapter path:
>=20
> =09if (dev->adapter->dev_start) {
> =09=09err =3D dev->adapter->dev_start(dev);
> =09=09if (err)
> =09=09=09goto err_adapter;
> =09}
>=20
> err_adapter frees the tx URBs and kills the rx URBs, but it never
> calls
> adapter->dev_stop(). ndo_stop isn't called after a failed open
> either.
>=20
> With the count stuck too high:
>=20
> - the =3D=3D 0 check here no longer resets time_ref or re-enables
> calibration
>   on the next first open
> - the =3D=3D 1 check in pcan_usb_fd_stop() never matches, so calibration
>   messages are never turned off
> - the > 0 check in pcan_usb_fd_exit() gives the wrong result
>=20
> Before this patch, a non-first open could only fail in
> pcan_usb_fd_set_filter_std(), which returns before the increment.
> Should
> the increment be skipped when pcan_usb_fd_set_options() fails?
>=20
> [Severity: Medium]
> This is a pre-existing issue and was not introduced by this patch,
> but a
> related path exists when pcan_usb_fd_start() succeeds and bus-on then
> fails
> in peak_usb_start():
>=20
> =09err =3D dev->adapter->dev_set_bus(dev, 1);
> =09if (err)
> =09=09goto err_adapter;
>=20
> err_adapter doesn't call dev_stop() here either. dev_opened_count
> stays
> incremented and the firmware notification options stay enabled. With
> this
> patch, the per-channel PUCAN_OPTION_ERROR is also left armed in that
> case.
>=20
> Should peak_usb_start() undo dev_start() on this path?
>=20
> [ ... ]
>=20
> --
> Sashiko AI review =C2=B7
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-peak_usb_enh=
ancements-v1-0-50e965755c06%40pengutronix.de
>=20
>=20
