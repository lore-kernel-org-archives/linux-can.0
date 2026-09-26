Received: from mail.enpas.org (lighthouse.enpas.org [46.38.232.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19664349B2;
	Sat, 26 Sep 2026 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.232.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790434883; cv=none; b=HpoQCLckfo1R17HK+LHRngA5yLIafKvjJmnqHDJJSKvbjInLiaoq0LGm1HWqxPsDxqM/LtBqZ/20L9k+IlJIJz1f/O3/SeNg9WFYPMeWUDcU8gwO3mg9o8Io/MqFqXm+96S2eWcxBMbjgP5v294mUbQ3af1LiF0yVWNzMl8ERz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790434883; c=relaxed/simple;
	bh=2cfQhex3AF52tIuFyhNqUECYkXA1L/HLDSLfFHWSkRM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FZdMZzE/YepfIlMB4PUM2S3kb9oMzToRO1GEzkBtmklAXRh4nuqv3DdPCBbFlnAYk49Gbu/rqqxI5Os4vVvfG837fcH1zt3hzmluWCZQjGiaH4pjzcHvyfkBz62HxAVrY5H/8mgVZGIj93oXqwj0PguqepB2g01LFeDbTketKfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.232.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 61B2F104F78;
	Sat, 26 Sep 2026 14:54:04 +0000 (UTC)
Message-ID: <93a9dbca-4f3b-4b01-8e07-1dbc7035a96d@enpas.org>
Date: Sat, 26 Sep 2026 23:53:56 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Max Staudt <max@enpas.org>
Subject: Re: [PATCH v6 1/3] can: at91_can: release the rx-offload on teardown
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
 <mailhol@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Heiko Stuebner <heiko@sntech.de>, Manivannan Sadhasivam <mani@kernel.org>,
 Thomas Kopp <thomas.kopp@microchip.com>, Ming Yu <tmyu0@nuvoton.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, NXP S32 Linux Team <s32@nxp.com>,
 imx@lists.linux.dev, Haibo Chen <haibo.chen@nxp.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20260925144558.2909639-1-ciprianmarian.costea@oss.nxp.com>
 <20260925144558.2909639-2-ciprianmarian.costea@oss.nxp.com>
Content-Language: en-US
In-Reply-To: <20260925144558.2909639-2-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This is not my driver, but the patch looks reasonable to me. While we 
wait for someone else's proper review, let's call it


Acked-by: Max Staudt <max@enpas.org>


Thank you!

