Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EE452ED2D
	for <linux-can@vger.kernel.org>; Fri,  4 Sep 2026 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561404; cv=none; b=oaDPVdtg5YCcY6+Q+3zLISxRibXqEoM3fiE01UqN5BAOzI40dZmIWqUpcuHRCAl8wb7QL/RMRhhjOM7R8zX3OBo2YfNHHC5iQsRrHbriLEuDZT49DyDT325li4cR5UKgvnhHKaX/G2dG8VDENIYglXewnp+s3bpSPftORSUNolw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561404; c=relaxed/simple;
	bh=dft8jIKZLyvDmq/LPRhVyMm6r8WW3Y1LCnA91drhmyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qExVOdfUXyPoWYrYILs9GLXzirnGWEMZo4DnGphhqfd1eNp6UhJoOg06Us3NuDG5PAS5hxgCNnFjyvMXghUAN3g+dKZIzwutnxY5jY6J1uZ87v8PqWVTwfChNvEgmX2Pkf1hHN+YdinBGLHZh9k6WNbHNAAmdcHdQ1GIpQBiyb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qh0OQ7L0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qh0OQ7L0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54CA1F00ADF
	for <linux-can@vger.kernel.org>; Fri,  4 Sep 2026 22:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788561402;
	bh=dft8jIKZLyvDmq/LPRhVyMm6r8WW3Y1LCnA91drhmyY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Qh0OQ7L0D7X+117p1PpoMp1i31lJRFbYVHzLlgQ4q8VSEX3EzfUTlRAxt+8Y50ypa
	 smazqPkGF4OAGm6Y/1rlNxf036E8E+iKcc6MHDS+XKUEEpdtK92j4dW5riWf6ddzjH
	 kRW1+JWQ9oTyKRdu8qKPGNNTnQrIE9gNC4GqpvG6ZE2m2R5+TYYL142JjHLBOrO1tm
	 M/VrsIzJuP1CRiXquq2Bwkk0mUehJxblPhi5OdXWqMMx9irt6NKca04+5fOEkccVTN
	 hT5YXTqlleSDkWaQmsScB0gxtEpHBJT+8yLu3jvdO2W74lTMJlNBGCGu6reDQ0KoR9
	 BWWALoQQKspQw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b4a9994c20so1669266e87.0
        for <linux-can@vger.kernel.org>; Fri, 04 Sep 2026 15:36:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw4cznHvEIEiYtO1oH/TI5cRDdpHEY5ZAttPeDYx4kbL7VvkdF4qKdqeSda1veI6KoRk1NfHhFr23s=@vger.kernel.org
X-Gm-Message-State: AFuF++lVVH2Z0AoomBAjkghfUDBzfOJt7UDqN5dzAFwQPl6B16BTPefe
	ZiOVnTnWDdK16E9/VlxCuMp4FcvJDMwlNyhEB6B661WiMPAnCQImp+5f5mJYw9HqXr8ucIW1tPp
	s+WvyFl4XjqJ/WMzmVxo01F8KLUBXlcM=
X-Received: by 2002:a05:6512:250e:b0:5b1:5a2d:55f9 with SMTP id
 2adb3069b0e04-5b616f3215dmr1620442e87.21.1788561401588; Fri, 04 Sep 2026
 15:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904043724.2955444-1-s-vadapalli@ti.com> <20260904043724.2955444-22-s-vadapalli@ti.com>
In-Reply-To: <20260904043724.2955444-22-s-vadapalli@ti.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 5 Sep 2026 00:36:29 +0200
X-Gmail-Original-Message-ID: <CAD++jL=c7Hbfwbngr2HQ_RTUizL=hwQbTa=C-oZNu2BAjLh0yQ@mail.gmail.com>
X-Gm-Features: AcwNN1U9I_dDB3NJSseFrC3_GFY1Eb30_yQ91aHRnm5hTr_W3IoNAFdaYoLTgAE
Message-ID: <CAD++jL=c7Hbfwbngr2HQ_RTUizL=hwQbTa=C-oZNu2BAjLh0yQ@mail.gmail.com>
Subject: Re: [PATCH net-next 21/33] net: dsa: realtek: rtl8366rb: Remove comma
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
