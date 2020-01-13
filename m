From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 01/17] dt-bindings: at_xdmac: remove wildcard
Date: Mon, 13 Jan 2020 17:22:57 -0600
Message-ID: <20200113232257.GA30124@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-2-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42793 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728914AbgAMXXA (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2020 18:23:00 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so10718456otd.9
        for <linux-can@vger.kernel.org>; Mon, 13 Jan 2020 15:23:00 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k13sm4018827oig.24.2020.01.13.15.22.58
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:22:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1578673089-3484-2-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, vkoul@kernel.org, eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org, lee.jones@linaro.org, radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com, tudor.ambarus@microchip.com, miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, linux-media@vger.kernel.org, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, linux-can@vger.kernel.org, linux-rtc@vger.kernel.org

On Fri, 10 Jan 2020 18:17:53 +0200, Claudiu Beznea wrote:
> Remove wildcard and use the available compatible.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/dma/atmel-xdma.txt | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
