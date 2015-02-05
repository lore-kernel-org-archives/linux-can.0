From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: new M_CAN IP rev 3.2.x documentation available - was: Re: M_CAN message
 RAM initialization AppNote
Date: Thu, 05 Feb 2015 20:04:55 +0100
Message-ID: <54D3BED7.1050503@hartkopp.net>
References: <1415193393-30023-1-git-send-email-b29396@freescale.com> <1415193393-30023-3-git-send-email-b29396@freescale.com> <545A3451.2090302@pengutronix.de> <545A692E.40002@hartkopp.net> <20141106015716.GB7642@shlinux1.ap.freescale.net> <545B1D71.4000408@hartkopp.net> <20141106080940.GA22964@shlinux1.ap.freescale.net> <545B6AB4.70003@hartkopp.net> <545B6DD8.6010906@pengutronix.de> <545BA039.7080108@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:54989 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbbBETFB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Feb 2015 14:05:01 -0500
In-Reply-To: <545BA039.7080108@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dong Aisheng <b29396@freescale.com>, linux-can@vger.kernel.org

Hi all,

the new M_CAN IP rev 3.2.x documentation is available:

http://www.bosch-semiconductors.de/en/ubk_semiconductors/ip_modules_3/produkttabelle_ip_modules/m_can_1/m_can.html

http://www.bosch-semiconductors.de/media/pdf_1/ipmodules_1/m_can_m_ttcan/mcan_users_manual_v320.pdf

One of the changes is the fact that the new Tx Buffer Element (see page 49) has a FDF and BRS bit.
So the switching between CAN and CAN FD is done per message without fiddling the configuration registers each time.

Best regards,
Oliver


On 06.11.2014 17:22, Oliver Hartkopp wrote:
> Hello all, (reduced the CC list a bit)
> 
> thankfully Mr. Hartwich from Bosch followed the mail threads I forwarded to
> him. It turns out that there's only ONE message RAM containing TX Buffers, RX
> Buffers and all the acceptance filter elements.
> 
> Due to our discussion the next M_CAN user manual will contain the attached
> application note (see marked lines in attached PDF).
> 
> Mr Hartwich wrote:
> 
> ---8<--- snip!
> 
> The RAM initialization issue is not limited to Tx Buffers, all RAM words need
> an initialization before they are read. If e.g. the CPU reads an uninitialized
> Rx Buffer before the M_CAN has stored a message into the buffer, that may
> trigger a RAM access error.
> 
> There is only one single Message RAM attached to the M_CAN,  which buffers
> are found where is configured via the registers SIDFC.FLSSA, XIDFC.FLESA,
> RXF0C.F0SA, RXF1C.F1SA, TXBC.TBSA, TXEFC.EFSA. The size of the area needed
> e.g. for the Tx Buffers depends on the number of Buffers and on the size of
> the buffers. Larger buffers are needed for the longer FD frames.
> 
> The M_CAN does not check whether the RAM areas overlap, so this check needs to
> be done in software. It is also possible that several M_CANs share one single
> RAM, so the overlap-check needs to consider also that case.
> 
> RAMs usually do not have a hardware-reset, so the RAM-cells, including the
> parity/ECC-bits (if exist) may be at invalid values. Any write to a RAM word
> will set the parity/ECC-bits to valid values. Therefore the entire RAM should
> be initialized by software after power-on, e.g. (simplistic):
> 
> for (i=RAM_start; i<=RAM_end; i++) RAM[i] = 0x00000000;
> 
> The size of the RAM may differ in different M_CAN implementations, the
> RAM is not part of the M_CAN IP module. There may be RAMs with parity,
> with ECC, or without protection. There may even be RAMs with hardware-reset.
> 
> ---8<--- snip!
> 
> So the recommendation is to initialize the entire message RAM (see PDF).
> 
> Regards,
> Oliver
> 
