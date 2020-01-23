From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 0/3] Add Support for MCAN in AM654x-idk
Date: Thu, 23 Jan 2020 17:16:10 +0530
Message-ID: <f6bf75f0-68ea-0b61-ed43-9ad894016cfd@ti.com>
References: <20200122080310.24653-1-faiz_abbas@ti.com>
 <e3025ab6-04b5-3eba-5e0d-70caabee26fb@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51394 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgAWLpG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 Jan 2020 06:45:06 -0500
In-Reply-To: <e3025ab6-04b5-3eba-5e0d-70caabee26fb@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org
Cc: catalin.marinas@arm.com, mark.rutland@arm.com, robh+dt@kernel.org, davem@davemloft.net, wg@grandegger.com, sriram.dash@samsung.com, dmurphy@ti.com, nm@ti.com, t-kristo@ti.com

Marc,

On 23/01/20 4:47 pm, Marc Kleine-Budde wrote:
> On 1/22/20 9:03 AM, Faiz Abbas wrote:
>> This series adds driver patches to support MCAN in TI's AM654x-idk.
>>
>> Faiz Abbas (3):
>>   dt-bindings: net: can: m_can: Add Documentation for stb-gpios
>>   can: m_can: m_can_platform: Add support for enabling transceiver
>>     through the STB line
>>   arm64: defconfig: Add Support for Bosch M_CAN controllers
>>
>>  Documentation/devicetree/bindings/net/can/m_can.txt |  2 ++
>>  arch/arm64/configs/defconfig                        |  3 +++
>>  drivers/net/can/m_can/m_can_platform.c              | 12 ++++++++++++
>>  3 files changed, 17 insertions(+)
> 
> What about adding support for xceiver-supply as done in several other
> drivers (ti_hecc.c, flexcan.c, mcp251x.c)? And using this for the stb line?

Looks like you had given this feedback a long time ago and I forgot
about it. Sorry about that :-)

https://lore.kernel.org/patchwork/patch/1006238/

But now that I think about it, its kinda weird that we are modelling
part of the transceiver as a separate child node
(Documentation/devicetree/bindings/net/can/can-transceiver.txt) and the
other parts as a regulator.

Anyone looking at the transceiver node would figure thats where the
enable gpio/regulator node needs to go instead of the parent node.
Shouldn't we have all transceiver properties under the same node?

Thanks,
Faiz
