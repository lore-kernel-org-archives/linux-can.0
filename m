From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v1 2/3] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Fri, 21 Mar 2014 22:42:16 +0100
Message-ID: <532CB238.9000909@hartkopp.net>
References: <1395404758-21977-1-git-send-email-sbabic@denx.de> <1395404758-21977-3-git-send-email-sbabic@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:58224 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbaCUVmW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 21 Mar 2014 17:42:22 -0400
In-Reply-To: <1395404758-21977-3-git-send-email-sbabic@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

Hello Stephano,

I definitely like this driver as it implements a full featured CAN netdev over
SPI with all the SocketCAN specific configuration stuff :-)

First some general comments:

There's a mixup of the driver name:

spican
spi_can
#define DRV_NAME		"imxhcscan"

>  drivers/net/can/Kconfig             |   11 +
>  drivers/net/can/Makefile            |    1 +
>  drivers/net/can/spi_can.c           | 1533 +++++++++++++++++++++++++++++++++++
>  include/linux/can/platform/spican.h |   36 +

I would first suggest to create a new directory

linux/drivers/net/can/spi

and move the mcp251x there (including the Kconfig stuff which is only entered
when SPI is enabled similar to the CAN USB adapter configs).

As the driver and it's communication concept is not very specific for the
hcs12 or imx35 (or should no be very specific) I would tend to name it

	spi_can

and rename the 'hcs12' or 'imx' named functions to something more generic,
e.g. spi_slave, spi_can or something better.

Maybe when there is really imx35 or hcs12 specific stuff to handle, this
should be made clear, e.g. with a imx_spi_can driver which uses the spi_can
driver?!?

And then there has to be a Kconfig option which depends on IMX35/ARM.


> +#ifndef __CAN_PLATFORM_SPICAN_H__
> +#define __CAN_PLATFORM_SPICAN_H__
> +
> +#include <linux/spi/spi.h>
> +
> +/*
> + * struct hcs12_imx_platform_data - i.MX to HCS12 CAN controller platform data
> + */
> +
> +struct hcs12_imx_platform_data {
> +	unsigned int can_channels;
> +	unsigned int gpio;
> +	unsigned int active;
> +	unsigned int slow_freq;
> +};
> +
> +#endif
> 

Is this really i.MX or HCS12 specific??

Regards,
Oliver
