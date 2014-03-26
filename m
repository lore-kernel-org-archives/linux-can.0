From: Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH v2 3/3] CAN: CAN driver to support multiple CAN bus on
 SPI interface
Date: Wed, 26 Mar 2014 10:01:44 +0100
Message-ID: <53329778.7080409@denx.de>
References: <1395757822-22283-1-git-send-email-sbabic@denx.de> <1395757822-22283-4-git-send-email-sbabic@denx.de> <5331D0F3.4050207@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:60809 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbaCZJBt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Mar 2014 05:01:49 -0400
In-Reply-To: <5331D0F3.4050207@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: Stefano Babic <sbabic@denx.de>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

Hi Oliver,


On 25/03/2014 19:54, Oliver Hartkopp wrote:
> 
> 
> On 25.03.2014 15:30, Stefano Babic wrote:
>> This driver implements a simple protocol
>> to transfer CAN messages to and from an external
>> microcontroller via SPI interface.
>> Multiple busses can be tranfered on the same SPI channel.
>>
>> It was tested on a i.MX35 connected to a Freescale's
>> HCS12 16-bit controller with 5 CAN busses.
>>
>> Signed-off-by: Stefano Babic <sbabic@denx.de>
>>
>> ---
>>
>> Changes in v2:
>> - drop all references to i.MX35 and HCS12
> 
> See include/linux/can/platform/spican.h
> 
> There are still some of them.

Thanks to find them.

> 
>>
>>  drivers/net/can/spi/Kconfig         |   10 +
>>  drivers/net/can/spi/Makefile        |    1 +
>>  drivers/net/can/spi/spi_can.c       | 1534 +++++++++++++++++++++++++++++++++++
>>  include/linux/can/platform/spican.h |   36 +
>>  4 files changed, 1581 insertions(+)
>>  create mode 100644 drivers/net/can/spi/spi_can.c
>>  create mode 100644 include/linux/can/platform/spican.h
> 
> spi_can.h

Ok

> 
>>
>> diff --git a/drivers/net/can/spi/Kconfig b/drivers/net/can/spi/Kconfig
>> index 148cae5..299d71ca 100644
>> --- a/drivers/net/can/spi/Kconfig
>> +++ b/drivers/net/can/spi/Kconfig
>> @@ -7,4 +7,14 @@ config CAN_MCP251X
>>  	---help---
>>  	  Driver for the Microchip MCP251x SPI CAN controllers.
>>  
>> +config CAN_SPI
>> +	tristate "Support for CAN over SPI"
>> +	depends on CAN_DEV
> 
> This all depends on CAN_DEV anyway.
> You can remove this dependency here.

Right, I will remove it.

> 
>> +	---help---
>> +	  Driver to transfer CAN messages to a microcontroller
>> +	  connected via the SPI interface using a simple messaged based
>> +	  protocol.
>> +
>> +	  Say Y here if you want to support for CAN to SPI.
>> +
>>  endmenu
>> diff --git a/drivers/net/can/spi/Makefile b/drivers/net/can/spi/Makefile
>> index 90bcacf..0fd2126 100644
>> --- a/drivers/net/can/spi/Makefile
>> +++ b/drivers/net/can/spi/Makefile
>> @@ -4,5 +4,6 @@
>>  
>>  
>>  obj-$(CONFIG_CAN_MCP251X)	+= mcp251x.o
>> +obj-$(CONFIG_CAN_SPI)		+= spi_can.o
>>  
>>  ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG
>> diff --git a/drivers/net/can/spi/spi_can.c b/drivers/net/can/spi/spi_can.c
>> new file mode 100644
>> index 0000000..aee924a
>> --- /dev/null
>> +++ b/drivers/net/can/spi/spi_can.c
> 
> 
>> +
>> +#define MAX_CAN_CHANNELS	16
>> +#define CFG_CHANNEL		0xFF
>> +#define DRV_NAME		"canoverspi"
> 
> spi_can ?

Well, sometimes I search for new names...I will change to be consistent ;-)


> 
> 
>> +
>> +/* Message IDs for SPI Frame */
>> +enum msg_type {
>> +	SPI_MSG_STATUS_REQ	= 0x01,
>> +	SPI_MSG_SEND_DATA	= 0x02,
>> +	SPI_MSG_SYNC		= 0x03,
>> +	SPI_MSG_CFG		= 0x04,
>> +	SPI_MSG_REQ_DATA	= 0x05
>> +};
> 
> 
>> + */
>> +
>> +struct msg_channel_data {
>> +	u8	channel;
>> +	u32	timestamp;
>> +	u32	can_id;
>> +	u8	dlc;
>> +	u8	data[8];
>> +} __packed;
>> +
> 
> I assume CAN FD capable SPI/CAN capable controllers to emerge in the mid
> future. What's your concept for that?

