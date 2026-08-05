Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1896646EC86
	for <linux-can@vger.kernel.org>; Wed,  5 Aug 2026 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935306; cv=none; b=bAfQ5cenmdyRy/pQpQSmNOOpIotHZo8oK1G/tkUHKF17BmF9g5GKXEVsznM7GBRgBwOfN0LF9YnAMjo+PoS+kxQ7wYjstvQQFhJXYYb1BtfR1h/lqtnS+zDNNZwJq2tm5miDKpC4vGCjozvQtuQSB/2tXH78sWh+Kq5ZyT3sAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935306; c=relaxed/simple;
	bh=A4umAHT0APo0sKe9b0TZ+bADQobjVTQvgaBV6uflcFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AScDAI/5CItVHDUtqJ9He667OnKOZizU5b3xBTQeCNNKUsOCbRRtoGGQOhTCXx7nUCaMQbhcVydA6LUYuffv4F12r/VcRvNaGBFGuVdpTzRo2LKhZP1q18SD5ZY79NCbcMeh09IlD9o/QW0W6/ka5GkFWwdTHYU3i+pd2iR6EBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=QETQ4kgr; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="QETQ4kgr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1785935302; x=1786540102; i=ps.report@gmx.net;
	bh=jn8U8QFHzQYxUIBsjbqmsWdgSKnv4nBL7rYEG2HIVeE=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QETQ4kgrhanx/QYe1Voa9uYNI/sOxsHManUAvXLx7vRn5Gdt/P6TPKQwx+y/yAlW
	 N2HGdqIKOfe2+1gisELNzhjyJn6M/hOnmprHH04uLHqKexLTJKcaP7qdD9tIKefuH
	 gK+zdkVJUoVCGiLK9poeQg9nHeYo5J+LwYFbWN7QYVRduZs2XgZyxIPVY6WmCkzDj
	 onAogwOe6AhdOa5d11Zqbay3sE4jw88U68OITCR6Ut1BwMo8U2mTz9PxGy86xuBFe
	 wxkYUV7/jrq9o6A4eASkqPT2rA8n3oXfb6JBnPAXNuZpGTAQbV4X2k6UgkseO91XZ
	 9UTWQBCsWGYtbnks5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4b1o-1ws9Jo0IFS-00Cs3S; Wed, 05
 Aug 2026 15:08:22 +0200
Date: Wed, 5 Aug 2026 15:08:20 +0200
From: Peter Seiderer <ps.report@gmx.net>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: =?UTF-8?B?U3TDqXBoYW5l?= Grosjean <stephane.grosjean@free.fr>,
 =?UTF-8?B?U3TDqXBoYW5l?= Grosjean <s.grosjean@peak-system.fr>, linux-can
 Mailing List <linux-can@vger.kernel.org>
Subject: Re: [PATCH 0/4] can: usb: Add driver for HMS IXXAT USB-to-CAN
 adapters
Message-ID: <20260805150820.17fd621c@pc-1>
In-Reply-To: <9a8bb69e-7653-4ea1-b67d-f7cbd83a4cd2@kernel.org>
References: <20260723072955.32575-1-stephane.grosjean@free.fr>
	<9a8bb69e-7653-4ea1-b67d-f7cbd83a4cd2@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lY/M38QzVlzc+y9NyHpMDCXBAkY7gETuuowcvIAVE96UUMjIzJ0
 7OMwkQ9WPyE4ZOHOo4o5hzZ1i1/56Kq831JuhG42hy9DQX+p22pXB/l7tzEz2IW9qwwYZrB
 jcw+elPJTRXg0uwe4JGoEfiEgQdlzhzMviUJeUXC/aTB9Kfu7Ml/X1Rg5J+fAGWvcj67Osj
 a9OGB8VkgsoUk3jqahS5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+CSd4ChpytM=;s6mhx2dP0/HGgHe/5CfjKy75m3u
 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

Hello St=C3=A9phane,

On Mon, 27 Jul 2026 12:08:08 +0200, Vincent Mailhol <mailhol@kernel.org> wr=
ote:

