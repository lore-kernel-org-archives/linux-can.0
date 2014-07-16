From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [PATCH v5 2/2] can: m_can: add Bosch M_CAN controller support
Date: Wed, 16 Jul 2014 15:28:09 +0530
Message-ID: <53C64CB1.3050204@gmail.com>
References: <1405503050-16796-1-git-send-email-b29396@freescale.com> <1405503050-16796-2-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:60726 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbaGPJ7Z (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 16 Jul 2014 05:59:25 -0400
In-Reply-To: <1405503050-16796-2-git-send-email-b29396@freescale.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dong Aisheng <b29396@freescale.com>, linux-can@vger.kernel.org
Cc: wg@grandegger.com, socketcan@hartkopp.net, mkl@pengutronix.de, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com

On 07/16/2014 03:00 PM, Dong Aisheng wrote:
> The patch adds the basic CAN TX/RX function support for Bosch M_CAN controller.
> For TX, only one dedicated tx buffer is used for sending data.
> For RX, RXFIFO 0 is used for receiving data to avoid overflow.
> Rx FIFO 1 and Rx Buffers are not used currently, as well as Tx Event FIFO.
>
> Due to the message ram can be shared by multi m_can instances
> and the fifo element is configurable which is SoC dependant,
> the design is to parse the message ram related configuration data from device
> tree rather than hardcode define it in driver which can make the message
> ram sharing fully transparent to M_CAN controller driver,
> then we can gain better driver maintainability and future features upgrade.
>
> M_CAN also supports CANFD protocol features like data payload up to 64 bytes
> and bitrate switch at runtime, however, this patch still does not add the
> support for these features.
>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: Varka Bhadram <varkabhadram@gmail.com>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
> changes since v4:
> some minor changes:
> - introduce m_can_fifo_write and is_lec_err functin
> - define macro M_CAN_FIFO_XXX for FIFO
> - move m_can_of_table before platform_driver
> - a few indent fix
>
> Changes since v3:
> A few minor changes:
> - use the updated name of bosch,mram-cfg
> - remove .owner = THIS_MODULE
> - add a line comment for mram_cfg structure
>
> Changes since v2:
> - fix checkpatch warnings
> - handle CAN_CTRLMODE_BERR_REPORTING properly that disable LEC error
>    interrupts (Bus error) if no CAN_CTRLMODE_BERR_REPORTING.
> - introduce struct mram_cfg array to store message ram configuration data
>    for each fifo
> - fix txb offset calculate wrong issue(should not plus mram_off again)
> - check return for clk_prepare_enable
> - split doc part into a separate patch
>
> Changes since v1:
> Addressed all comments from Mark Rutland, Hartkopp and Marc Kleine-Budde
> - merge three patches into one
> - create directory drivers/net/can/m_can
> - improve binding doc
> - make sure using valid pointer before netif_receive_skb(skb)
> - remove debug info a bit
> - let the stats are updated even if alloc_can_err_skb() fails
> - other small fixes
> ---
>   drivers/net/can/Kconfig        |    2 +
>   drivers/net/can/Makefile       |    1 +
>   drivers/net/can/m_can/Kconfig  |    4 +
>   drivers/net/can/m_can/Makefile |    7 +
>   drivers/net/can/m_can/m_can.c  | 1202 ++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 1216 insertions(+), 0 deletions(-)
>   create mode 100644 drivers/net/can/m_can/Kconfig
>   create mode 100644 drivers/net/can/m_can/Makefile
>   create mode 100644 drivers/net/can/m_can/m_can.c
>
>
This series addressed all of my comments ...Thanks  :-)

Reviewed-by: Varka Bhadram <varkabhadram@gmail.com>

-- 
Regards,
Varka Bhadram.