IMHO the driver should be backward compatible as CAN FD is. The CAN
frame is now encapsulated inside a SPI_MSG_SEND_DATA. To support CAN FD,
the driver should, exactly as most drivers should do, check for IDE-bit
(Identifier extension). As dlc is only 4 bits, we we could use the rest
to detect the format.

However, I will not add some extensions now - I have no way to test it,
and I think we can easy add CAN FD support later when the driver is merged.

> E.g. define SPI_MSG_SEND_FD_DATA then?

No, I do not thinks so. SPI_MSG_SEND_DATA is only thought as a way for
the master to provide enough clock cycles (if it has nothing to send) to
the slave, allowing the slave to send back the received packets.

I can also imagine that there is a mix between channels, some of them
are CAN FD and some of them no. If we use a different message as
SPI_MSG_SEND_FD_DATA, the master should know before starting a
communication which are the packets that the slave wants to send, and it
cannot know. It is better to have a "neutral" message (an anonymous
SPI_SEND_DATA), checking then in the received SPI frame which is the
type of CAN data. Of course, the slave should do the same in the other
direction.


> 
>> +/* CFG message */
>> +struct msg_cfg_data {
>> +	u8	channel;
>> +	u8	enabled;
>> +	struct can_bittiming bt;
>> +} __packed;
> 
> Why don't you pass this configuration stuff like
> 
> - enable/disable
> - set bitrate
> 
> in a message which is sent via the dedicated interface (mux) channel?
> 
> I don't see the need for an extra configuration channel.A (new designed)
> SPI_MSG_CFG message should be able to be processed by every interface channel.
> 

I explain this just a bit later.

> Other questions:
> 
> 1. Why can't the SPI always run in the high speed?

This can be a limitation on the HCS-12, but it could be a general
limitation. The HCS-12 have a "boot" firmware, able to run only at lower
speed, and able to get a new firmware image (there is no software to
manage the can busses). After upgrading or if a valid image is found,
the slave is able to run at full speed. It is not a limitation on the
main controller side.

> 2. The number of CAN interfaces is taken from the OF information. IMHO the SPI
> CAN micro controller should give the number of available interfaces when it is
> asked for (via new SPI_MSG_CFG message?).

Not always. Agree that we can add a query to get the number of physical
channels. However, the OF/platform data channels is thought to limit the
number of provided network interface. The slave controller can have
multiple bus, but only a few of them are physically active and it is
required to expone only some CAN interfaces.

> 
> What's your concept regarding the SPI firmware update?
> E.g. what about a new message type SPI_MSG_FW_UPDATE which is supported by the
> micro controller but not by the CAN netdevice driver.
> 
> E.g. is something like this possible:
> 
> rmmod spi_can
> fw-upload-tool /dev/spi0 firmware.img

No, there is another concept. The reason to have a separate
configuration channel is to provide a general way to exchange packets
between the Application Layer and the Slave, without intervention of the
driver. A sort of out-of-band data. The driver should not know anything
about the type of exchanged packets on this channel.

The application layer starts to send packets on the CFG channel, that
are interpreted as firmware update by the slave. These data can be very
microcontroller or project specific and I cared that the driver does not
check inside this channel. Not only: it is also possible to update the
slave reducing the time of out of service, because the old software can
(or could) also run. If we remove the module and start a new tool to
upgrade the slave, the CAN busses are not available until the update is
ready. Using the CFG channel, the out of service time is limited to the
time for the slave to switch the software.

There are many other usage for the CFG channel. Some examples:

- the slave has also some GPIOs that the Application Layer can set up.
The Application use the CFG channel to inform the slave how to handle.

- the slave can implement some other proprietary interface and must
communicate something with the application. This can be also very
project specific

The CFG channel is a way to let the application in user space on the
main controller to communicate directly with the slave without
intervention of the underlying (this driver) layers. The driver shows to
the application a socket-CAN interface, even for the CFG channel, and
this is consistent. It is then duty of the application on the main and
slave controller to specify which messages and which functions they want
to exchange.

