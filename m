Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A087E227EA4;
	Mon, 21 Sep 2026 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996169; cv=none; b=EENmNr2oGft6NJ5ieHdrIdZe8Lh+MxlxDBM+XCmbihQbnpBAJ2ibP2EJgi2iQ7NlHowy6GJjksakvAW6YypvlKEHUwwvtSYUXqH0Rj49qMLa2KRNo6rsoiEOx0VBC0EmDaXkXn4EpXsCZDxe3Ln9oneXWeK9+v1OBv38mHtCY0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996169; c=relaxed/simple;
	bh=Eo+VrB6JJOwbs8IsxgYASPnp1ZE7MEEhUtA6BWTn5Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASBAwTf0Q0yaH3SbY3XniBP47BeKLG0al3QXsZCRBIBfakH0Uu2UMWgOT6cnYWp97DsetbDyOfGiBBmKIaXqA+j18iXVBp/z1cFHCepS9mTySsmO+dvNXyuyAzgUF1h2VBp1LyLlKpabIkrsd3pPxwKObB1mKiBAhqR1yzy7a8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=cQUZTT8q; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="cQUZTT8q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1789996165; x=1790600965; i=wahrenst@gmx.net;
	bh=Eo+VrB6JJOwbs8IsxgYASPnp1ZE7MEEhUtA6BWTn5Xk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cQUZTT8qVsRkuhDWGj8sobHpdfBPpDdkKF5PI01kcFS93c3n5bwXxGMpqJDx9onm
	 SNIHTAKA1Mdy80IZV4t3pusLf0xGTJRDzrzUVOsc/r9UvbZFwVeBXMsXKGDSl06z0
	 FS/dRX4OG7ZcqDt3npJzJ6qfcCjfRSblkdze9yLEAkjUUoCtvlcUs+sI/Kt16PWHp
	 2FEoFHIFQTQ0K+J48Nym6+6OpRFaxT4gufFq+/dwmjug3PBmua5mPD4sEPLRz96UW
	 LwHqjIaNW/27DQ+0G3Yr1kvi+Uc8uWAPQjogvTJYd5nAE8T6QXiRhK3nWUHa4FdCB
	 uGGfxc1NOmXKD+9Gjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5GE1-1wjEfY1YYf-016pyi; Mon, 21
 Sep 2026 15:09:25 +0200
Message-ID: <9cb548d3-f3cf-4757-a9ff-5f878479c7d7@gmx.net>
Date: Mon, 21 Sep 2026 15:09:23 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 0/4] arm64: dts: freescale: Add chargebyte Charge
 Control Y
To: Frank Li <Frank.Li@nxp.com>
Cc: Christoph Stoidner <c.stoidner@phytec.de>, Vinod Koul <vkoul@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Fabio Estevam
 <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>, devicetree@vger.kernel.org,
 linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Vincent Mailhol <mailhol@kernel.org>,
 Aswath Govindraju <a-govindraju@ti.com>
References: <20260907150420.18787-1-wahrenst@gmx.net>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20260907150420.18787-1-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dTkV2oD5YpD92t0EBpOUdk3SgFF0jb3vhQ1NQAolFNEcEJ8+VhK
 5+vGQ0Mllj2A/Ry0j03P/CET45XfCdP565A801Nq4zLUwcrhE68OhrQJnheYR5UV17d0DYN
 hZmXQv7FH1A7ZxDo8UIk6IIH5n+NgZJkinmJJEHY6OOwbmDkltRRS2C2NuB7pq9Gbq88p8v
 hovzxizSKDZnZRnHbl47A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NIjBCQGh9cU=;eTisrmx80CVgm0Ugyb+PN7+ZfwT
 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

Hi Frank,

Am 07.09.26 um 17:04 schrieb Stefan Wahren:
> This series adds support for the chargebyte Charge Control Y, which is
> an Electrical Vehicle Supply Equipment (EVSE) for MCS (Megawatt
> Charging System) charging stations.
>
> sashiko reported in the first version of the series [1] that X_nRST_LAN
> is available via GPIO line names, but there is no reset mechanismn in th=
e
> device tree. This finding is valid. Since the reset line feature isn't
> implemented for LAN8651 driver yet, I like to proceed with the current
> version. The LAN8651 handles reset via SPI commands and in rare cases
> we still have the possibility to control the reset from userspace.
> Btw the pin has a pull resistor in hardware, so it's not floating.
>
> sashiko complained in the fourth version of the series [2] about the
> reset polarity of ethphy2 and the different drive strength across the
> data lines. Both is intended.
>
> [1] - https://lore.kernel.org/linux-devicetree/20260818093147.E556C1F000=
E9@smtp.kernel.org/
> [2] - https://lore.kernel.org/linux-devicetree/20260903082122.A777C1F000=
E9@smtp.kernel.org/
>
> Changes in V5:
> - fix delete-node for pinctrl_leds (reported by sashiko)
> - add Krzysztof's Reviewed-by
I didn't received any feedback for V5 yet. Do you have any comments or=20
could it be merged?

Best regards
