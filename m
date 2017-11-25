From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 0/2] Microchip mcp2517fd can controller driver
Date: Sat, 25 Nov 2017 13:03:36 +0100
Message-ID: <3d355c51-09a3-40b8-46bf-8437e26a95f3@hartkopp.net>
References: <20171124183509.12810-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:16011 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdKYMEB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 25 Nov 2017 07:04:01 -0500
In-Reply-To: <20171124183509.12810-1-kernel@martin.sperl.org>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kernel@martin.sperl.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-can@vger.kernel.org, devicetree@vger.kernel.org

Hello Martin,

thanks for the contribution!

Unfortunately [PATCH 2/2] only hit the devicetree mailing list but not 
the linux-can mailing list for the review.

Btw. I already have two questions from the description:

On 11/24/2017 07:35 PM, kernel@martin.sperl.org wrote:

(..)

> The driver has been heavily optimized so that it can handle
> a 100% utilized 1MHz Can-bus (with 11 bit can frames with DLC=0)
> even on less powerfull SOCs like the raspberry pi 1 without
> dropping frames due to driver/spi latencies

(..)

 > The driver implements a lock-less design for transmissions
 > making use instead of prepared spi messages submitted via spi_async
 > for transmission in the start_xmit_start code without requireing
 > an extra workqueue and the corresponding latencies.

Seems you improved the SPI handling here. Would it make sense to 
separate the SPI-related part of the code to a separate C-file so that 
the existing mcp251x driver can benefit from these improvements too?

> (still dropps are observed in the can/network stack).

Are you sure drops are taking place in the network layer? Can you give 
me some more details about this statement?

Best regards,
Oliver
