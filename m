From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2 3/3] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Tue, 25 Mar 2014 19:54:43 +0100
Message-ID: <5331D0F3.4050207@hartkopp.net>
References: <1395757822-22283-1-git-send-email-sbabic@denx.de> <1395757822-22283-4-git-send-email-sbabic@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:61785 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754401AbaCYSyy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 25 Mar 2014 14:54:54 -0400
In-Reply-To: <1395757822-22283-4-git-send-email-sbabic@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stefano Babic <sbabic@denx.de>, linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>



On 25.03.2014 15:30, Stefano Babic wrote:
> This driver implements a simple protocol
> to transfer CAN messages to and from an external
> microcontroller via SPI interface.
> Multiple busses can be tranfered on the same SPI channel.
> 
> It was tested on a i.MX35 connected to a Freescale's
> HCS12 16-bit controller with 5 CAN busses.
> 
> Signed-off-by: Stefano Babic <sbabic@denx.de>
> 
> ---
> 
> Changes in v2:
> - drop all references to i.MX35 and HCS12

See include/linux/can/platform/spican.h

There are still some of them.

> 
>  drivers/net/can/spi/Kconfig         |   10 +
>  drivers/net/can/spi/Makefile        |    1 +
>  drivers/net/can/spi/spi_can.c       | 1534 +++++++++++++++++++++++++++++++++++
>  include/linux/can/platform/spican.h |   36 +
>  4 files changed, 1581 insertions(+)
>  create mode 100644 drivers/net/can/spi/spi_can.c
>  create mode 100644 include/linux/can/platform/spican.h

spi_can.h

> 
> diff --git a/drivers/net/can/spi/Kconfig b/drivers/net/can/spi/Kconfig
> index 148cae5..299d71ca 100644
> --- a/drivers/net/can/spi/Kconfig
> +++ b/drivers/net/can/spi/Kconfig
> @@ -7,4 +7,14 @@ config CAN_MCP251X
>  	---help---
>  	  Driver for the Microchip MCP251x SPI CAN controllers.
>  
> +config CAN_SPI
> +	tristate "Support for CAN over SPI"
> +	depends on CAN_DEV

This all depends on CAN_DEV anyway.
You can remove this dependency here.

> +	---help---
> +	  Driver to transfer CAN messages to a microcontroller
> +	  connected via the SPI interface using a simple messaged based
> +	  protocol.
> +
> +	  Say Y here if you want to support for CAN to SPI.
> +
>  endmenu
> diff --git a/drivers/net/can/spi/Makefile b/drivers/net/can/spi/Makefile
> index 90bcacf..0fd2126 100644
> --- a/drivers/net/can/spi/Makefile
> +++ b/drivers/net/can/spi/Makefile
> @@ -4,5 +4,6 @@
>  
>  
>  obj-$(CONFIG_CAN_MCP251X)	+= mcp251x.o
> +obj-$(CONFIG_CAN_SPI)		+= spi_can.o
>  
>  ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG
> diff --git a/drivers/net/can/spi/spi_can.c b/drivers/net/can/spi/spi_can.c
> new file mode 100644
> index 0000000..aee924a
> --- /dev/null
> +++ b/drivers/net/can/spi/spi_can.c


> +
> +#define MAX_CAN_CHANNELS	16
> +#define CFG_CHANNEL		0xFF
> +#define DRV_NAME		"canoverspi"

spi_can ?


> +
> +/* Message IDs for SPI Frame */
> +enum msg_type {
> +	SPI_MSG_STATUS_REQ	= 0x01,
> +	SPI_MSG_SEND_DATA	= 0x02,
> +	SPI_MSG_SYNC		= 0x03,
> +	SPI_MSG_CFG		= 0x04,
> +	SPI_MSG_REQ_DATA	= 0x05
> +};


> + */
> +
> +struct msg_channel_data {
> +	u8	channel;
> +	u32	timestamp;
> +	u32	can_id;
> +	u8	dlc;
> +	u8	data[8];
> +} __packed;
> +

I assume CAN FD capable SPI/CAN capable controllers to emerge in the mid
future. What's your concept for that? E.g. define SPI_MSG_SEND_FD_DATA then?

