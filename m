From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] usb2can: Add support for USB2CAN interface from 8 devices
Date: Sun, 02 Dec 2012 11:36:38 +0100
Message-ID: <50BB2F36.3040303@hartkopp.net>
References: <50BB1E8E.10809@universalnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:28712 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851Ab2LBKgn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 2 Dec 2012 05:36:43 -0500
In-Reply-To: <50BB1E8E.10809@universalnet.at>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "krumboeck@universalnet.at" <krumboeck@universalnet.at>
Cc: linux-can@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

Hallo Bernd,

nice to see that you have been able to send the patch that fast :-)

In general please rename the Kconfig entries and the driver to 8dev_usb as
there are various USB-to-CAN adapters available.

This follows the <vendor>_usb rule like peak_usb, esd_usb, etc.

Some more comments inline.

On 02.12.2012 10:25, krumboeck@universalnet.at wrote:

> Add device driver for USB2CAN interface from "8 devices"


> (http://www.8devices.com).
> 
> Signed-off-by: Bernd Krumboeck <krumboeck@universalnet.at>
> ---
>  drivers/net/can/usb/Kconfig   |    6 +
>  drivers/net/can/usb/Makefile  |    1 +
>  drivers/net/can/usb/usb2can.c | 1323 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1330 insertions(+)
>  create mode 100644 drivers/net/can/usb/usb2can.c
> 
> diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
> index a4e4bee..2068c99 100644
> --- a/drivers/net/can/usb/Kconfig
> +++ b/drivers/net/can/usb/Kconfig
> @@ -48,4 +48,10 @@ config CAN_PEAK_USB
>        This driver supports the PCAN-USB and PCAN-USB Pro adapters
>        from PEAK-System Technik (http://www.peak-system.com).
> 
> +config CAN_USB2CAN
> +    tristate "8 devices USB2CAN interface"
> +    ---help---
> +      This driver supports the USB2CAN interface
> +      from 8 devices (http://www.8devices.com).
> +
>  endmenu
> diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
> index 80a2ee4..3c0a378 100644
> --- a/drivers/net/can/usb/Makefile
> +++ b/drivers/net/can/usb/Makefile
> @@ -6,5 +6,6 @@ obj-$(CONFIG_CAN_EMS_USB) += ems_usb.o
>  obj-$(CONFIG_CAN_ESD_USB2) += esd_usb2.o
>  obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb.o
>  obj-$(CONFIG_CAN_PEAK_USB) += peak_usb/
> +obj-$(CONFIG_CAN_USB2CAN) += usb2can.o
> 
>  ccflags-$(CONFIG_CAN_DEBUG_DEVICES) := -DDEBUG
> diff --git a/drivers/net/can/usb/usb2can.c b/drivers/net/can/usb/usb2can.c
> new file mode 100644
> index 0000000..5a09141
> --- /dev/null
> +++ b/drivers/net/can/usb/usb2can.c
> @@ -0,0 +1,1323 @@
> +/*
> + * CAN driver for UAB "8 devices" USB2CAN converter
> + *
> + * Copyright (C) 2012 Bernd Krumboeck (krumboeck@universalnet.at)
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published
> + * by the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + * This driver is based on the 3.2.0 version of drivers/net/can/usb/ems_usb.c
> + * and drivers/net/can/usb/esd_usb2.c
> + *
> + * Many thanks to Gerhard Bertelsmann (info@gerhard-bertelsmann.de)
> + * for testing and fixing this driver. Also many thanks to "8 devices",
> + * who were very cooperative and answered my questions.
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/signal.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/usb.h>
> +
> +#include <linux/can.h>
> +#include <linux/can/dev.h>
> +#include <linux/can/error.h>
> +
> +


One empty line is enough here ...

> +/* driver constants */
> +#define MAX_RX_URBS            10
> +#define MAX_TX_URBS            10
> +#define RX_BUFFER_SIZE            64
> +
> +/* vendor and product id */
> +#define USB2CAN_VENDOR_ID        0x0483
> +#define USB2CAN_PRODUCT_ID        0x1234


As 8DEV_USB_VENDOR_ID will not work and will create an error message like

drivers/net/can/usb/8dev_usb.c:46:9: error: macro names must be identifiers

you might stay on USB2CAN_ as prefix here.

> +

> +/* bittiming constants */
> +#define USB2CAN_ABP_CLOCK        32000000
> +#define USB2CAN_BAUD_MANUAL        0x09
> +#define USB2CAN_TSEG1_MIN        1
> +#define USB2CAN_TSEG1_MAX        16
> +#define USB2CAN_TSEG2_MIN        1
> +#define USB2CAN_TSEG2_MAX        8
> +#define USB2CAN_SJW_MAX            4
> +#define USB2CAN_BRP_MIN            1
> +#define USB2CAN_BRP_MAX            1024
> +#define USB2CAN_BRP_INC            1
> +
> +/* setup flags */
> +#define USB2CAN_SILENT            0x00000001
> +#define USB2CAN_LOOPBACK        0x00000002
> +#define USB2CAN_DISABLE_AUTO_RESTRANS    0x00000004
> +#define USB2CAN_STATUS_FRAME        0x00000008


Why not using 0x1 .. 0x8 without all the '0's ?

> +
> +/* commands */
> +#define USB2CAN_RESET            1
> +#define USB2CAN_OPEN            2
> +#define USB2CAN_CLOSE            3
> +#define USB2CAN_SET_SPEED        4
> +#define USB2CAN_SET_MASK_FILTER        5
> +#define USB2CAN_GET_STATUS        6
> +#define USB2CAN_GET_STATISTICS        7
> +#define USB2CAN_GET_SERIAL        8
> +#define USB2CAN_GET_SOFTW_VER        9
> +#define USB2CAN_GET_HARDW_VER        10
> +#define USB2CAN_RESET_TIMESTAMP        11
> +#define USB2CAN_GET_SOFTW_HARDW_VER    12
> +
> +#define USB2CAN_CMD_START        0x11
> +#define USB2CAN_CMD_END            0x22
> +
> +#define USB2CAN_CMD_SUCCESS        0
> +#define USB2CAN_CMD_ERROR        255
> +
> +/* statistics */
> +#define USB2CAN_STAT_RX_FRAMES        0
> +#define USB2CAN_STAT_RX_BYTES        1
> +#define USB2CAN_STAT_TX_FRAMES        2
> +#define USB2CAN_STAT_TX_BYTES        3
> +#define USB2CAN_STAT_OVERRUNS        4
> +#define USB2CAN_STAT_WARNINGS        5
> +#define USB2CAN_STAT_BUS_OFF        6
> +#define USB2CAN_STAT_RESET_STAT        7
> +
> +/* frames */
> +#define USB2CAN_DATA_START        0x55
> +#define USB2CAN_DATA_END        0xAA
> +
> +#define USB2CAN_TYPE_CAN_FRAME        0
> +#define USB2CAN_TYPE_ERROR_FRAME    3
> +
> +#define USB2CAN_EXTID            0x01
> +#define USB2CAN_RTR            0x02
> +#define USB2CAN_ERR_FLAG        0x04
> +
> +/* status */
> +#define USB2CAN_STATUSMSG_OK        0x00  /* Normal condition. */
> +#define USB2CAN_STATUSMSG_OVERRUN    0x01  /* Overrun occured when sending */
> +#define USB2CAN_STATUSMSG_BUSLIGHT    0x02  /* Error counter has reached 96 */
> +#define USB2CAN_STATUSMSG_BUSHEAVY    0x03  /* Error count. has reached 128 */
> +#define USB2CAN_STATUSMSG_BUSOFF    0x04  /* Device is in BUSOFF */
> +#define USB2CAN_STATUSMSG_STUFF        0x20  /* Stuff Error */
> +#define USB2CAN_STATUSMSG_FORM        0x21  /* Form Error */
> +#define USB2CAN_STATUSMSG_ACK        0x23  /* Ack Error */
> +#define USB2CAN_STATUSMSG_BIT0        0x24  /* Bit1 Error */
> +#define USB2CAN_STATUSMSG_BIT1        0x25  /* Bit0 Error */
> +#define USB2CAN_STATUSMSG_CRC        0x26  /* CRC Error */
> +
> +#define USB2CAN_RP_MASK            0x7F  /* Mask for Receive Error Bit */
> +
> +
> +/* table of devices that work with this driver */
> +static struct usb_device_id usb2can_table[] = {
> +    { USB_DEVICE(USB2CAN_VENDOR_ID, USB2CAN_PRODUCT_ID) },
> +    { }                    /* Terminating entry */
> +};
> +
> +MODULE_DEVICE_TABLE(usb, usb2can_table);
> +
> +struct usb2can_tx_urb_context {
> +    struct usb2can *dev;
> +
> +    u32 echo_index;
> +    u8 dlc;
> +};
> +
> +/* Structure to hold all of our device specific stuff */
> +struct usb2can {
> +    struct can_priv can; /* must be the first member */
> +
> +    struct sk_buff *echo_skb[MAX_TX_URBS];
> +
> +    struct usb_device *udev;
> +    struct net_device *netdev;
> +
> +    atomic_t active_tx_urbs;
> +    struct usb_anchor tx_submitted;
> +    struct usb2can_tx_urb_context tx_contexts[MAX_TX_URBS];
> +
> +    struct usb_anchor rx_submitted;
> +
> +    u8 *cmd_msg_buffer;
> +
> +    unsigned int free_slots; /* remember number of available slots */
> +
> +    unsigned int dar; /* disable automatic restransmission */
> +
> +    struct mutex usb2can_cmd_lock;
> +};
> +
> +/* tx frame */
> +struct __packed usb2can_tx_msg {
> +    u8 begin;
> +    u8 flags;    /* RTR and EXT_ID flag */
> +    __be32 id;    /* upper 3 bits not used */
> +    u8 dlc;        /* data length code 0-8 bytes */
> +    u8 data[8];    /* 64-bit data */
> +    u8 end;
> +};
> +
> +/* rx frame */
> +struct __packed usb2can_rx_msg {
> +    u8 begin;
> +    u8 type;        /* frame type */
> +    u8 flags;        /* RTR and EXT_ID flag */
> +    __be32 id;        /* upper 3 bits not used */
> +    u8 dlc;            /* data length code 0-8 bytes */
> +    u8 data[8];        /* 64-bit data */
> +    __be32 timestamp;    /* 32-bit timestamp */
> +    u8 end;
> +};
> +
> +/* command frame */
> +struct __packed usb2can_cmd_msg {
> +    u8 begin;
> +    u8 channel;    /* unkown - always 0 */
> +    u8 command;    /* command to execute */
> +    u8 opt1;    /* optional parameter / return value */
> +    u8 opt2;    /* optional parameter 2 */
> +    u8 data[10];    /* optional parameter and data */
> +    u8 end;
> +};
> +
> +static struct usb_driver usb2can_driver;
> +
> +static int usb2can_send_cmd_msg(struct usb2can *dev, u8 *msg, int size)
> +{
> +    int actual_length;
> +
> +    return usb_bulk_msg(dev->udev,
> +                usb_sndbulkpipe(dev->udev, 4),
> +                msg,
> +                size,
> +                &actual_length,
> +                1000);
> +}
> +
> +static int usb2can_wait_cmd_msg(struct usb2can *dev, u8 *msg, int size,
> +                int *actual_length)
> +{
> +    return usb_bulk_msg(dev->udev,
> +                usb_rcvbulkpipe(dev->udev, 3),
> +                msg,
> +                size,
> +                actual_length,
> +                1000);
> +}
> +
> +/* Send command to device and receive result.
> + * Command was successful When opt1 = 0.
> + */
> +static int usb2can_send_cmd(struct usb2can *dev, struct usb2can_cmd_msg *out,
> +                struct usb2can_cmd_msg *in)
> +{
> +    int    err;
> +    int    nBytesRead;


Remove tabs here.

> +    struct net_device *netdev;
> +
> +    netdev = dev->netdev;
> +
> +    out->begin = USB2CAN_CMD_START;
> +    out->end = USB2CAN_CMD_END;
> +
> +    memcpy(&dev->cmd_msg_buffer[0], out,
> +        sizeof(struct usb2can_cmd_msg));
> +
> +    mutex_lock(&dev->usb2can_cmd_lock);
> +
> +    err = usb2can_send_cmd_msg(dev, &dev->cmd_msg_buffer[0],
> +                   sizeof(struct usb2can_cmd_msg));
> +    if (err < 0) {
> +        dev_err(netdev->dev.parent, "sending command message failed\n");
> +        return err;
> +    }
> +
> +    err = usb2can_wait_cmd_msg(dev, &dev->cmd_msg_buffer[0],
> +                   sizeof(struct usb2can_cmd_msg), &nBytesRead);
> +    if (err < 0) {
> +        dev_err(netdev->dev.parent, "no command message answer\n");
> +        return err;
> +    }
> +
> +    mutex_unlock(&dev->usb2can_cmd_lock);
> +
> +    memcpy(in, &dev->cmd_msg_buffer[0],
> +        sizeof(struct usb2can_cmd_msg));
> +
> +    if (in->begin != USB2CAN_CMD_START || in->end != USB2CAN_CMD_END ||
> +            nBytesRead != 16 || in->opt1 != 0)
> +        return -EPROTO;
> +
> +    return 0;
> +}
> +
> +/* Send open command to device */
> +static int usb2can_cmd_open(struct usb2can *dev)
> +{
> +    struct can_bittiming *bt = &dev->can.bittiming;
> +    struct usb2can_cmd_msg    outmsg;
> +    struct usb2can_cmd_msg    inmsg;


remove tabs

> +    u32 flags = 0x00000000;


0

> +    u32 beflags;
> +    u16 bebrp;
> +    u32 ctrlmode = dev->can.ctrlmode;
> +
> +    if (ctrlmode & CAN_CTRLMODE_LOOPBACK)
> +        flags |= USB2CAN_LOOPBACK;
> +    if (ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +        flags |= USB2CAN_SILENT;
> +    if (dev->dar == 1)
> +        flags |= USB2CAN_DISABLE_AUTO_RESTRANS;
> +
> +    flags |= USB2CAN_STATUS_FRAME;
> +
> +    memset(&outmsg, 0, sizeof(struct usb2can_cmd_msg));
> +    outmsg.command = USB2CAN_OPEN;
> +    outmsg.opt1    = USB2CAN_BAUD_MANUAL;
> +    outmsg.data[0] = (u8) (bt->prop_seg + bt->phase_seg1);
> +    outmsg.data[1] = (u8) bt->phase_seg2;
> +    outmsg.data[2] = (u8) bt->sjw;
> +
> +    /* BRP */
> +    bebrp = cpu_to_be16((u16) bt->brp);
> +    memcpy(&outmsg.data[3], &bebrp, sizeof(bebrp));
> +
> +    /* flags */
> +    beflags = cpu_to_be32(flags);
> +    memcpy(&outmsg.data[5], &beflags, sizeof(beflags));
> +
> +    return usb2can_send_cmd(dev, &outmsg, &inmsg);
> +}
> +
> +/* Send close command to device */
> +static int usb2can_cmd_close(struct usb2can *dev)
> +{
> +    struct usb2can_cmd_msg    outmsg;
> +    struct usb2can_cmd_msg    inmsg;
> +
> +    memset(&outmsg, 0, sizeof(struct usb2can_cmd_msg));
> +    outmsg.command = USB2CAN_CLOSE;
> +
> +    return usb2can_send_cmd(dev, &outmsg, &inmsg);
> +}
> +
> +/* Get firmware and hardware version */
> +static int usb2can_cmd_version(struct usb2can *dev, u32 *res)
> +{
> +    struct usb2can_cmd_msg    outmsg;
> +    struct usb2can_cmd_msg    inmsg;
> +    int err = 0;
> +    u32 *value;
> +
> +    memset(&outmsg, 0, sizeof(struct usb2can_cmd_msg));
> +    outmsg.command = USB2CAN_GET_SOFTW_HARDW_VER;
> +
> +    err = usb2can_send_cmd(dev, &outmsg, &inmsg);
> +    if (err)
> +        return err;
> +
> +    value = (u32 *) inmsg.data;
> +    *res = be32_to_cpu(*value);
> +
> +    return err;
> +}
> +
> +/* Get firmware version */
> +static ssize_t show_firmware(struct device *d, struct device_attribute *attr,
> +                 char *buf)
> +{
> +    struct usb2can_cmd_msg    outmsg;
> +    struct usb2can_cmd_msg    inmsg;
> +    int err = 0;
> +    u16 *value;
> +    u16 result;
> +    struct usb_interface *intf = to_usb_interface(d);
> +    struct usb2can *dev = usb_get_intfdata(intf);
> +
> +    memset(&outmsg, 0, sizeof(struct usb2can_cmd_msg));
> +    outmsg.command = USB2CAN_GET_SOFTW_VER;
> +
> +    err = usb2can_send_cmd(dev, &outmsg, &inmsg);
> +    if (err)
> +        return -EIO;
> +
> +    value = (u16 *) inmsg.data;
> +    result = be16_to_cpu(*value);
> +
> +    return sprintf(buf, "%d.%d\n", (u8)(result>>8), (u8)result);
> +}
> +
> +/* Get hardware version */
> +static ssize_t show_hardware(struct device *d, struct device_attribute *attr,
> +                 char *buf)
> +{
> +    struct usb2can_cmd_msg    outmsg;
> +    struct usb2can_cmd_msg    inmsg;
> +    int err = 0;
> +    u16 *value;
> +    u16 result;
> +    struct usb_interface *intf = to_usb_interface(d);
> +    struct usb2can *dev = usb_get_intfdata(intf);
> +
> +    memset(&outmsg, 0, sizeof(struct usb2can_cmd_msg));
> +    outmsg.command = USB2CAN_GET_HARDW_VER;
> +
> +    err = usb2can_send_cmd(dev, &outmsg, &inmsg);
> +    if (err)
> +        return -EIO;
> +
> +    value = (u16 *) inmsg.data;
> +    result = be16_to_cpu(*value);
> +
> +    return sprintf(buf, "%d.%d\n", (u8)(result>>8), (u8)result);
> +}
> +
> +/* Get status
> + *
> + * Returns:
> + * STATUS_NONE        0x00000000
> + * STATUS_BUS_OFF    0x80000000
> + * STATUS_PASSIVE    0x40000000
> + * STATUS_BUS_WARN    0x20000000
> + * STATUS_ACTIVE    0x10000000
> + * STATUS_PHY_FAULT    0x08000000
> + * STATUS_PHY_H        0x04000000
> + * STATUS_PHY_L        0x02000000
> + * STATUS_SLEEPING    0x01000000
> + * STATUS_STOPPED    0x00800000
> + */
> +static ssize_t show_status(struct device *d, struct device_attribute *attr,
> +               char *buf)
> +{
> +    struct usb2can_cmd_msg    outmsg;
> +    struct usb2can_cmd_msg    inmsg;
> +    int err = 0;
> +    u32 *value;
> +    u32 result;
> +    struct usb_interface *intf = to_usb_interface(d);
> +    struct usb2can *dev = usb_get_intfdata(intf);
> +
> +    memset(&outmsg, 0, sizeof(struct usb2can_cmd_msg));
> +    outmsg.command = USB2CAN_GET_STATUS;
> +
> +    err = usb2can_send_cmd(dev, &outmsg, &inmsg);
> +    if (err)
> +        return -EIO;
> +
> +    value = (u32 *) inmsg.data;
> +    result = be32_to_cpu(*value);
> +
> +    return sprintf(buf, "0x%08x\n", result);
> +}
> +
> +/* Get statistic values */
> +static ssize_t show_statistics(struct device *d, struct device_attribute *attr,
> +                   u8 statistic, char *buf)
> +{
> +    struct usb2can_cmd_msg    outmsg;
> +    struct usb2can_cmd_msg    inmsg;
> +    int err = 0;
> +    u32 *value;
> +    u32 result;
> +    struct usb_interface *intf = to_usb_interface(d);
> +    struct usb2can *dev = usb_get_intfdata(intf);
> +
> +    memset(&outmsg, 0, sizeof(struct usb2can_cmd_msg));
> +    outmsg.command = USB2CAN_GET_STATISTICS;
> +    outmsg.opt1 = statistic;
> +
> +    err = usb2can_send_cmd(dev, &outmsg, &inmsg);
> +    if (err)
> +        return -EIO;
> +
> +    value = (u32 *) inmsg.data;
> +    result = be32_to_cpu(*value);
> +
> +    return sprintf(buf, "%d\n", result);
> +}
> +
> +static ssize_t show_rx_frames(struct device *d, struct device_attribute *attr,
> +                  char *buf)
> +{
> +    return show_statistics(d, attr, USB2CAN_STAT_RX_FRAMES, buf);
> +}
> +
> +static ssize_t show_rx_bytes(struct device *d, struct device_attribute *attr,
> +                 char *buf)
> +{
> +    return show_statistics(d, attr, USB2CAN_STAT_RX_BYTES, buf);
> +}
> +
> +static ssize_t show_tx_frames(struct device *d, struct device_attribute *attr,
> +                  char *buf)
> +{
> +    return show_statistics(d, attr, USB2CAN_STAT_TX_FRAMES, buf);
> +}
> +
> +static ssize_t show_tx_bytes(struct device *d, struct device_attribute *attr,
> +                 char *buf)
> +{
> +    return show_statistics(d, attr, USB2CAN_STAT_RX_BYTES, buf);
> +}
> +
> +static ssize_t show_overruns(struct device *d, struct device_attribute *attr,
> +                 char *buf)
> +{
> +    return show_statistics(d, attr, USB2CAN_STAT_OVERRUNS, buf);
> +}
> +
> +static ssize_t show_warnings(struct device *d, struct device_attribute *attr,
> +                 char *buf)
> +{
> +    return show_statistics(d, attr, USB2CAN_STAT_WARNINGS, buf);
> +}
> +
> +static ssize_t show_bus_off(struct device *d, struct device_attribute *attr,
> +                char *buf)
> +{
> +    return show_statistics(d, attr, USB2CAN_STAT_BUS_OFF, buf);
> +}
> +
> +/* Reset statistics */
> +static ssize_t reset_statistics(struct device *d, struct device_attribute *attr,
> +                const char *buf, size_t count)
> +{
> +    struct usb2can_cmd_msg    outmsg;
> +    struct usb2can_cmd_msg    inmsg;
> +    int err = 0;
> +    struct usb_interface *intf = to_usb_interface(d);
> +    struct usb2can *dev = usb_get_intfdata(intf);
> +
> +    if (buf[0] == '1') {
> +        memset(&outmsg, 0, sizeof(struct usb2can_cmd_msg));
> +        outmsg.command = USB2CAN_GET_STATISTICS;
> +        outmsg.opt1 = USB2CAN_STAT_RESET_STAT;
> +
> +        err = usb2can_send_cmd(dev, &outmsg, &inmsg);
> +        if (err)
> +            return -EIO;
> +    }
> +
> +    return count;
> +}
> +
> +/* Get "disable automatic retransmission" flag */
> +static ssize_t show_dar(struct device *d, struct device_attribute *attr,
> +            char *buf)
> +{
> +    struct usb_interface *intf = to_usb_interface(d);
> +    struct usb2can *dev = usb_get_intfdata(intf);
> +
> +    return sprintf(buf, "%d\n", dev->dar);
> +}
> +
> +/* Set "disable automatic retransmission" flag */
> +static ssize_t set_dar(struct device *d, struct device_attribute *attr,
> +               const char *buf, size_t count)
> +{
> +    struct usb_interface *intf = to_usb_interface(d);
> +    struct usb2can *dev = usb_get_intfdata(intf);
> +
> +    if (dev->can.state != CAN_STATE_STOPPED) {
> +        dev_err(&intf->dev,
> +            "DAR flag can only be set when device is stopped\n");
> +        return -EIO;
> +    }
> +
> +    if (buf[0] == '0')
> +        dev->dar = 0;
> +    else if (buf[0] == '1')
> +        dev->dar = 1;
> +    else
> +        return -EIO;
> +
> +    return count;
> +}
> +
> +static DEVICE_ATTR(firmware, S_IRUGO, show_firmware, NULL);
> +static DEVICE_ATTR(hardware, S_IRUGO, show_hardware, NULL);
> +static DEVICE_ATTR(can_state, S_IRUGO, show_status, NULL);
> +static DEVICE_ATTR(can_rx_frames, S_IRUGO, show_rx_frames, NULL);
> +static DEVICE_ATTR(can_rx_bytes, S_IRUGO, show_rx_bytes, NULL);
> +static DEVICE_ATTR(can_tx_frames, S_IRUGO, show_tx_frames, NULL);
> +static DEVICE_ATTR(can_tx_bytes, S_IRUGO, show_tx_bytes, NULL);
> +static DEVICE_ATTR(can_overruns, S_IRUGO, show_overruns, NULL);
> +static DEVICE_ATTR(can_warnings, S_IRUGO, show_warnings, NULL);
> +static DEVICE_ATTR(can_bus_off_counter, S_IRUGO, show_bus_off, NULL);


I don't think that creating all these files are a good idea.
Probably there is a more generic approach for that.

Let's wait for other peoples feedback.

Regards,
Oliver
