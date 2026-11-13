Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794555487;
	b=SeYbUiNo2eX5KGzPhkV5YGo82WNxXMnxpningRknhBZWMBKRHtIsaR4Qypb9KxomPjMP
	 5E9/ESadz9CeIpPkxRrH38aZkWzOktzzeeLzR/1RH/wbe3ywzB2fHuKpLAXsMfVA/PXHw
	 qc0BLQdk9NP0qrrT9yLmyugBsHixcHNCJmuc5cPwwyBbzGlg3z1luIP4eWn6XZZXhXmur
	 6uc20prQ69gfNJKnFFl0u500nXBU4LQ3tQ7hOf6u1lQnDd0LkoNSCUhYMRnZnuRB1fGT0
	 HOkpoFkT9mjgFsKIjmQMDdTbSBosXyi5cQ7lbsRdI8iVmS0OIpLZNrObDbcMkO+JsKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794555487;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Eaar+oq/r1uPWCFcWkEM6b1AibX761RNcXzU7Mx1d+Y=;
	b=48F9azoIdorQbkAWRU534K7/MjNf9zHut9vQlsxoQNpjuikHdcR43lXhqTPw7igGiIBc
	 cM8KOtKNQhczkyaSsm80TVGoSliyEW4kdzDiQ/HjiynR642TX24M2FgKQIrM/5KTYXiTB
	 ApXf8oYTu+ait1rQq0D2mHAE7Ks8IqGfd7idrA8zbFTzinZgoQyE6i7nd3q8DFTDWt5dE
	 /q9F/MCiU6skU2urjfUZdukAGsXAnx4FuiAZlAlLloJo86pN5tCktxgKArUCcidaXe1Kf
	 xki4KlxzSjjirXcQeW2JU+UJggAdyEZY+A7qZXhLsRPzFnS/dONjjiKk/nA4QExomsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C70wBuNu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1BD606A327
	for <linux-can@vger.kernel.org>; Fri, 13 Nov 2026 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C70wBuNu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1A91F000C5;
	Fri, 13 Nov 2026 07:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794555486;
	bh=Eaar+oq/r1uPWCFcWkEM6b1AibX761RNcXzU7Mx1d+Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C70wBuNus14dGTdfgbIwC0wUKr7gxfkmi8jytM8FawOHU+1pzy5Eq8/BhodBrzIT1
	 FE7npwQrGdwJ1w5sBP9V6VJBogPo/6ETtAEFqmgeKqWumldqzGqvBf6+yUwQ3glx/S
	 /F8RwlRzjW2x5zVloZMSbUHkgPUw71m8L5ifQD9bioSiorOfPDlfJ9siNqwP6pnU3Z
	 vQK2X5sSVRexTgJ7t1tsdwp2eNEZ5ow6iBMw842EiGadJDaOlMY3nbYPgyDVWh7r1U
	 ydnMR9zlY6dmZt++PEUIoJjYGYl9O03YZn9UJlcPZ4wzeimwHICKwf386RU0Hheday
	 es7kUcJkFC/ow==
Message-ID: <sashiko-outbox-212357@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 3/7] dt-bindings: net: can: holt,hi311x:
 Convert to DT schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261113071325.4092169-4-mkl@pengutronix.de>
References: <20261113071325.4092169-1-mkl@pengutronix.de>
 <20261113071325.4092169-4-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 07:38:06 +0000
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
- [High] dt-bindings: net: can: single-word handle Quchaosheng in
  Signed-off-by
--

commit 10f7c3c38441fe802ef963f0ba282453f08176ed
Author: Quchaosheng <quchaosheng000406@163.com>

> dt-bindings: net: can: holt,hi311x: Convert to DT schema
>
> Convert the Holt HI-311X binding from free-form text to DT schema.
>
> Reference can-controller.yaml and spi/spi-peripheral-props.yaml. The
> HI-3110 sits on an SPI bus, so its node carries the standard SPI
> properties, spi-max-frequency among them. With unevaluatedProperties:
> false and no reference to spi-peripheral-props.yaml, dtbs_check rejects
> those properties:
>
>   can@1 (holt,hi3110): Unevaluated properties are not allowed
>     ('spi-max-frequency' was unexpected)
>
> Keep the properties and the example as the original text describes them,
> including clocks as a required property.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260922084542.104788-1-quchaosheng0=
00406@163.com?part=3D2
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
> Link: https://patch.msgid.link/20260922102258.138753-3-quchaosheng000406@=
163.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

[Severity: High]
The Author header and Signed-off-by trailer use the single-word handle
"Quchaosheng" rather than a full name as required by the Developer's
Certificate of Origin in Documentation/process/submitting-patches.rst.
Should both use "Chaosheng Qu <quchaosheng000406@163.com>", matching
commit "dt-bindings: net: can: bosch,cc770: Convert to DT schema" in
this series?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113071325.4092=
169-1-mkl@pengutronix.de?part=3D3