> +/* CFG message */
> +struct msg_cfg_data {
> +	u8	channel;
> +	u8	enabled;
> +	struct can_bittiming bt;
> +} __packed;

Why don't you pass this configuration stuff like

- enable/disable
- set bitrate

in a message which is sent via the dedicated interface (mux) channel?

I don't see the need for an extra configuration channel.A (new designed)
SPI_MSG_CFG message should be able to be processed by every interface channel.

Other questions:

1. Why can't the SPI always run in the high speed?
2. The number of CAN interfaces is taken from the OF information. IMHO the SPI
CAN micro controller should give the number of available interfaces when it is
asked for (via new SPI_MSG_CFG message?).

What's your concept regarding the SPI firmware update?
E.g. what about a new message type SPI_MSG_FW_UPDATE which is supported by the
micro controller but not by the CAN netdevice driver.

E.g. is something like this possible:

rmmod spi_can
fw-upload-tool /dev/spi0 firmware.img

??



> +
> +/* Default Values */
> +static struct can_bittiming_const spi_can_bittiming_const = {
> +	.name = DRV_NAME,
> +	.tseg1_min = 4,
> +	.tseg1_max = 16,
> +	.tseg2_min = 2,
> +	.tseg2_max = 8,
> +	.sjw_max = 4,
> +	.brp_min = 1,
> +	.brp_max = 64,
> +	.brp_inc = 1,
> +};

This also depends on the CAN controllers in the micro controller.
Therefore the struct can_bittiming_const has to be retrieved from the micro
controller at setup time (via new SPI_MSG_CFG message).


> +/* Provide a way to disable checksum */
> +static unsigned int chksum_en;
> +module_param(chksum_en, uint, 0);
> +MODULE_PARM_DESC(chksum_en,
> +	"Enable checksum test on received frames (default is disabled)");

Why did you define and implement a checksum, switch it off by default and then
provide an interface to enable it again?

IMO remove this module parameter and switch it on.
Or remove the checksum stuff entirely.

> +static unsigned int freq;
> +module_param(freq, uint, 0);
> +MODULE_PARM_DESC(freq,
> +	"SPI clock frequency (default is set by platform device)");

Really needed?

> +static unsigned int slow_freq;
> +module_param(slow_freq, uint, 0);
> +MODULE_PARM_DESC(slow_freq,
> +	"SPI clock frequency to be used in supervisor mode (default 1 Mhz)");

Why not always use the high SPI clock?

> +static unsigned int debug;
> +module_param(debug, uint, 0);
> +MODULE_PARM_DESC(freq, "enables dump of received bytes");
                    ^^^^
Obviously never used :-))

If you really think about debugging this better add an extra define or use
CAN_DEBUG_DEVICES.


> +SHOW_SYS_ATTR(spi_sent_bytes, spibytes);
> +SHOW_SYS_ATTR(max_req_bytes, maxreqbytes);
> +SHOW_SYS_ATTR(canmsg_sent, cantxmsg);
> +SHOW_SYS_ATTR(canmsg_received, canrxmsg);
> +SHOW_SYS_ATTR(cfgmsg_sent, cfgmsg);
> +SHOW_SYS_ATTR(messages_in_queue, messages_in_queue);
> +SHOW_SYS_ATTR(average_length, average_length);
> +SHOW_SYS_ATTR(current_length, current_length);
> +SHOW_SYS_ATTR(short_frames, short_frames);
> +SHOW_SYS_ATTR(spi_sent_frames, spi_sent_frames);

This is definitely debug stuff.

Are you use it's needed in production code?
Or at least with CAN_DEBUG_DEVICES only??

Don't be disappointed by my remarks.
I really like the idea - but IMO there's relly some space for improvements ;-)

Best regards,
Oliver

> +++ b/include/linux/can/platform/spican.h

spi_can.h

> +#ifndef __CAN_PLATFORM_SPICAN_H__

__CAN_PLATFORM_SPI_CAN_H__

> +#define __CAN_PLATFORM_SPICAN_H__
> +
> +#include <linux/spi/spi.h>
> +
> +/*
> + * struct hcs12_imx_platform_data - i.MX to HCS12 CAN controller platform data
             ^^^^^^^^^^                ^^^^    ^^^^^

