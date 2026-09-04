Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D053525A8C
	for <linux-can@vger.kernel.org>; Fri,  4 Sep 2026 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561370; cv=none; b=WH95pw/xG5KF1+Sfadse6ykJ3IvKGVb5uObUHdVhoprUqOUkkmvPBb395BXnAsMRddlxV/aLUjdEnaxcTvetTHG9mZ1/pCqbQ0L3Bt5so53vTWHWH+8HYj77ogAlp0ud2D619DaelYe633pEPM2TYWuwaz5svK2eIexSO4/aYy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561370; c=relaxed/simple;
	bh=/oXwqSl9Gxhd9ASYzU33CVNwSksmytljDqKt0iBuLvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTZORh9MPsEztDPlNF/NCBkXI8CTfIpmK8ePR4v8XbWRgjEk0vcGznjjx5Wox+nson8N8CxrzEDyahFUjFeiju9BMNwV1xWrPxhUpubhTC0IcHd1ifhJqgyLGQYm4p9bAD0Kma8cRACMhYz1mx2F/4QoG7CJi4K30ONymuup8vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ml6ZPbdi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ml6ZPbdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DF11F0155D
	for <linux-can@vger.kernel.org>; Fri,  4 Sep 2026 22:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788561368;
	bh=/oXwqSl9Gxhd9ASYzU33CVNwSksmytljDqKt0iBuLvI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ml6ZPbdicpCTCGRsa4fruA8q/UpjUgIWf/z1j3+dK9X3uiutTe0Gl0W9Lye+gyHVj
	 8YmhHW8o3E5cvDD7BLuj2wEtwXOUvyv04hlKcGfZAbXiQJ/LOeLdCD+tUA+VGQVvFB
	 gmbCoxnTcLMl2erVHI1WMv20AhSU7ZLcp+yLOFH6iat052BEu/i84vxzZhJIUu0oy9
	 P7+8EJnGgIc7YQx9NQOdfRTN6gX0Q1EY7UbO+HN5y37jJceCICC6QEbK1be07F1FzD
	 DjwZ9SGW8JDK0WHPnhvmq1CH55jWjHQ0iSSlLt318rSpCiSaTGyvgyAYR5YRruMwQZ
	 BIo2SADVEtdig==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b5e907853eso1596755e87.2
        for <linux-can@vger.kernel.org>; Fri, 04 Sep 2026 15:36:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByHwWA5shl0JznHQU6U3PLjhO3mNNVIv/aWeTUGCZp4a6IP2kZN+AfqxXJvhzaNClUQSak3uqymdec=@vger.kernel.org
X-Gm-Message-State: AFuF++lMeI/WU3KNX30WDq7YnFZ4AUEsthk7or1tzJW4JZlGUnnikyVl
	mMefSpkZc14OxDHUzJcZvYi6ggwOWfwaIVmi26b193U+9R7mDaqPaf/gsimjiyDlCBsxvr1xtDi
	52o+K0BGkks1QPHDdPyhajW7O7aMyLRA=
X-Received: by 2002:a05:6512:61b3:b0:5b4:583f:9f32 with SMTP id
 2adb3069b0e04-5b616f324a3mr1360069e87.20.1788561366767; Fri, 04 Sep 2026
 15:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904043724.2955444-1-s-vadapalli@ti.com> <20260904043724.2955444-18-s-vadapalli@ti.com>
In-Reply-To: <20260904043724.2955444-18-s-vadapalli@ti.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 5 Sep 2026 00:35:54 +0200
X-Gmail-Original-Message-ID: <CAD++jLkfg0tRxDc7B2-TJqRmqxFxUFkFPwHya-gvGZ1OeytoYA@mail.gmail.com>
X-Gm-Features: AcwNN1VqRxubfaJ8mQrA8mitm0PwyRWyXr5M0LUGIuqfl4J37AtzKVm3Hf5r70E
Message-ID: <CAD++jLkfg0tRxDc7B2-TJqRmqxFxUFkFPwHya-gvGZ1OeytoYA@mail.gmail.com>
Subject: Re: [PATCH net-next 17/33] net: dsa: mv88e6060: Remove comma after
 sentinel-entry in match-table
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

On Fri, Sep 4, 2026 at 6:38=E2=80=AFAM Siddharth Vadapalli <s-vadapalli@ti.=
com> wrote:

> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
