Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592955A876A;
	Mon, 19 Oct 2026 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418398; cv=none; b=ikOLDRIyzmzebiKSwHHAXqvFbxxHj4PtxZhuDB7VsndFoIR2yIH+ZLtajqAH9kVwhJu/6r8hiN/jzQtHgk4m769xQlWaRxYxXOGRsrb6purN7ODkNNQiVx8c/YQI3YCaCYhJhp+uqp/XLkpWq2ZndkYQCCzUwrSW3pXNvE2VdoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418398; c=relaxed/simple;
	bh=yWnIN9sT/XPjg2/Jr9Aa6xK/8FyeWawOaeqkf8NOXbc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=Hv45vf2cK2EkW0DRAcOL1mPlZaarSTlaQ5w2KlSwbv1zQrYug5WZVMVoATJO/fghVoYMxvmOiSOG6r8ZkmYiseiVj6+RDym49aUhX1bl0WWlsc/E28uErdLxWRpTNItm52t3ATK3fo68K3tfICsMc4Rrs5VMAtlpFw+i9qmvD44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=NFpbY/kr; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="NFpbY/kr"
Received: from zimbra65-e11.priv.proxad.net (unknown [172.20.243.215])
	by smtp4-g21.free.fr (Postfix) with ESMTP id DE25C19F5AF;
	Mon, 19 Oct 2026 15:59:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1792418387;
	bh=yWnIN9sT/XPjg2/Jr9Aa6xK/8FyeWawOaeqkf8NOXbc=;
	h=Date:From:To:Cc:In-Reply-To:Subject:From;
	b=NFpbY/krvvfad8GhdJ5i0Up8Q8lQRFlNx5eJ6tt030EbfKALsyuwgVhC1Z5MFIBhB
	 mtpxd3m0bL0wpTg7koIsaajbueeYIVQMVfjQ6Fs416DS/+gnG882tC5aoLS0uIbqQ/
	 N3DxhjO5GFY9lraQDv46SiH+/yUq3o1VQRVrhBRzaEO5L0cZMfOsOdUe+zyj31CmLC
	 lKwdldNUf+5IIEZQ5zpP073hZ/dUogGWnkl0bRQ2qDPkKvK1R6RUGPytGa56VszcW3
	 EJurp51sL/eid4NpMbpGlX19NAV9cxwHN9rjursV6+KN3tD8ohaWEuUx9bAySpofds
	 XEhEqFwZRHzoA==
Date: Mon, 19 Oct 2026 15:59:47 +0200 (CEST)
From: =?utf-8?Q?St=C3=A9phane?= Grosjean <stephane.grosjean@free.fr>
To: netdev-bot+sashiko@kernel.org
Cc: mkl@pengutronix.de, mailhol@kernel.org, error27@gmail.com, wg@grandegger.com, 
	s grosjean <s.grosjean@peak-system.fr>, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kuba@kernel.org
Message-ID: <1570958385.1202784252.1792418387819.JavaMail.root@zimbra65-e11.priv.proxad.net>
In-Reply-To: <179169441005.1406898.14224990493927376539@kernel.org>
Subject: Re: [PATCH v2 5/5] can: peak_usb: harden PCAN-USB message
 validation
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



