From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v3] ARM: dts: at91: sama5d2: add m_can nodes
Date: Mon, 15 May 2017 11:43:36 +0200
Message-ID: <20170515094336.h6rllnei3cneb4j2@piout.net>
References: <20170424011217.2530-1-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:44674 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760304AbdEOJns (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 May 2017 05:43:48 -0400
Content-Disposition: inline
In-Reply-To: <20170424011217.2530-1-wenyou.yang@atmel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Nicolas.Ferre@Microchip.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, devicetree@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>, Wenyou Yang <wenyou.yang@microchip.com>, linux-arm-kernel@lists.infradead.org

On 24/04/2017 at 09:12:17 +0800, Wenyou Yang wrote:
> Add nodes to support the Controller Area Network(M_CAN) on SAMA5D2.
> The version of M_CAN IP core is 3.1.0 (CREL = 0x31040730).
> 
> As said in SAMA5D2 datasheet, the CAN clock is recommended to use
> frequencies of 20, 40 or 80 MHz. To achieve these frequencies,
> PMC GCLK3 must select the UPLLCK(480 MHz) as source clock and
> divide by 24, 12, or 6. So, the "assigned-clock-rates" property
> has three options: 20000000, 40000000, and 80000000.
> The "assigned-clock-parents" property should be referred to utmi
> fixedly.
> 
> The MSBs [bits 31:16] of the CAN Message RAM for CAN0 and CAN1 are
> default configured in 0x00200000. To avoid conflict with SRAM map
> for PM, change them to 0x00210000 in the AT91Bootstrap via setting
> the CAN Memories Address-based Register(SFR_CAN) of SFR.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> Tested-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
> The patch is tested on SAMA5D2 Xplained and based on the patch set,
>  1. [PATCH v4 1/7] can: m_can: Disabled Interrupt Line 1
>     http://marc.info/?l=linux-can&m=149165343604033&w=2
> 
> Changes in v3:
>  - Add Tested-by tag.
>  - Change the number of Rx Rx Buffers, Tx Buffers and Tx Event FIFO
>    to maximum.
> 
> Changes in v2:
>  - Configures 10 TX Event FIFO elements and 10 TX Buffers/FIFO slots,
>    because the TXE FIFO is needed to be configured.
>  - Configure the offset of Message RAM for CAN1 followed from CAN0's.
> 
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 24 +++++++++++++
>  arch/arm/boot/dts/sama5d2.dtsi              | 56 +++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
> 

It didn't apply cleanly, can you please verify
https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/log/?h=at91-dt

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