> Bonjour St=C3=A9phane,
>=20
> On 23/07/2026 ac 09:29, St=C3=A9phane Grosjean wrote:
> > From: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr> =20
>=20
> Could you put the maintainers in Cc? Use either
>=20
>   ./scripts/get_maintainer.pl
>=20
> or switch to the more modern b4 tool which will handle all this
> automatically for you.
>=20
>   https://b4.docs.kernel.org/en/latest/
>=20
> I am asking because I=C2=A0do not put the same focus on e-mails sent to t=
he
> mailing list as I=C2=A0do for e-mails sent directly to me.
>=20
> > This series adds a SocketCAN driver for the HMS Networks IXXAT family of
> > USB-to-CAN and USB-to-CAN FD interface adapters.
> >=20
> > The driver supports two USB communication layers:
> > - CL1: the protocol for classic CAN 2.0b devices with legacy firmware
> > - CL2: the newer protocol used by recent device firmware versions
> >=20
> > Supported devices (VID 0x08d8 and 0x08db):
> >   USB-to-CAN Compact / Embedded / Professional / Automotive / Plugin (C=
L1)
> >   USB-to-CAN FD Compact / Professional / Automotive / MiniPCIe       (C=
L2)
> >   USB-to-CAN/FD Pro / Standard / Standard Card / Pro Module /
> >                       Standard Module                                (C=
L2)
> >   USB-to-CAR, CAN-IDM101, CAN-IDM200                                 (C=
L2)
> >=20
> > Supported CAN control modes (device-dependent):
> >   listen-only, loopback, triple-sampling, bus-error reporting,
> >   CAN FD (ISO 11898-1:2015), non-ISO CAN FD, one-shot
> >=20
> > Additional features:
> >   - Hardware receive timestamps propagated via skb_hwtstamps
> >   - Bus error counter (do_get_berr_counter)
> >   - TX echo via the SocketCAN echo skb mechanism (up to 32 in flight)
> >   - Up to 5 independent CAN channels per physical device
> >   - Automatic protocol layer selection based on firmware version
> >=20
> > Signed-off-by: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>
> >=20
> > St=C3=A9phane Grosjean (4):
> >   can: usb: ixxat_usb: add shared header
> >   can: usb: ixxat_usb: add CL1 legacy protocol layer
> >   can: usb: ixxat_usb: add CL2/V2 protocol layer with CAN
> >   can: usb: ixxat_usb: add core driver and Kconfig/Makefile =20
>=20
> I think that the series is upside-down. We should be able to compile
> each individual patch.
>=20
> You should start by adding relevant core portion of the header and the
> core driver but with an empty
>=20
>   struct usb_device_id
>=20
> table. And then add the different protocols while updating the core and
> the header accordingly of the new needs.
>=20
> >  drivers/net/can/usb/Kconfig                   |   17 +
> >  drivers/net/can/usb/Makefile                  |    1 +
> >  drivers/net/can/usb/ixxat_usb/Makefile        |    3 +
> >  drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c |  188 ++
> >  drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c |  347 +++
> >  .../net/can/usb/ixxat_usb/ixxat_usb_core.c    | 2567 +++++++++++++++++
> >  .../net/can/usb/ixxat_usb/ixxat_usb_core.h    |  862 ++++++
> >  7 files changed, 3985 insertions(+)
> >  create mode 100644 drivers/net/can/usb/ixxat_usb/Makefile
> >  create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c
> >  create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
> >  create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
> >  create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h =20
>=20
> A few other global comments:
>=20
>   - You are doing a lot of open coded mask manipulations. For example:
>     IXXAT_USB_GET_BUSTYPE() or IXXAT_USB_DECODE_DLC(). Please define a
>     mask with GENMASK() (or one of its GENMASK_U*() variants) and use
>     FIELD_GET() and FIELD_PREP to get and set the values.
>=20
>   - When you initialize a static const struct, directly put the literal
>     value. It doesn't improve the readability to have an intermediate
>     macro. For example do:
>=20
> 	static const struct can_bittiming_const usb2can_bt =3D {
> 		.name =3D KBUILD_MODNAME,
> 		.tseg1_min =3D 1,
> 		.tseg1_max =3D 16,
> 		.tseg2_min =3D 1,
> 		.tseg2_max =3D 8,
> 		.sjw_max =3D 4,
> 		.brp_min =3D 1,
> 		.brp_max =3D 64,
> 		.brp_inc =3D 1,
> 	};
>=20
>     instead of:
>=20
> 	static const struct can_bittiming_const usb2can_bt =3D {
> 		.name =3D KBUILD_MODNAME,
> 		.tseg1_min =3D IXXAT_USB2CAN_TSEG1_MIN,
> 		.tseg1_max =3D IXXAT_USB2CAN_TSEG1_MAX,
> 		.tseg2_min =3D IXXAT_USB2CAN_TSEG2_MIN,
> 		.tseg2_max =3D IXXAT_USB2CAN_TSEG2_MAX,
> 		.sjw_max =3D IXXAT_USB2CAN_SJW_MAX,
> 		.brp_min =3D IXXAT_USB2CAN_BRP_MIN,
> 		.brp_max =3D IXXAT_USB2CAN_BRP_MAX,
> 		.brp_inc =3D IXXAT_USB2CAN_BRP_INC,
> 	};
>=20
>=20
>=20
> Yours sincerely,
> Vincent Mailhol
>=20
>=20

Take a look at '[PATCH v9] can: usb: IXXAT USB-to-CAN adapters drivers' ([1=
]) and
'[PATCH v10 1/3] can: usb: IXXAT USB-to-CAN adapters drivers' ([2]) for
previous attempts (and some more history) to bring the IXXAT driver upstream
already addressing a lot of Vincent Mailhol comments/suggestions...

Sorry, no updates from my side as the project (and the access to the hardwa=
re)
for me ended some time ago...

Regards,
Peter

[1] https://lore.kernel.org/linux-can/20230522200144.15949-1-ps.report@gmx.=
net/T/#u
[2] https://lore.kernel.org/linux-can/20230707171412.31195-2-ps.report@gmx.=
net/T/#u