>> +
>> +/* Default Values */
>> +static struct can_bittiming_const spi_can_bittiming_const = {
>> +	.name = DRV_NAME,
>> +	.tseg1_min = 4,
>> +	.tseg1_max = 16,
>> +	.tseg2_min = 2,
>> +	.tseg2_max = 8,
>> +	.sjw_max = 4,
>> +	.brp_min = 1,
>> +	.brp_max = 64,
>> +	.brp_inc = 1,
>> +};
> 
> This also depends on the CAN controllers in the micro controller.

You are right.

> Therefore the struct can_bittiming_const has to be retrieved from the micro
> controller at setup time (via new SPI_MSG_CFG message).

The structure is only there to have a default and it is not used at all.
I am not sure, can I drop it completely and not set can.bittiming_const
before registering the network interface ?

The slave, as defined in protocol, receives the data for configuration
(bitrate, ..) exactly as the driver has received from socket-CAN. The
driver converts only the values as big endian, but it does not
interprete them (function spi_can_cfg). The driver itself does not use
this structure.

> 
> 
>> +/* Provide a way to disable checksum */
>> +static unsigned int chksum_en;
>> +module_param(chksum_en, uint, 0);
>> +MODULE_PARM_DESC(chksum_en,
>> +	"Enable checksum test on received frames (default is disabled)");
> 
> Why did you define and implement a checksum, switch it off by default and then
> provide an interface to enable it again?

This was a hard debate during the development. If the checksum is quite
useless on the main controller side, it was very helpful for the
firmware developers on the slave to check for issues (missing
interrupts, ...) on their side. Disabling the checksum is then a way if
performance (on the slave side, of course..) are affected.

> 
> IMO remove this module parameter and switch it on.

Agree on switching on as default. However, I will let the module
parametr for fine tuning if needed.

> Or remove the checksum stuff entirely.
> 
>> +static unsigned int freq;
>> +module_param(freq, uint, 0);
>> +MODULE_PARM_DESC(freq,
>> +	"SPI clock frequency (default is set by platform device)");
> 
> Really needed?
> 
>> +static unsigned int slow_freq;
>> +module_param(slow_freq, uint, 0);
>> +MODULE_PARM_DESC(slow_freq,
>> +	"SPI clock frequency to be used in supervisor mode (default 1 Mhz)");
> 
> Why not always use the high SPI clock?

I explained this before.

> 
>> +static unsigned int debug;
>> +module_param(debug, uint, 0);
>> +MODULE_PARM_DESC(freq, "enables dump of received bytes");
>                     ^^^^
> Obviously never used :-))
> 
> If you really think about debugging this better add an extra define or use
> CAN_DEBUG_DEVICES.
> 
> 
>> +SHOW_SYS_ATTR(spi_sent_bytes, spibytes);
>> +SHOW_SYS_ATTR(max_req_bytes, maxreqbytes);
>> +SHOW_SYS_ATTR(canmsg_sent, cantxmsg);
>> +SHOW_SYS_ATTR(canmsg_received, canrxmsg);
>> +SHOW_SYS_ATTR(cfgmsg_sent, cfgmsg);
>> +SHOW_SYS_ATTR(messages_in_queue, messages_in_queue);
>> +SHOW_SYS_ATTR(average_length, average_length);
>> +SHOW_SYS_ATTR(current_length, current_length);
>> +SHOW_SYS_ATTR(short_frames, short_frames);
>> +SHOW_SYS_ATTR(spi_sent_frames, spi_sent_frames);
> 
> This is definitely debug stuff.

Absolutely, right.

> 
> Are you use it's needed in production code?

I will tend to discharge them

> Or at least with CAN_DEBUG_DEVICES only??

I will check both of them. I am not a fan of #ifdef, but I agree this is
all debug stuff.

> 
> Don't be disappointed by my remarks.

Absolutely, I am not ! I am glad you are reviewing my code, many thanks !

> I really like the idea - but IMO there's relly some space for improvements ;-)
> 

Of course..I will try my best to make the code suitable for merging. I
will work now for V3.


> Best regards,
> Oliver
> 
>> +++ b/include/linux/can/platform/spican.h
> 
> spi_can.h
> 
>> +#ifndef __CAN_PLATFORM_SPICAN_H__
> 
> __CAN_PLATFORM_SPI_CAN_H__
> 
>> +#define __CAN_PLATFORM_SPICAN_H__
>> +
>> +#include <linux/spi/spi.h>
>> +
>> +/*
>> + * struct hcs12_imx_platform_data - i.MX to HCS12 CAN controller platform data
>              ^^^^^^^^^^                ^^^^    ^^^^^

Right, I missed to fix the comment, too. Thanks !


Best regards,
Stefano



-- 
=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
