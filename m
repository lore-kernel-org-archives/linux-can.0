From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: sja1000 private defines - was: Re: pull-request: can 2013-03-27
Date: Tue, 02 Apr 2013 08:01:56 +0200
Message-ID: <515A7454.9050905@hartkopp.net>
References: <1364393128-19701-1-git-send-email-mkl@pengutronix.de> <20130327.141045.999210087722896364.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:17751 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081Ab3DBGB7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Apr 2013 02:01:59 -0400
In-Reply-To: <20130327.141045.999210087722896364.davem@davemloft.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: linux-can@vger.kernel.org

On 27.03.2013 19:10, David Miller wrote:

> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Date: Wed, 27 Mar 2013 15:05:26 +0100
> 
>> Hello David,
>>
>> here's a patch series for net for the v3.9 release cycle. Fengguang Wu found
>> two problems with the sja1000 drivers:
>>
>> A macro in the SH architecture collides with one in the sja1000 driver. I
>> created a minimal patch suited for stable, only changing this particular
>> define. (Once net is merged back to net-next, I'll post a patch to uniformly
>> use a SJA1000_ prefix for the sja100 private defines.) 


Hello Marc,

i would suggest to replace REG_ with SJA_ for SJA1000 private defines.

1. There's only one "SJA_EN" private(!) define in
 
	linux/drivers/infiniband/hw/qib/qib_iba7322.c

   which we'll never clash with. There SJA_ is a short form of SPC_JTAG_ and
   (even if it's not necessary) SJA_EN could be renamed to SJTAG_EN

2. Replacing REG_ with SJA1000_REG_ will produce a linebreak hell in all
   SJA1000 drivers (and the patch of course)

Naming SJA1000 private defines with SJA_ instead of REG_ (and rename your new
SJA1000_REG_SR back to SJA_SR) looks the more handy change to me.

Regards,
Oliver

~/linux$ find . -name \*.[ch] | grep -v can | xargs grep SJA
./include/generated/autoconf.h:#define CONFIG_CAN_SJA1000_MODULE 1
./include/generated/autoconf.h:#define CONFIG_CAN_SJA1000_ISA_MODULE 1
./include/generated/autoconf.h:#define CONFIG_CAN_SJA1000_PLATFORM_MODULE 1
./drivers/infiniband/hw/qib/qib_iba7322.c:#define SJA_EN SYM_MASK(SPC_JTAG_ACCESS_REG, SPC_JTAG_ACCESS_EN)
./drivers/infiniband/hw/qib/qib_iba7322.c:	val = SJA_EN;
./drivers/infiniband/hw/qib/qib_iba7322.c:	valbase = SJA_EN | (bisten << BISTEN_LSB) |
./drivers/infiniband/hw/qib/qib_iba7322.c:	val =  SJA_EN | (bisten << BISTEN_LSB);
./drivers/infiniband/hw/qib/qib_iba7322.c:	val = SJA_EN | (bisten << BISTEN_LSB) | (R_OP_UPDATE << R_OPCODE_LSB);
./drivers/net/ethernet/icplus/ipg.h:#define	IPG_ETHERSTATSJABBERS				0x130
./drivers/net/ethernet/broadcom/bnx2.h:#define BNX2_EMAC_RX_STAT_ETHERSTATSJABBERS		0x00001538
./arch/arm/mach-pxa/include/mach/pcm027.h:/* CAN controller SJA1000 (unsupported yet) */


>>
>> Fengguang further noticed that the peak pcmcia driver will not compile on archs
>> without ioport support. I created a patch to limit the driver to archs which
>> select HAS_IOPORT in Kconfig.
> 
> Pulled, thanks Marc.
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


