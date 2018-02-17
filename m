From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v4 2/2] can: kvaser_usb: Expose EAN and serial number via
 sysfs
Date: Sat, 17 Feb 2018 19:56:49 +0100
Message-ID: <eed7b7fd-5303-7e8d-02fb-8ce1b6d85444@hartkopp.net>
References: <20180216134107.9096-1-jimmyassarsson@gmail.com>
 <20180216134107.9096-2-jimmyassarsson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:34933 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbeBQS5A (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 17 Feb 2018 13:57:00 -0500
In-Reply-To: <20180216134107.9096-2-jimmyassarsson@gmail.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jimmy Assarsson <jimmyassarsson@gmail.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hi Jimmy, Marc,

IMO this patch does not solve the general requirement for exposing 
serial numbers.

Additionally the 'ean' attribute is obsolete due to the unique USB 
vendor and product id.

E.g. attaching a USB Pro FD adapter in my Laptop creates this dmesg output:

[ 5210.858742] usb 3-6: new high-speed USB device number 6 using xhci_hcd
[ 5211.007608] usb 3-6: config 1 interface 0 altsetting 0 bulk endpoint 
0x83 has invalid maxpacket 64
[ 5211.007627] usb 3-6: config 1 interface 1 altsetting 0 bulk endpoint 
0x84 has invalid maxpacket 64
[ 5211.007633] usb 3-6: config 1 interface 1 altsetting 0 bulk endpoint 
0x4 has invalid maxpacket 64
[ 5211.007638] usb 3-6: config 1 interface 1 altsetting 0 bulk endpoint 
0x85 has invalid maxpacket 64
[ 5211.007643] usb 3-6: config 1 interface 1 altsetting 0 bulk endpoint 
0x5 has invalid maxpacket 64
[ 5211.007648] usb 3-6: config 1 interface 1 altsetting 0 bulk endpoint 
0x86 has invalid maxpacket 64
[ 5211.007653] usb 3-6: config 1 interface 1 altsetting 0 bulk endpoint 
0x6 has invalid maxpacket 64
[ 5211.008447] usb 3-6: New USB device found, idVendor=0c72, idProduct=0011
[ 5211.008454] usb 3-6: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[ 5211.008459] usb 3-6: Product: PCAN-USB Pro FD
[ 5211.008463] usb 3-6: Manufacturer: PEAK-System Technik GmbH
[ 5211.036944] CAN device driver interface
[ 5211.048600] peak_usb 3-6:1.0: PEAK-System PCAN-USB Pro FD v1 fw 
v2.1.0 (2 channels)
[ 5211.048916] peak_usb 3-6:1.0 can0: attached to PCAN-USB Pro FD 
channel 0 (device 1334)
[ 5211.050056] peak_usb 3-6:1.0 can1: attached to PCAN-USB Pro FD 
channel 1 (device 4294967295)
[ 5211.050247] usbcore: registered new interface driver peak_usb

$ cat /sys/class/net/can0/device/modalias
usb:v0C72p0011d0000dc00dsc00dp00ic00isc00ip00in00
     ^^^^^^^^^^

Vendor ID 0C72
Product ID 0011

-> this is as unique as the EAN, right?

For PCI devices this is similar:
$ cat /sys/class/net/can2/device/modalias
pci:v0000001Cd00000002sv0000001Csd00000004bc02sc80i00
     ^^^^^^^^^^^^^^^^^^

001C -> PEAK System
0002 -> PEAK_PCIEC_DEVICE_ID    0x0002  /* for ExpressCard slot cards */

So no need for an EAN ?!!

The other thing may be hardware or firmware revisions and the unique 
device ID (aka serial number)

For these I would suggest attibutes like

hw_rev
fw_rev
dev_uid

to be provided by drivers/net/can/dev.c and filled with content from the 
driver when calling alloc_candev() - e.g. by passing a pointer to a 
struct which contains the content.

e.g.

struct can_sysfs_info {
	u16 hw_rev_major;
	u16 hw_rev_minor;
	u16 fw_rev_major;
	u16 fw_rev_minor;
	u32 uid;
}


The code with

On 02/16/2018 02:41 PM, Jimmy Assarsson wrote:
> +
> +static DEVICE_ATTR_RO(serial);
> +static DEVICE_ATTR_RO(ean);
> +
> +static struct attribute *kvaser_usb_dev_attrs[] = {
> +	&dev_attr_serial.attr,
> +	&dev_attr_ean.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group kvaser_usb_dev_group = {
> +	.attrs = kvaser_usb_dev_attrs,
> +};
> +

(..)

> +	netdev->sysfs_groups[0] = &kvaser_usb_dev_group;
>   
>   	SET_NETDEV_DEV(netdev, &intf->dev);
>   	netdev->dev_id = channel;

looks great - but needs to be moved to ../can/dev.c IMHO.

Best regards,
Oliver

ps. I would like to move the Softing driver and the PEAK USB to that 
common approach too - once it is available.
I have to look for an old Softing PCMCIA card for testing then ;-)
