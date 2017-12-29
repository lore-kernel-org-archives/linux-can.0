From: "Yang, Wenyou" <Wenyou.Yang@Microchip.com>
Subject: Re: [PATCH v6 0/6] Add M_CAN Support for Dra76 platform
Date: Fri, 29 Dec 2017 11:38:10 +0800
Message-ID: <667c651b-cb9b-4e71-437f-2cd3be39f491@Microchip.com>
References: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:15189 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753732AbdL2DiR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 28 Dec 2017 22:38:17 -0500
In-Reply-To: <1513949488-13026-1-git-send-email-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Faiz Abbas <faiz_abbas@ti.com>, wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, sergei.shtylyov@cogentembedded.com



On 2017/12/22 21:31, Faiz Abbas wrote:
> This patch series adds support for M_CAN on the TI Dra76
> platform. Device tree patches will be sent separately.
> A bunch of patches were sent before by
> Franklin Cooper <fcooper@ti.com>. I have clubbed the
> series together and rebased to the latest kernel.
Tested this series on SAMA5D2 Xplained board.

Tested-by: Wenyou Yang <wenyou.yang@microchip.com>

>
> v6 changes:
> Dropped the patches to make hclk optional. Drivers
> which enable hclk as the interface clock using
> pm_runtime calls must still provide a hclk in the
> clocks property.
>
> Support higher speed CAN-FD bitrate:
> The community decided that data sampling point be used
> for the secondary sampling point here
> https://patchwork.kernel.org/patch/9909845/
>
> Franklin S Cooper Jr (6):
>    can: dev: Add support for limiting configured bitrate
>    can: m_can: Add call to of_can_transceiver
>    can: m_can: Add PM Runtime
>    can: m_can: Support higher speed CAN-FD bitrates
>    dt-bindings: can: m_can: Document new can transceiver binding
>    dt-bindings: can: can-transceiver: Document new binding
>
>   .../bindings/net/can/can-transceiver.txt           | 24 +++++++
>   .../devicetree/bindings/net/can/m_can.txt          |  9 +++
>   drivers/net/can/dev.c                              | 39 +++++++++++
>   drivers/net/can/m_can/m_can.c                      | 81 ++++++++++++++++++++--
>   include/linux/can/dev.h                            |  8 +++
>   5 files changed, 156 insertions(+), 5 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.txt
>

Best Regards,
Wenyou Yang
