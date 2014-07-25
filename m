From: Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH v4 3/3] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Fri, 25 Jul 2014 09:57:19 +0200
Message-ID: <53D20DDF.6000301@denx.de>
References: <1406196706-4548-1-git-send-email-sbabic@denx.de> <1406196706-4548-4-git-send-email-sbabic@denx.de> <53D0ED0C.4080400@gmail.com> <53D11E25.6010704@denx.de> <53D122C7.4020504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:38629 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbaGYH5Z (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 03:57:25 -0400
In-Reply-To: <53D122C7.4020504@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Oliver Hartkopp <socketcan@hartkopp.net>

Hi Varka,


On 24/07/2014 17:14, Varka Bhadram wrote:

>>   In last case CONFIG_OF is not set
>> and a platform device sets the data.
> 
> In our case we can load the driver by DT or Non-DT way.
> 
> If the DT approach is not used means CONFIG_OF is not set. In this case
> the device ids wont be added in the kernel device ids. For this we have
> to define spi_device_ids and update .id_table in struct spi_driver.
> 

I think we are doing the same thing with only a slight difference in the
implementation. For mcp251x the driver data is fix with the chip type
and there is not values set by the board. This let define the
driver_data inside the driver.

In my case I let that the platform data can be set, when CONFIG_OF=n, by
the board as it was common in the past, because I have some values that
depend on the board (number of channels, checksum enabled,..).

> For DT approach(CONFIG_OF = y) we have to define of_device_ids
> and update .driver.of_match_table with this ids.

Agree - exacttly the same is done in this driver.

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
