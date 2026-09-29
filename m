Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438643939A3
	for <linux-can@vger.kernel.org>; Tue, 29 Sep 2026 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693643; cv=none; b=hRFa3npBzXmPiuoP+h1yxyHo5csay+gIfVqoVSps3idQxQe4u20I+VSQSh++7TUxmca0oPjW2sxSkt9h2ble8jzehWrII0JVeYiFLf3f2zaOc4eVnca/QJKOAPQ4jnt4qvCNz5oxrCNpM8u5i8zatbV2o0hKUT9ewM+P3TFdQhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693643; c=relaxed/simple;
	bh=B9xA/pj3YaZKtW1thnnZKXjyT9PBu2s+4w4l+Hb7qjs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CXHQHDBYM9/haO0dvJygSDJZYVTvjRe3z2WgsSbapJuHY0q2FPmdwXZNL7uYm9SKjpoLC8JNuTs65ySoKdM/RbGGT93hjQCGQOzXvEoxdXIUn8cBi6XlgXfto40zx1UwmsIxVA/cp02YgPTR13EsXM5MINV+FvvtT2FWuTFa+kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGeFzrQa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGeFzrQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD0C1F000FF;
	Tue, 29 Sep 2026 14:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790693641;
	bh=PJmk76doL8iiXQQBIjtPC/4Rx271lqvbQUiNeLVgvXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aGeFzrQa9kof3HEZDThF0s6m54fm62jirUPg7NjtWPTodWSSN5N9BCuSN5cSuYPrV
	 Kh9JLJQs+XrC7GBqTAJoc2gDfiIRwpTdpgvamgAHIzosA1lNYwSgnjuAU0UfyYHwW7
	 kTrzkqcgdPyIHMlr4ZvwtINFSS5GJC99Xmx+PSM1w04lC4VSSCZt6Rmp5RyDQW9+N3
	 SEFye5liDQ846grxJHNoPa11ftD6ytiXsx2iTDwVEZATklM92LqHQt2Gmx1Bw25wOA
	 2O5VMnCbqaT5+Y78Hnbn/E/+d+iavxKv/2HGK/fCGHHEuvVdkePsbcCm8KjRaHpYpo
	 RN7tFPjQz6LtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] can: peak_usb: Add bus error reporting for the
 PCAN-USB FD family
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <stephane.grosjean@free.fr>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260929-peak_usb-canfd-berr-v2-1-1a7005797c38@peak-system.fr>
References: <20260929-peak_usb-canfd-berr-v2-1-1a7005797c38@peak-system.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 14:54:00 +0000
Message-Id: <20260929145401.6FD0C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: peak_usb: returning -EINVAL for bogus error reports drops val=
id URB packets
--

commit 6ff05518907e7981e5fff27d40e8a2458d563751
Author: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>

can: peak_usb: Add bus error reporting for the PCAN-USB FD family

CAN bus error reporting is currently missing for all PEAK-System
USB-to-CAN FD devices. Add support for reporting bus errors by enabling
bus error notifications in the firmware for each CAN channel.

Link to v1: https://patch.msgid.link/20260929-peak_usb-canfd-berr-v1-1-7abd=
585f877f@peak-system.fr

> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can=
/usb/peak_usb/pcan_usb_fd.c
> index 0d46f4ce5dca7..98f6943469b33 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -661,17 +661,71 @@ static int pcan_usb_fd_decode_error(struct pcan_usb=
_fd_if *usb_if,
>  	struct pucan_error_msg *er =3D (struct pucan_error_msg *)rx_msg;
>  	struct pcan_usb_fd_device *pdev;
>  	struct peak_usb_device *dev;
> +	struct can_frame *cf;
> +	struct sk_buff *skb;
> +	u8 can_err_tx =3D 0;
> =20
>  	if (pucan_ermsg_get_channel(er) >=3D ARRAY_SIZE(usb_if->dev))
>  		return -EINVAL;
> =20
> +	/* Guard against bogus channel 1 reports from single-channel adapters */
>  	dev =3D usb_if->dev[pucan_ermsg_get_channel(er)];
> +	if (!dev)
> +		return -EINVAL;

[Severity: High]
Does returning -EINVAL here cause valid URB packets to be dropped?

The caller pcan_usb_fd_decode_buf() handles a negative return value by
aborting the URB decoding entirely and jumping to the fail label:

	case PUCAN_MSG_ERROR:
		err =3D pcan_usb_fd_decode_error(usb_if, rx_msg);
		if (err < 0)
			goto fail;
		break;

Because USB bulk transfers pack multiple CAN records together, aborting
the loop discards any subsequent valid CAN frames in the same URB.
This appears to lead to silent data loss under normal operation.

Should this return 0 instead of -EINVAL to safely ignore the hardware quirk
without dropping the rest of the buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-peak_usb-c=
anfd-berr-v2-1-1a7005797c38@peak-system.fr?part=3D1
