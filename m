From: Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH v5 0/2] Adding support for CAN busses via SPI interface
Date: Tue, 21 Oct 2014 14:25:13 +0200
Message-ID: <544650A9.5030707@denx.de>
References: <1406565510-10783-1-git-send-email-sbabic@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:53747 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191AbaJUMZT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Oct 2014 08:25:19 -0400
In-Reply-To: <1406565510-10783-1-git-send-email-sbabic@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefano Babic <sbabic@denx.de>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>

Hi Marc,

On 28/07/2014 18:38, Stefano Babic wrote:
> Hi all,
> 
> after some time, I post an updated version of the spi_can driver.
> Sorry for that, but I had to wait for the requested modifications
> on the microcontroller's firmware to test it again.
> 
> The majork change is the GET_CFG message to query the remote
> CAN microcontroller for the CAN bittiming. I hope also I have fixed
> all issues from previous reviews.
> 
> 
> Changes in v5:
> - drop Patch 2/3, already applied.
> - sort include headers
> - match open parenthesis (globally fixed)
> - add newline to dev_err() in insert_cfg_msg()
> - use sizeof(*p)
> - drop unused variable val in ISR
> - proper return code instead of -1
> - move device ids after probe/remove
> - drop #ifdef CONFIG_OF (not needed anymore)
> - use devm_ API
> - use module_spi_driver()

The driver needs to be rebased on current tree, but before doing that I
want kindly ask you which is the best way to proceed. As far as I can
see in the previous threads, I have not found any open points for V5. Do
you think there are any issue that block this driver to flow into
mainline ? Or which is in your opinion the best way to do ? Maybe should
I post it for inclusion in drivers/staging ?

Thanks,
Stefano Babic


-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