----- Mail original -----
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 (2) =C2=B7 Low: 0
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
> - [High] The patch says it rejects PCAN-USB messages that would cause
>   reads outside the received USB data, but one path is still
>   unchecked:=E2=80=A6
>=20
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but the
> encoder
>   and decoder disagree on the wire layout for RTR frames with SRR
>   set.
> - [Medium] This problem wasn't introduced by this patch, but when the
>   decoder rejects a message, the diagnostic dump prints the whole rx=E2=
=80=A6
>=20
> --
>=20
> can: peak_usb: harden PCAN-USB message validation
>=20
> This patch adds bounds checks to the PCAN-USB rx decoder. The
> status_len
> byte at the start of each record and the SRR private-id byte after a
> data
> frame are now consumed only if they fit inside the received USB
> buffer.
> Malformed messages are rejected with -EINVAL.
>=20
> > diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c
> > b/drivers/net/can/usb/peak_usb/pcan_usb.c
> > index 169c00d93463c..56ddd134bae0f 100644
> > --- a/drivers/net/can/usb/peak_usb/pcan_usb.c
> > +++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
> > @@ -696,8 +696,11 @@ static int pcan_usb_decode_data(struct
> > pcan_usb_msg_context *mc, u8 status_len)
> >  =09=09mc->ptr +=3D rec_len;
> > =20
> >  =09=09/* Ignore next byte (client private id) if SRR bit is set */
> > -=09=09if (can_id_flags & PCAN_USB_TX_SRR)
> > +=09=09if (can_id_flags & PCAN_USB_TX_SRR) {
> > +=09=09=09if ((mc->ptr + 1) > mc->end)
> > +=09=09=09=09goto decode_failed;
> >  =09=09=09mc->ptr++;
> > +=09=09}
>=20
> [Severity: Medium]
> This is a pre-existing issue, but is the private-id byte also present
> for
> RTR frames?
>=20
> In pcan_usb_decode_data(), this skip and the new check exist only in
> the
> non-RTR branch:
>=20
> =09if (status_len & PCAN_USB_STATUSLEN_RTR) {
> =09=09cf->can_id |=3D CAN_RTR_FLAG;
> =09} else {
> =09=09...
> =09=09if (can_id_flags & PCAN_USB_TX_SRR) {
>=20
> But pcan_usb_encode_msg() appends the writer id for RTR frames as
> well:
>=20
> =09/* can data */
> =09if (!(cf->can_id & CAN_RTR_FLAG)) {
> =09=09memcpy(pc, cf->data, cf->len);
> =09=09pc +=3D cf->len;
> =09}
>=20
> =09/* SRR bit needs a writer id (useless here) */
> =09if (can_id_flags & PCAN_USB_TX_SRR)
> =09=09*pc++ =3D 0x80;
>=20
> SRR is set whenever CAN_CTRLMODE_LOOPBACK is enabled. Suppose the
> firmware's
> loopback echo of an RTR frame includes that byte. Then mc->ptr is
> left
> pointing at it, and pcan_usb_decode_msg() reads 0x80 as the next
> status_len
> byte.
>=20
> PCAN_USB_STATUSLEN_INTERNAL is clear in 0x80, so the byte would be
> decoded
> as a bogus standard-ID data frame. Every later record in the URB
> would then
> be parsed out of phase. That gives phantom frames, or an early
> -EINVAL that
> drops the rest of the URB.
>=20
> The real RTR echo format can't be confirmed from the source. Both the
> encoder and decoder lines came from the same commit 3a7939495ce8, so
> the
> difference may be intentional. The later reads are bounds-checked, so
> no
> out-of-bounds access results.
>=20
> Could the firmware behaviour be checked either way?
>=20
> > @@ -733,14 +736,19 @@ static int pcan_usb_decode_msg(struct
> > peak_usb_device *dev, u8 *ibuf, u32 lbuf)
> >  =09int err;
> > =20
> >  =09for (err =3D 0; mc.rec_idx < mc.rec_cnt && !err; mc.rec_idx++) {
> > -=09=09u8 sl =3D *mc.ptr++;
> > -
> > -=09=09/* handle status and error frames here */
> > -=09=09if (sl & PCAN_USB_STATUSLEN_INTERNAL) {
> > -=09=09=09err =3D pcan_usb_decode_status(&mc, sl);
> > -=09=09/* handle normal can frames here */
> > +=09=09/* check if status_len byte can be read next */
> > +=09=09if (mc.ptr >=3D mc.end) {
> > +=09=09=09err =3D -EINVAL;
>=20
> [Severity: Medium]
> This isn't a bug introduced by this patch, but this new -EINVAL path
> (and
> the truncated SRR one above) leads to the diagnostic dump in
> peak_usb_read_bulk_callback():
>=20
> =09err =3D dev->adapter->dev_decode_buf(dev, urb);
> =09if (err)
> =09=09pcan_dump_mem("received usb message",
> =09=09=09      urb->transfer_buffer,
> =09=09=09      urb->transfer_buffer_length);
>=20
> Doesn't this dump the full rx_buffer_size allocation instead of only
> the
> urb->actual_length bytes the device sent?
>=20
> The rx buffers come from kmalloc() in peak_usb_start() and are not
> zeroed.
> After a short malformed transfer such as [00 01 00] (truncated CAN
> id), the
> bytes past the received data are uninitialized slab contents.
>=20
> pcan_dump_mem() prints them at KERN_INFO with print_hex_dump(), with
> no rate
> limit and no debug-only guard. Earlier decode failures could already
> reach
> this dump.
>=20
> Would it make sense to pass urb->actual_length here instead?
>=20
> >  =09=09} else {
> > -=09=09=09err =3D pcan_usb_decode_data(&mc, sl);
> > +=09=09=09u8 sl =3D *mc.ptr++;
> > +
> > +=09=09=09/* handle status and error frames here */
> > +=09=09=09if (sl & PCAN_USB_STATUSLEN_INTERNAL) {
> > +=09=09=09=09err =3D pcan_usb_decode_status(&mc, sl);
>=20
> [Severity: High]
> Can a truncated bus event record still cause an out-of-bounds read
> here?
>=20
> pcan_usb_decode_status() only checks that the function and number
> bytes
> fit, and then advances past them:
>=20
> =09if ((mc->ptr + 2) > mc->end)
> =09=09return -EINVAL;
>=20
> =09f =3D mc->ptr[PCAN_USB_CMD_FUNC];
> =09n =3D mc->ptr[PCAN_USB_CMD_NUM];
> =09mc->ptr +=3D PCAN_USB_CMD_ARGS;
>=20
> At this point mc->ptr can equal mc->end. Suppose the timestamp bit is
> clear,
> f is PCAN_USB_REC_BUSEVT, and n is PCAN_USB_ERR_CNT_DEC or
> PCAN_USB_ERR_CNT_INC. Then the call goes straight to
> pcan_usb_handle_bus_evt():
>=20
> =09=09pdev->bec.rxerr =3D mc->ptr[1];
> =09=09pdev->bec.txerr =3D mc->ptr[2];
>=20
> These read mc->end + 1 and mc->end + 2 with no check. The later
> (mc->ptr + rec_len) > mc->end check in pcan_usb_decode_status() runs
> only
> after these reads. rec_len also comes from the device and can be 0.
>=20
> For example, the 5 byte transfer [00 01 40 05 00] passes the new
> status_len
> check. It then reads ibuf[6] and ibuf[7], past actual_length, and is
> reported as successfully decoded.
>=20
> Now take a full 64 byte transfer whose last record is a bus event
> header
> ending at the last byte. The reads land on ibuf[65] and ibuf[66],
> which are
> outside the kmalloc-64 rx buffer allocated in peak_usb_start().
>=20
> Those bytes are stored in pdev->bec. Userspace can read them through
> pcan_usb_get_berr_counter() (IFLA_CAN_BERR_COUNTER) and in the CAN
> error
> frames built by pcan_usb_decode_error().
>=20
> The commit message says the patch rejects buffers "whose contents
> would
> otherwise lead to accesses outside the received USB data area".
> Should
> pcan_usb_handle_bus_evt() check something like (mc->ptr + 3) >
> mc->end
> before reading these bytes, rather than relying on rec_len from the
> device?
>=20
> >  =09=09=09/* handle normal can frames here */
> > +=09=09=09} else {
> > +=09=09=09=09err =3D pcan_usb_decode_data(&mc, sl);
> > +=09=09=09}
> >  =09=09}
> >  =09}
>=20
> [ ... ]
>=20
> --
> Sashiko AI review =C2=B7
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009-canfd_check_=
channel_idx-v2-0-f7b772929791%40peak-system.fr
>=20

Thanks for the review. All the issues reported here are addressed in v3,
which also adds fixes for related issues in the PCAN-USB Pro driver and
in the core probe/RX paths.

pw-bot: cr
