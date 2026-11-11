Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399624;
	b=sEj4/CvkUb2IzSMnamNSJlzcmmk1DoKc6whPNPrySFgFZ4/D/edbGgoPmXNWCAHs9QKo
	 7kER7Req86/Sp7JTTe/8peA3l+td/ZkNgx1JB7JUqaIeb2peEtQgh1qeWdGZkFbfXH1wz
	 r/UqdO4pyxqXaLNAoI9CwY0f2nI8IBY04PQTF3XEPPcnKD0O06MqAqp5E+YmBRhGemJjB
	 qZjRuA/1NuM5mVEX0TBMS/xbEd3z/2BwEh0dKkT0Llz4xWpwfLIoqGzcrfXU3XW7BGgbE
	 qcTm/neraFe91LuMDhU6C/+j6BvXx+NZBcvASmKs7NYzzogTLTLcMNB2jTaLIMxBJhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399624;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xxLJxT99qiiIchQLk8LqFwMgHss1uWEGKjwgI62Zhec=;
	b=hGXAF+mU0s4nX88uDAQZhOcaE7XwC/CfrfB2XpeChxDoRCiAI6hOg+5KVvGcZLGXtBKQ
	 FDa9qkRVwWVEseLBWyKNbfz+6YAK7O2jCvmqKR1o9sfkzQynuPZ9fxtTMBfsBN5UfmPAJ
	 7xf3R+sYBqPzYVNgUyIifiWBUssPsJQ4hjjC3CW/NQToYvP4aTyx7hY3v+ju6XFJzRlXr
	 KAg2m6xLZfXFQq6pfgoSlrmTlK0YuGtjajLzg69wNLvYQqRy34Aq4xJrKzsuW91HdUlKd
	 0fcL2cJai7fP5zNBoDlqql+Gru1fLMQC2K731L1WZV9dR0naPWJORVWvE8mo1ucJOPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tsl+BdzM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B14606A8AD;
	Wed, 11 Nov 2026 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tsl+BdzM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4891F00A08;
	Wed, 11 Nov 2026 12:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794399624;
	bh=xxLJxT99qiiIchQLk8LqFwMgHss1uWEGKjwgI62Zhec=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Tsl+BdzMzunj99yv8eKSBkfm69dnKZHIqwqNhSlBeRCzQAe9ujf7pXgrthBkOzj8o
	 B96jlTkDRuRMORNjb6oANbjDzt0JJPdVmrstfecM0ABFM42CGCqqASmjpE8eZSO4R1
	 CdLAMDTW0GCW5sQKe0/Uk6reJfISBKOXQ386BJQJ4nM1ldaL4YC9NwfiM2dJhuLYdq
	 qkXBUEWo1D7sV4c1PccJuQIG3T7XIaRTzOq4iDpKtG0rJjdy4OnhI6nx6qF2jBh5ww
	 QOv5yYmeATguzv+xLSp0DXkoSyMGC50uELY3Je/0Z+q/w76Ga3QkjXsbNr6Jq9Ffhx
	 guf9DDE80SbFw==
Subject: Re: [PATCH net-next 10/12] can: rcar_canfd: Document that RZ/G3S has
 no Classical CAN mode
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 claudiu.beznea.uj@bp.renesas.com, geert+renesas@glider.be
Date: Wed, 11 Nov 2026 12:20:23 +0000
Message-ID: <179439962315.2199510.11528694161549398887@kernel.org>
In-Reply-To: <20261110115112.3807247-11-mkl@pengutronix.de>
References: <20261110115112.3807247-11-mkl@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch fixes only half of the header comment in
  drivers/net/can/rcar/rcar_canfd.c.

--

can: rcar_canfd: Document that RZ/G3S has no Classical CAN mode

This patch changes the header comments in the R-Car CAN FD driver to say
that RZ/G3S does not support Classical CAN (CAN 2.0) only mode. It
matches the corresponding dt-bindings update. There is no functional
change.

Link: https://patch.msgid.link/20261021-canfd_rzg3l-v6-2-b4abfdba8e70@bp.renesas.com

> diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
> index 4f5cdfa8211da..072987316cc75 100644
> --- a/drivers/net/can/rcar/rcar_canfd.c
> +++ b/drivers/net/can/rcar/rcar_canfd.c
> @@ -6,7 +6,7 @@
>  
>  /* The R-Car CAN FD controller can operate in either one of the below two modes
>   *  - CAN FD only mode
> - *  - Classical CAN (CAN 2.0) only mode
> + *  - Classical CAN (CAN 2.0) only mode (Except RZ/G3S)
>   *
>   * This driver puts the controller in CAN FD only mode by default. In this
>   * mode, the controller acts as a CAN FD node that can also interoperate with

[Severity: Low]
This isn't a bug, but should the paragraph just below this one in the same
header comment get the RZ/G3S exception too? The patch leaves it as is:

drivers/net/can/rcar/rcar_canfd.c:
 * To switch the controller to Classical CAN (CAN 2.0) only mode, add
 * "renesas,no-can-fd" optional property to the device tree node. A h/w reset is
 * also required to switch modes.

The renesas,rcar-canfd.yaml binding does not allow this property on RZ/G3S.
The allOf branch for renesas,r9a08g045-canfd has:

    then:
      properties:
        renesas,no-can-fd: false
        renesas,fd-only: false

So the comment now says Classical CAN mode is not available on RZ/G3S, but
the next paragraph still tells readers to add renesas,no-can-fd, without
naming any SoC that cannot use it.

Later in the series, "can: rcar_canfd: Add support for Renesas RZ/G3L"
changes only the line above to "(Except RZ/G3{L,S})" and leaves this
paragraph as it is.

Could the instruction paragraph also say that renesas,no-can-fd must not
be used on RZ/G3S?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110115112.3807247-2-mkl%40pengutronix.de
