From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 4/6] can: ctucanfd: CTU CAN FD open-source IP core -
 PCI bus support.
Date: Mon, 3 Aug 2020 12:32:11 -0700
Message-ID: <e4378bd9-6484-88bc-48d3-d7fdda62c844@infradead.org>
References: <cover.1596408856.git.pisa@cmp.felk.cvut.cz>
 <bad059402032f82fa63aa51d2122589a8a2cf6fd.1596408856.git.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgHCTcv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 3 Aug 2020 15:32:51 -0400
In-Reply-To: <bad059402032f82fa63aa51d2122589a8a2cf6fd.1596408856.git.pisa@cmp.felk.cvut.cz>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: pisa@cmp.felk.cvut.cz, linux-can@vger.kernel.org, devicetree@vger.kernel.org, mkl@pengutronix.de, socketcan@hartkopp.net
Cc: wg@grandegger.com, davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com, c.emde@osadl.org, armbru@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, martin.jerabek01@gmail.com, ondrej.ille@gmail.com, jnovak@fel.cvut.cz, jara.beran@gmail.com, porazil@pikron.com

On 8/3/20 11:34 AM, pisa@cmp.felk.cvut.cz wrote:
> diff --git a/drivers/net/can/ctucanfd/Kconfig b/drivers/net/can/ctucanfd/Kconfig
> index 0620111d57fd..8a5f5d05fa72 100644
> --- a/drivers/net/can/ctucanfd/Kconfig
> +++ b/drivers/net/can/ctucanfd/Kconfig
> @@ -15,4 +15,13 @@ config CAN_CTUCANFD
>  
>  if CAN_CTUCANFD
>  
> +config CAN_CTUCANFD_PCI
> +    tristate "CTU CAN-FD IP core PCI/PCIe driver"
> +    depends on PCI
> +	help

"help" should be indented with one tab only (no spaces).

> +	  This driver adds PCI/PCIe support for CTU CAN-FD IP core.
> +	  The project providing FPGA design for Intel EP4CGX15 based DB4CGX15
> +	  PCIe board with PiKRON.com designed transceiver riser shield is available
> +	  at https://gitlab.fel.cvut.cz/canbus/pcie-ctu_can_fd .

help text should be indented with one tab + 2 spaces according to
Documentation/process/coding-style.rst.

> +
>  endif

thanks.
-- 
~Randy
