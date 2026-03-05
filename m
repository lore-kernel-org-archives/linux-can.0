Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10423242B1
	for <linux-can@vger.kernel.org>; Thu,  5 Mar 2026 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696882; cv=none; b=eM5ynfbs2UkKRv/usTJ65ntqwbDcBsO2UWWyvEco1v6TXU94Pd2iULF/P4vACSV4D/FFQYxpF+RpphnMilftjs+aliakBFNOVrExSvo96d3YubD/oGn0dryveUCOsbS4lankxz3YdbkTmw6KvnpulAoJMWA75YczMGQrmZcbMXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696882; c=relaxed/simple;
	bh=urVD1xPdaF3hV5GqXqVqTidMinFWi7P2lc2J0G3o7gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKOqp+lltY1vGsrUexwOfcaOhZpZ7wXeD/gvtSdJTFD+Gg3u47wUjdY/edc5ae50BOaD7Y9lRJ9BuqChuMQYWRaAPN1nxZ7fIIBCwQEInP4ejosgl6/VJ8III7mB0gGOf67wDl+2cuD+fRtiCWNhNDswHt2yusY+TkYi85qmels=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56af4aad3e5so140113e0c.3
        for <linux-can@vger.kernel.org>; Wed, 04 Mar 2026 23:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772696880; x=1773301680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xyHjzGnphi32H4Bte19x6wQV76UaiJqzbc3zMkJKs8=;
        b=MtWdmqSM3spbFrLL2vYscu/iLoM7KxLrEu6aU1YJCkO4XLSH4YIBuw3Kc+YnhljFiS
         EGAMhrkItCvuHce5hA5s2ae9V+0KaxJ3usx5EbXM0Vk0XupqQi9Jiz85aykdFHuFAxXO
         0noxQ0/XBEo4VeJSbDjiXFeQqDYJb3WOU/5IOJP+Pk2MIAb4p9w/Uhz8lTIFmR4OOT3t
         fmtEb/07b77fGxL2d8BfyhzYDDU31eegtrRQaBzoO/xBjc8Xb8lVXg6rytowDHrDKHHF
         vLIiMWiqsNtrj4MmhW74iXgX1HM2VJR5I8yviyLqf8GH2PnAMOI/kiM2MS/cJGHa7UcT
         XX8A==
X-Forwarded-Encrypted: i=1; AJvYcCW3lD5TDXINLFNaSmjfV18Xh4Usa0Pl5pq1WlmuLzcXM2sWY3DjI0ZO9fY/kfeGB6eHe9hCV2aA3fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFTWgTwSAPcYGtfNK4m7QK5B8TXVaf5cn+dRddjMkauGam6X1J
	XnvE+kf+KoFvjLWZeO0ubNoYcLIlnTMIKYWCrzEvJ4JnoEe2Al44jQrKipZHBtf1
X-Gm-Gg: ATEYQzw3v7hEKBqqRIXQE7aWM1XdKVxf00E0wxftxHr6zelYVaCSR32Bc5yzaFeyhe5
	ebJrBgQXzGPFLyyzSH2bzwgXseVsD4GQuH5GCppqkrl9JX1rj7Xj1j3LMbN8jMBnlc/h9cxWbOV
	MqDhbU4bBwg9wA3l520Q5WPXhavyhP178ltjHSB+1Pyy+fHy1Jv8D7B6Z/uWiwjxmeIkCFum9/l
	eY654OwrC1FNmcUywgEu6UNIOUZ6CF5/28uG8SWmLINSMn+D1aUPYCloJIDi8zuYb0Pu9pttrNI
	DVEg7mp95y1zkzWZ1CS+D+kzNb+MSHyC1BX93QgSUyyxBuhvHulVZJ6o5CK9TzaDaqNg+GtlckZ
	aH0YnrUHwheVqqUWGyJyeqerZhpG8FmZoLFBFzEX+pTCoCDoaMTEHCw4tHT1+GmMUPWsg+SyrM9
	l2l/MMAxaysVfx/ydUoGnb8gKsP2ICAfpOKtar/hyYBgfOzbng5bG2LeGdB3wl
X-Received: by 2002:a05:6122:35cd:b0:56a:f015:82ac with SMTP id 71dfb90a1353d-56af0158d54mr1223688e0c.7.1772696880091;
        Wed, 04 Mar 2026 23:48:00 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a91659421sm27674781e0c.0.2026.03.04.23.47.58
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 23:47:58 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5ff1703cb9eso2132711137.3
        for <linux-can@vger.kernel.org>; Wed, 04 Mar 2026 23:47:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwORkCrFm56+4UeKXzZ+HbEvTo5Tv6NQ6McyMQAAwJnRuKxCpYvlC/6Qr/nR6Z7FwRKJqIc5h0Tf8=@vger.kernel.org
X-Received: by 2002:a05:6102:32c1:b0:5ff:a16b:93f9 with SMTP id
 ada2fe7eead31-5ffaae2d5b0mr1883200137.21.1772696877960; Wed, 04 Mar 2026
 23:47:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com> <20260304175735.2660419-14-vladimir.oltean@nxp.com>
In-Reply-To: <20260304175735.2660419-14-vladimir.oltean@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Mar 2026 08:47:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNtqsui3ek1RYCTyiuDLRajpSBMnrdzED6wu6i7-QcuA@mail.gmail.com>
X-Gm-Features: AaiRm514iMGAdfTBAVsgfVfK-GGHy9jHY4ezK-Lp3w09-JWpnENLQ0I4lkIFgvE
Message-ID: <CAMuHMdUNtqsui3ek1RYCTyiuDLRajpSBMnrdzED6wu6i7-QcuA@mail.gmail.com>
Subject: Re: [PATCH phy-next 13/22] phy: introduce phy_get_max_link_rate()
 helper for consumers
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, spacemit@lists.linux.dev, 
	UNGLinuxDriver@microchip.com, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andy Yan <andy.yan@rock-chips.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Vladimir,

On Wed, 4 Mar 2026 at 19:00, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> Consumer drivers shouldn't dereference struct phy, not even to get to
> its attributes.
>
> We have phy_get_bus_width() as a precedent for getting the bus_width
> attribute, so let's add phy_get_max_link_rate() and use it in DRM and
> CAN drivers.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thanks for your patch!

>  drivers/net/can/rcar/rcar_canfd.c                   | 2 +-

For the Renesas part:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -640,6 +640,12 @@ void phy_set_bus_width(struct phy *phy, int bus_width)
>  }
>  EXPORT_SYMBOL_GPL(phy_set_bus_width);
>
> +u32 phy_get_max_link_rate(struct phy *phy)
> +{
> +       return phy->attrs.max_link_rate;
> +}
> +EXPORT_SYMBOL_GPL(phy_get_max_link_rate);

Any specific reason you are not making this a simple static inline
function, like phy_get_bus_width()?

> +
>  /**
>   * _of_phy_get() - lookup and obtain a reference to a phy by phandle
>   * @np: device_node for which to get the phy

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
