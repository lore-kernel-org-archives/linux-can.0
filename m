Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565102;
	b=ju+BLbQL5LMQ6gLfE2Fh09p695jKVemYf9xB9XjXB9NxfUuE8FBgjcTHv6IiyoNX1jYO
	 nFhM7f1ufSwcB0jHJUZUXUfcxMtT4UX94gM6RSqWDYeSYJ+lrfBHreKhg7uVdCSOz/vH4
	 6UhROk5RL1EaCjhEGNov1R3Dw5K4hRMLYuiS5q2Ye0QGl7/vyj1s6vQPfe7k/ZBW0nggE
	 uPSy3ctqJbiHo9BRBPC8HV+9lelO0K+OXlgIoZ1g2Sp1LXh0wq7cWGaL/iCQPe5GyDMUi
	 61LKrCKdlyLK4hc4TFosb9qOOAH/CiLmhxB9zuWiZio357GVxkQCbZnZOCeunKZXNCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565102;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yleDYOfzas42je6HDiXB4Rvaax9Ur7n/pahawoV6SHQ=;
	b=TMg7caz+OCXLkgugqf4U0F7t3zEvUqQfDv4r//rmI9HKJs6yw0i8pWwo3GhdFyQQ//zo
	 k7ug34wYq0nEkpu33MeuyY07xAKQj3pzjy+vEI4ENIxXugcPu1fCq5mbqMeXFVQj2dE5x
	 0U9lVq9tr8AHG/83j+gHRoPmGJhXzxW9TRlMbqCWF/LUmnuZgKbXyclU6lR6zhkUcwV7+
	 umXhXDalwX5efJ0KhmJDcry56uIB2lDNV4ccWS68uxmDU5kZEdvcpYgK4f0rgUPsr8VRB
	 DcC18zNtOE24fpQ1FaUKUlWLbLAqcS06snuHIo6HxeKPT67fAndLvUjFplP1zjTq9YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUBeTgiJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87635606A886
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUBeTgiJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B721F000C4;
	Fri, 13 Nov 2026 10:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794565102;
	bh=yleDYOfzas42je6HDiXB4Rvaax9Ur7n/pahawoV6SHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mUBeTgiJKmQlII2ey/bdsv91mtzh28mqKOuT6B1BQ6SgzypD2WKxyPN95dJe9sZFM
	 EpUQ3+REBVEolvrfbPgkYaEaMzyWemCabqrkru7gkhKS8VCblHbPkj01p8M7kd+PCW
	 up5jGWVD1rK+pVAd7RBBboj9d62XObBHCqJTy2MUtY6aur2Cn55r3lU0tft3L8k83A
	 4n3Vsxf+EteSSWzfQEVf38nu43DPc3VRE16B3GqnKLVprkCy0H90GTQeOnXgnrx1c7
	 ef0vssS5DA8EIfDsmd3ou0rHfzQpV+Zq1mji81yfg3QCQ4htdOqORJGCAqm9GVWSbA
	 Tssfbmw2II47w==
Message-ID: <sashiko-outbox-212616@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next v6 2/6] can: gs_usb: gs_can_start_xmit(): don't
 leak uninitialized memory over USB
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261113-gs_usb-fixes-v6-2-0c039e1bfd74@pengutronix.de>
References: <20261113-gs_usb-fixes-v6-0-0c039e1bfd74@pengutronix.de>
 <20261113-gs_usb-fixes-v6-2-0c039e1bfd74@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 10:18:21 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] can: gs_usb: inaccurate Fixes: trailer in commit message
--

commit ad35ba4588d5d85da58395d08e3738d74f314193
Author: Marc Kleine-Budde <mkl@pengutronix.de>

> can: gs_usb: gs_can_start_xmit(): don't leak uninitialized memory over USB
>
> The driver allocates the transmission buffer using kmalloc(), which means
> the memory remains uninitialized. Then various headers are filled and, but
> only the actual CAN frame data payload (of length cfd->len or cf->len) is
> copied into the buffer, leaving the remaining buffer uninitialized.
>
> Fix this information leak, allocate the buffer with kzalloc().
>
> Closes: https://sashiko.dev/#/bug/linux-0a8c0e8a-c623-426a-8db3-f55111f6c=
d84
> Fixes: 26949ac935e3 ("can: gs_usb: add CAN-FD support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

[Severity: Low]
Should the Fixes: tag point to d08e973a77d1 ("can: gs_usb: Added support
for the GS_USB CAN devices") instead of 26949ac935e3 ("can: gs_usb: add
CAN-FD support")?

Leaking uninitialized trailing bytes over USB when cf->len < 8 has been
present since d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN
devices"), which allocated hf via usb_alloc_coherent() without __GFP_ZERO
and copied only cf->can_dlc bytes into the 8-byte hf->data array.  The
kmalloc() call modified here was later introduced in 62f102c0d156 ("can:
gs_usb: remove dma allocations").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-gs_usb-fix=
es-v6-0-0c039e1bfd74@pengutronix.de?part=3D2
