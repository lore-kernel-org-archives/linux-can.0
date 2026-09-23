Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D5747DF98;
	Wed, 23 Sep 2026 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167506; cv=none; b=HJrv0l/NhL9bQ3tVkJQOhQ+IdfA17KDl/afjuJb8qiR1bj2uFyML8nQSYZxKPuXtDd3o5PJ1RKoiYRoxpMVhmAmMbAj7J4avnsryXGmfIn6UsXzIlyd3GBok50QkRXl41QbTzRhDaC1spR2QQU/WSAQd+PYw9istXSVEJk2+tfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167506; c=relaxed/simple;
	bh=aThP8n0xq9nJ5Vnw6J5+utPA6u3NeinHh4G8qnpJL8A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oi0vp2BkAeLsEvaPnIciVys40Atu1IkdkCBt/YLcvSXKg4S7N+Jf1jabbPSR2YOGvGG399I5ky5jxxml5QDJVoCqPtS1o3kikVMTTTnS0iNz36Pk24ZnFD6bOKx0Hwrw7iIdCAk08xaNH3bZsGc9yFSWHuTR1TYYmTzTqTgmiOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWvVoI8h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWvVoI8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CFF1F00898;
	Wed, 23 Sep 2026 12:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790167505;
	bh=iZdbguPgsJ3dIsjeAE1gh4r/OS8eReNScxmzTOcJkw0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZWvVoI8hZ3VQ7pXstaTmhaeuG1NaVmlCIac6mZadqV8O0+rfux++2YxN5Lk562IJE
	 sl8Tpy750tF0AMfTcGXFpmuKAqYXncBQLNmesl97xPmVJixDqDasCqLUaR1YfL7/c1
	 +BBzMIQnCaGd2wONT2Lb878P2lppFKrRMQekkdjiDyIr7wxHapZw15SMIXA+caXHmd
	 EOOJXnWLDOpNI2ZHkKbAWZTZrRUTO3YdcMdpt9SKffSTO0JFJ5FRrlMAK/P1m6Z/VW
	 mMhF3Yk+lireckw24FTO7kUZHauR4xqidCJvphQhc+3rGsjG1gEQ+AIYNa/hLkOs8o
	 +tgk2otcLM0LA==
From: Vinod Koul <vkoul@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Aswath Govindraju <a-govindraju@ti.com>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: Christoph Stoidner <c.stoidner@phytec.de>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-can@vger.kernel.org, 
 linux-phy@lists.infradead.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260907150420.18787-1-wahrenst@gmx.net>
References: <20260907150420.18787-1-wahrenst@gmx.net>
Subject: Re: (subset) [PATCH V5 0/4] arm64: dts: freescale: Add chargebyte
 Charge Control Y
Message-Id: <179016749941.155868.1810345055482953110.b4-ty@kernel.org>
Date: Wed, 23 Sep 2026 18:14:59 +0530
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 07 Sep 2026 17:04:16 +0200, Stefan Wahren wrote:
> This series adds support for the chargebyte Charge Control Y, which is
> an Electrical Vehicle Supply Equipment (EVSE) for MCS (Megawatt
> Charging System) charging stations.
> 
> sashiko reported in the first version of the series [1] that X_nRST_LAN
> is available via GPIO line names, but there is no reset mechanismn in the
> device tree. This finding is valid. Since the reset line feature isn't
> implemented for LAN8651 driver yet, I like to proceed with the current
> version. The LAN8651 handles reset via SPI commands and in rare cases
> we still have the possibility to control the reset from userspace.
> Btw the pin has a pull resistor in hardware, so it's not floating.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: phy: ti,tcan104x-can: Fix property constrains
      commit: c7f2322431cb6d108b18fb4154606b49e2bc50f7

Best regards,
-- 
~Vinod


