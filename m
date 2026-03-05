Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9E239A07A
	for <linux-can@vger.kernel.org>; Thu,  5 Mar 2026 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772712938; cv=none; b=Rcq/avCQj9DED7Kz1bSYsaV4UEXzz3bDJZbeFx3qHo+lvndyixaX0cop3P84PfPzvLq5G5U0lmZoNmYTaURrBOv62GXGLDcTdobYen1oH347pNnbetaVAlwvtB6Ygq4N9/Qa+1HGn7SyEWod0JrOc6cne9CSTJQ9AQ8prWvnCcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772712938; c=relaxed/simple;
	bh=1N9rpptCfEGuKF24I3MO+ctQKVCjB9J9sj4YNN7+SI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOKoCycoWmwu9YZq2ign1pcsRz/mCExFU+WDKI15aL/2N6NTwrmfMYktHuI6KoTGt9+RX6nieTGmzrkSKZmu/vwmas70yT95WKu0AOm9ro0Dyi5sJuNiYPHJdhgAwlW3S/Ajc2uWq6O0IRGxSpFd2nalAhwPjRj/SEzKzjDiFVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35982fd8910so2115873a91.1
        for <linux-can@vger.kernel.org>; Thu, 05 Mar 2026 04:15:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772712934; x=1773317734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yS764krKV6WfB8kOxjvP29bXooB1nm1bNBDNiujlO4g=;
        b=EgOfeN5UtbAGs7x0WRGYztO6EFXh4krsT8qU5JNZS2J9NNELECi/4cZlx1XbTTguVl
         kh2uIs9HWFMl6MNDKir4444mQm2QePVIcZan5n2E+jYhkf3eAKKCGeVmQv+KoImiiv8F
         q7FmIKdaGmcHfXyeaISrZ008wLplKDOdNLJsBH7YmrbS/s3m4Pgvpp1QR3FEVu3WfVdW
         5oTVqvRMC7HsjNoFT47T8Koa7HHCQd4p0/4kXCX9sFjlwfbptZnFYAKeaOCarBktMzcl
         PwuzwyHmSw0fGMeuVfINm4PNyDBbu1/0Fc8p0jmPL48LpWaFeb6hD6aUjwpujt5O2Frp
         yj6g==
X-Forwarded-Encrypted: i=1; AJvYcCUPSt3xVPOuH9cpWpiTmrpzAuJAKWz36CWvvMIv3ZfYeUHXKbDxGdUB/VZG1rkBlAH2Y2hX3+7Lbcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxd3bO2Zd4mm7qWO5QIoQ4uqhF6bUH6F0p4HMPZ2p5RUsqRuFO
	OyE9c+GdABUqUC5P8PoR6OoimnAIb3kyGQiYirD7PyliBgVppzdfddfd
X-Gm-Gg: ATEYQzzQbLr6e0CEh/W54iFBrpDBDw2R4ZAQHTC8ziRjyL7VyLMj6S5P2rk2aVnC/KK
	C/gJ7WUqOsvcVZxOU9Z5jBZQZfaFHck+TtOQCO2mcj+y6O/bnuNV0o4ldYbLTQLCV0QHgm05fpw
	fJVyHMRT65tTS4D35b4HhFw5aSkOC0JQACnyMwM5gYLP4lgod+Wn6jRvzNFB8k02dwxdYZVO740
	h/rP59aItMBL4kZyQTYSEBoghvoFhIFK5TpczxzZIdSXROz2jIce6lOPVV3Hzm+3k0JIXIQVLid
	iWpVMBPqFsIUA40fjpHE/nEQslunOVQq4kkF+2hxjjVsaN8RYuFEdp6I6FkzegPKIl0o7RmzABG
	RSE213QI1T2eOD/C7zkvpOvBnFOq9WKNGFlHGdmswGzC3iH82oWZ+0VVJmtloS4xjAnSxBWIih+
	6JMLpU+l4f9OtnBQjnYuK0Uu+P/s0T2oMoWOkA+NuDUIlBeyBmyeahqlBYabKv6N/bm4FP/CgVK
	NLgCa/QzHyPnz0zhq/L2wIVxzRYGgryO8UNijUj0Zu8ngiZZ7E3ueMz1ig71w==
X-Received: by 2002:a17:90a:d44b:b0:34e:630c:616c with SMTP id 98e67ed59e1d1-359a6a92750mr4210979a91.31.1772712934483;
        Thu, 05 Mar 2026 04:15:34 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2c1daa6sm2391359a91.0.2026.03.05.04.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:15:33 -0800 (PST)
Date: Thu, 5 Mar 2026 21:15:32 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Joe Perches <joe@perches.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, spacemit@lists.linux.dev,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH phy-next 22/22] MAINTAINERS: add regex for linux-phy
Message-ID: <20260305121532.GA1649635@rocinante>
References: <20260304175735.2660419-1-vladimir.oltean@nxp.com>
 <20260304175735.2660419-23-vladimir.oltean@nxp.com>
 <a8fee1cd-1e69-4a9e-8533-c0988c480fb9@oss.qualcomm.com>
 <20260305085148.7cwo3yflp7vcfldf@skbuf>
 <f3a5aa3df78553ffc0fd0024f5fd36a4e2158c88.camel@perches.com>
 <20260305114352.2f7btqixg4tu5bzl@skbuf>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305114352.2f7btqixg4tu5bzl@skbuf>

Hello,

> K:	\b(?:__)?(?:devm_)?(?:of_)?phy_(?:create|destroy|provider_(?:un)?register)\b
> K:	\bphy_(?:create|remove)_lookup\b
> K:	\bphy_(?:get|set)?_drvdata\b
> K:	\b(?:devm_)?(?:of_)?phy_(?:optional_)?(?:get|put)(?:_by_index)?\b
> K:	\bphy_pm_runtime_(?:get|put)(?:_sync)?\b
> K:	\bphy_(?:init|exit|power_(?:on|off))\b
> K:	\bphy_|(?:get|set)_(?:mode(?:_ext)?|media|speed|bus_width|max_link_rate)\b
> K:	\bphy_(?:reset|configure|validate|calibrate)\b
> K:	\bphy_notify_(?:connect|disconnect|state)\b
> K:	(?:struct\s+)?phy(?:_ops|_attrs|_lookup|_provider)?\b
> K:	(?:linux/phy/phy\.h|phy-props\.h|phy-provider\.h)

What about

  F:	drivers/*/*phy*

or something along these lines.

	Krzysztof
