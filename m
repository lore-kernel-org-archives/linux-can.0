Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E95837F016
	for <linux-can@vger.kernel.org>; Thu,  5 Mar 2026 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704945; cv=none; b=H7bev2cJI0HA/zxKKxiDctgz58XzUcdTTKzkxtC1lVK3Q8JblajHeTD82jtwQ2OG9rw92+OEnJ2iQjBusVjmBZJmHLOWkNFl8ElClytzwJ1lA4uiPLUX8E/ApkffgnPbzFdT7AGaqXZBC75BLsZMk9kilvdnVimcB9SkjXPGprU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704945; c=relaxed/simple;
	bh=PLN3jU+WSp15lmHsKDg7F21c9tIpGoZokDbnzqxSsGE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TzDOwDHx74ha0314NuDz9xj/oK+XARPm8E7BiA4Bnf0sRP81jwjolghCU4V1imLasUgXpJNL8KfnJc/JrWUZghY4UaHRocqsmDjFF5yb6jAh+ND/JJ6ModUmUdS7by3PugNWCt5fOqMTu2CjjAhdILpMPCS7NKdMkQXd9LT7DG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cD4UFgoA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cD4UFgoA"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48371119eacso93559645e9.2
        for <linux-can@vger.kernel.org>; Thu, 05 Mar 2026 02:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772704940; x=1773309740; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PLN3jU+WSp15lmHsKDg7F21c9tIpGoZokDbnzqxSsGE=;
        b=cD4UFgoAocJuZT5S6/FT4tLvo8eHic6win/PVVlM7THi42GfYkSi1TmQKp9oFjEvC9
         4DuAmh8ioVJ3l0t9cfDz1F4uH57IMEgeY61EKqf0J4hgzotd10bzAWeqkIY3qxwq+gtt
         KyD/BEhAcZymLIC+jEV+iqZhfRlSpIO7G5fxOWyrn6ZeoxUBzXJNaGNiXGXdwAwygc++
         SJ3ShMbEL/2wC0WJ/VhDdOAftX90PfAz60BcupIG8OAGaPrCOCMIA27aaK++isLH44Iv
         ENO8y4ePFW102JPN00G4qmjO8l3H2KXaQyAiU4DD52kTRmizIQUzeyakkq8kcPe749lH
         0MxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772704940; x=1773309740;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLN3jU+WSp15lmHsKDg7F21c9tIpGoZokDbnzqxSsGE=;
        b=Fp1f6yeKnHVr2A/i4LzwUSynEUHKFimE7mKkHnneg37B2eslQK9vDUnmQZFe2v1KC3
         plsQPo6tM/ZXMWpy8H7c5gi/ceYZ18Fb9R+2Cxa+l8AHOEP2lYifrjS7lqEgkuX4aqXD
         e+mvs8PyO3q6Aj78uN0VY2uk5d3i475b7F0fF3o67MOa75Jg8VIhU19WkStbGCRci+w6
         voAJB8jcfJjNwftlgEirmQfDJR5PE5Xbd3UfmxCSPoD6C6nMb0FoAtzzruZu+o9MgBix
         Swphyhw0znqSpUHX79tU4eHnEHTCNmDvaEXwlU0q+VZETIo75kM6NCGl0gXLufj7/tzD
         AbLg==
X-Forwarded-Encrypted: i=1; AJvYcCW1n1Hdo/SKUDdkG3RUJG7gh3DF8TvIkKRQDfHOLONEF9234Hjc5HYv4O1hnkrDFgYbhttu0u4ZOck=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUp/VRilJIP/P3W8nFBROjoxvwCC7HXbJHofjbk0c7dJVml6t5
	cYMm5E/dtPeDHZVqeyH4Ji8kNhi3cAA2UHcsvYAi53MJ3B/+diR1X1l9teSNAgadkqM=
X-Gm-Gg: ATEYQzwycDgnDrdlEKwFY/zThCFkxU9tvgHjCE35EMHdldniPYBXwvu0YbmoKJ7GWFx
	jMlDEMs4VPT2e/CckPeLqkxO2eATEy2EnvBTUpNpRziuHWky5DbP9WAStkUtESMxifeiw8ZrlVA
	3NZLDpZ/ohwCk0HQIHKf6a4cgD1AkYXOvFdIEhyjbY1QwunqIe1bK665hi1PbBmmddeP4qeNTNJ
	23xR0IB97YMJuRGfzVaT+XBg1XLHY7I7n/MaTQNiWEx5wk8mAjh34MZyPw+QnfJmD+lRHqDYssv
	0P7kSs278UOEhuLDYor4YrBQ3jFIaZeO7R4MDPMPH9boIff9fSZGTIEa960IgeaBalyZR7DEdYx
	R5gAMEtnIcBO7frbWan+ML2+1cZ9QcUrd1ycVZonHwJhDKcZPPEv3vU6eO+UpXpbJtBbRFMjZyx
	CjDJW7WseLXv+NCygzseKRaJdHESw1
X-Received: by 2002:a05:600c:a07:b0:47f:b737:5ce0 with SMTP id 5b1f17b1804b1-4851988f31dmr86977045e9.23.1772704939633;
        Thu, 05 Mar 2026 02:02:19 -0800 (PST)
Received: from salami.lan ([212.129.84.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fade9fdsm59453655e9.4.2026.03.05.02.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 02:02:19 -0800 (PST)
Message-ID: <030737fd255a49288349f06e8c1217a126ea9081.camel@linaro.org>
Subject: Re: [PATCH phy-next 05/22] phy: add <linux/pm_runtime.h> where
 missing
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, 	dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, 	linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, 	linux-can@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, 	spacemit@lists.linux.dev,
 UNGLinuxDriver@microchip.com, Peter Griffin	 <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Heiko
 Stuebner <heiko@sntech.de>
Date: Thu, 05 Mar 2026 10:02:16 +0000
In-Reply-To: <20260304175735.2660419-6-vladimir.oltean@nxp.com>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
	 <20260304175735.2660419-6-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-04 at 19:57 +0200, Vladimir Oltean wrote:
> It appears that the phy-mapphone-mdm6600, phy-qcom-snps-femto-v2,
> phy-rcar-gen3-pcie, r8a779f0-ether-serdes and phy-rockchip-typec drivers
> call runtime PM operations without including the proper header.
>=20
> This was provided by <linux/phy/phy.h> but no function exported by this
> header directly needs it. So we need to drop it from there, and fix up
> drivers that used to depend on that.
>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

> =C2=A0drivers/phy/phy-google-usb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +

For Google:
Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
