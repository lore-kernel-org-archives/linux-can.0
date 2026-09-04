Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37954FB9B9
	for <linux-can@vger.kernel.org>; Fri,  4 Sep 2026 22:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561270; cv=none; b=sCCeLRksJOsuOf1wk/jcA0liP8M8OgUgTg3uE95CaULW2E5g/G9H++Pxi/pUcfjCMf+7VlgqORfQlCVP/x5tZzqVA2XK24RK01SYi9IHmsg7Hqh83loqYk6zVQOTFamjPSIlFYPQGb3anpTYw4I1moN6LBZSQ/DPofgJqpaFNL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561270; c=relaxed/simple;
	bh=dft8jIKZLyvDmq/LPRhVyMm6r8WW3Y1LCnA91drhmyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GaqHJecf7WsgI+KgRdWZjBpusjDCddZPRo+W7JickO9EQRzpXuJOKWID9kRYoaK7DXUQtj0nx11j9c0fh9Z4cQYbb8rioczRTZvkgjmbNJAIQjsqD/83h5p7V5zMDp9L+toZZq6/K7pSraw3DVNFiWZafxCWYD0hOTvdmNq6Kms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYoDekoI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYoDekoI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F441F01570
	for <linux-can@vger.kernel.org>; Fri,  4 Sep 2026 22:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788561267;
	bh=dft8jIKZLyvDmq/LPRhVyMm6r8WW3Y1LCnA91drhmyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JYoDekoIWqbyA2d6AFs9pkfIIIPviX99b4PNrXAxgbCQQF1dL9694ILlfzsOF9bjh
	 EDHjfFBj2rg1kN5BUPZ7sWwgCJdF1O2LBadFOYioLe3NL6Z0UxgN8bQZIPykzb0kIV
	 CeP2V94/YysKm8y7qehaNBmQINcQeTkVH3rYQZFzRNSJADYXZ6FaZoxF7+yGFHc7bL
	 j29jH+Fm2j64ewfDLmTZ/aVDHVwg5weAwMpu4nTwJimPoca4wLEQjEhcIXxlIJ7Aso
	 N2p5m9b0qKictMOibmx7IdV2ehpyhNL4kLPEvcWp4PUPxcQfEqdR6Xu/62SYhhmq8h
	 QX8pZpIOeK8Tw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b45f2e5f58so1375884e87.0
        for <linux-can@vger.kernel.org>; Fri, 04 Sep 2026 15:34:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwcDB0HzBIaidSzozwOtxNClmrx/GjEOmRE95V6WP3f4nG2vpoMAJadDkFvhWlvA3jjJEDKqDliPMY=@vger.kernel.org
X-Gm-Message-State: AFuF++kAQznoLgrDieaJf+JlV1qzh6EbOJ/+tlP5qg2/K5qw7Zl7QHrM
	4cNWakkcPgd9p93/FPk/pPou/EIhv3zjnQhnGlf2pMgp9u2kTBjlBIZeC1B8asK38hc1vIeAP9v
	m6XV4op0YM4XUCXBfw4F2wSXX6X7Kiu0=
X-Received: by 2002:a05:6512:1313:b0:5b0:22a6:6b13 with SMTP id
 2adb3069b0e04-5b616e717cfmr1606890e87.0.1788561266181; Fri, 04 Sep 2026
 15:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904043724.2955444-1-s-vadapalli@ti.com> <20260904043724.2955444-21-s-vadapalli@ti.com>
In-Reply-To: <20260904043724.2955444-21-s-vadapalli@ti.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 5 Sep 2026 00:34:13 +0200
X-Gmail-Original-Message-ID: <CAD++jL=V6eLEywiyKKFCQMZikQ79ULaq1uPYAQxu-rtYuSW7CA@mail.gmail.com>
X-Gm-Features: AcwNN1X2dJF1quKIRJ19ZE4zvP-mImnANUJmKgqRVeK17MZA2wOCllak4fdVdf4
Message-ID: <CAD++jL=V6eLEywiyKKFCQMZikQ79ULaq1uPYAQxu-rtYuSW7CA@mail.gmail.com>
Subject: Re: [PATCH net-next 20/33] net: dsa: realtek: rtl8365mb: Remove comma
 after sentinel-entry in match-table
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: dario.binacchi@amarulasolutions.com, mkl@pengutronix.de, 
	mailhol@kernel.org, msp@baylibre.com, florian.fainelli@broadcom.com, 
	jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	kurt@linutronix.de, hauke@hauke-m.de, chester.a.unal@arinc9.com, 
	daniel@makrotopia.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, ansuelsmth@gmail.com, 
	luizluca@gmail.com, alvin.sipraga@analog.com, clement.leger@bootlin.com, 
	justin.chen@broadcom.com, dlan@kernel.org, rogerq@kernel.org, 
	hkallweit1@gmail.com, linux@armlinux.org.uk, rjui@broadcom.com, 
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	opendmb@gmail.com, andrei.botila@oss.nxp.com, wangruikang@iscas.ac.cn, 
	amadeus@jmu.edu.cn, kees@kernel.org, tmshlvck@gmail.com, c-vankar@ti.com, 
	horms@kernel.org, vadim.fedorenko@linux.dev, daniel.zahka@gmail.com, 
	nora.schiffer@ew.tq-group.com, v-singh1@ti.com, oss@vassilevski.com, 
	haokexin@gmail.com, alex@sverdlin.org, aleksandr.loktionov@intel.com, 
	lgs201920130244@gmail.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 6:39=E2=80=AFAM Siddharth Vadapalli <s-vadapalli@ti.=
com> wrote:

> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
