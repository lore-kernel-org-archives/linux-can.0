From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: "[PATCH] Add support for PEAK-System GmbH CAN USB adapters (v2)
 "
Date: Wed, 21 Dec 2011 10:33:42 +0100
Message-ID: <4EF1A7F6.3030106@grandegger.com>
References: <301939.630738588-sendEmail@ubuntu-i386>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:43174 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab1LUJdp (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Dec 2011 04:33:45 -0500
In-Reply-To: <301939.630738588-sendEmail@ubuntu-i386>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "s.grosjean@peak-system.com" <s.grosjean@peak-system.com>
Cc: "socketcan@hartkopp.net" <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

More comments on the coding style...

On 12/16/2011 11:19 AM, s.grosjean@peak-system.com wrote:
>>From 1cee3be3875f27a2ee3942b00d611450f4369325 Mon Sep 17 00:00:00 2001
> From: Stephane Grosjean <s.grosjean@peak-system.com>
> Date: Fri, 16 Dec 2011 11:11:37 +0100
> Subject: [PATCH] Add support for PEAK-System GmbH CAN USB adapters (v2)
> 
> v2 includes:
>  change dev_xxx() into netdev_xxx() macros
>  add missing include linux/module.h
>  pre-allocate urbs and buffers for tx path at _open() and free them at _close()
>   rather than into _start_xmit()
>  remove some unused code and (boring) #ifdef/#endif
>  use "menuconfig" in Kconfig rather than "config" entry
> ---
>  drivers/net/can/usb/Kconfig         |   20 +
>  drivers/net/can/usb/Makefile        |   12 +
>  drivers/net/can/usb/pcan_usb.c      |  654 +++++++++++++++++++
>  drivers/net/can/usb/pcan_usb_core.c |  895 ++++++++++++++++++++++++++
>  drivers/net/can/usb/pcan_usb_pro.c  | 1207 +++++++++++++++++++++++++++++++++++
>  drivers/net/can/usb/pcan_usb_pro.h  |  468 ++++++++++++++
>  drivers/net/can/usb/peak_usb.h      |  148 +++++
>  7 files changed, 3404 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/net/can/usb/pcan_usb.c
>  create mode 100644 drivers/net/can/usb/pcan_usb_core.c
>  create mode 100644 drivers/net/can/usb/pcan_usb_pro.c
>  create mode 100644 drivers/net/can/usb/pcan_usb_pro.h
>  create mode 100644 drivers/net/can/usb/peak_usb.h
> 
....

> +++ b/drivers/net/can/usb/pcan_usb_pro.h
> @@ -0,0 +1,468 @@
> +/*
> + * CAN driver for PEAK System PCAN-USB-PRO adapter
> + *
> + * Copyright (C) 2011-2012 PEAK-System GmbH
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
> + */
> +#ifndef __pcan_usb_pro_h__
> +#define __pcan_usb_pro_h__
> +
> +/* 
> + * USB Vendor Request Data Types
> + */
> +
> +/* Vendor (other) request */
> +#define USB_VENDOR_REQUEST_INFO                   0
> +#define USB_VENDOR_REQUEST_ZERO                   1
> +#define USB_VENDOR_REQUEST_FKT                    2

Looks like emums to me, here and in many other places (because used in
switch statements).

> +/* Vendor Request wValue for XXX_INFO */
> +#define USB_VENDOR_REQUEST_wVALUE_INFO_BOOTLOADER  0
> +#define USB_VENDOR_REQUEST_wVALUE_INFO_FIRMWARE    1
> +#define USB_VENDOR_REQUEST_wVALUE_INFO_uC_CHIPID   2

Please use upper case.

http://lxr.linux.no/#linux+v3.1.5/Documentation/CodingStyle#L590

> +#define USB_VENDOR_REQUEST_wVALUE_INFO_USB_CHIPID  3
> +#define USB_VENDOR_REQUEST_wVALUE_INFO_DEVICENR	   4	
> +#define USB_VENDOR_REQUEST_wVALUE_INFO_CPLD        5
> +#define USB_VENDOR_REQUEST_wVALUE_INFO_MODE			6	
> +#define USB_VENDOR_REQUEST_wVALUE_INFO_TIMEMODE		7

Please, no hungarian notation in Linux code please. See:

http://lxr.linux.no/#linux+v3.1.5/Documentation/CodingStyle#L252

> +/* Vendor Request wValue for XXX_ZERO */
> +/* Value is Endpoint Number 0-7 */
> +
> +/* Vendor Request wValue for XXX_FKT */
> +#define USB_VENDOR_REQUEST_wVALUE_SETFKT_BOOT       0 // set Bootloader Mode
> +#define USB_VENDOR_REQUEST_wVALUE_SETFKT_DEBUG_CAN  1 // not used
> +#define USB_VENDOR_REQUEST_wVALUE_SETFKT_DEBUG_LIN  2 // not used
> +#define USB_VENDOR_REQUEST_wVALUE_SETFKT_DEBUG1     3 // not used
> +#define USB_VENDOR_REQUEST_wVALUE_SETFKT_DEBUG2     4 // not used
> +#define USB_VENDOR_REQUEST_wVALUE_SETFKT_INTERFACE_DRIVER_LOADED 5

Ditto...

> +/* ctrl_type value */
> +#define INTERN_FIRMWARE_INFO_STRUCT_TYPE 	0x11223322
> +#define EXT_FIRMWARE_INFO_STRUCT_TYPE 		0x11223344
> +
> +#define BOOTLOADER_INFO_STRUCT_TYPE 		0x11112222
> +#define uC_CHIPID_STRUCT_TYPE 				0
> +#define USB_CHIPID_STRUCT_TYPE 				0
> +#define DEVICE_NR_STRUCT_TYPE 				0x3738393A
> +#define CPLD_INFO_STRUCT_TYPE 				0x1A1A2277
> +
> +/* USB_VENDOR_REQUEST_wVALUE_INFO_BOOTLOADER vendor request record type */
> +struct __packed pcan_usb_pro_bootloader_info_t
> +{
> +	u32 ctrl_type;
> +	u8  version[4];		//[0] -> main [1]-> sub [2]-> debug
> +	u8  day;
> +	u8  month;
> +	u8  year;
> +	u8  dummy;
> +	u32 serial_num_high;
> +	u32 serial_num_low;
> +	u32 hw_type;
> +	u32 hw_rev;
> +};
> +
> +struct __packed pcan_usb_pro_crc_block_t
> +{
> +	u32 address;
> +	u32 len;
> +	u32 crc;
> +};
> +
> +/* USB_VENDOR_REQUEST_wVALUE_INFO_FIRMWARE vendor request record type */
> +struct __packed pcan_usb_pro_ext_firmware_info_t
> +{
> +	u32 ctrl_type;
> +	u8	 version[4];		//[0] -> main [1]-> sub [2]-> debug
> +	u8  day;
> +	u8  month;
> +	u8  year;
> +	u8  dummy;
> +	u32 fw_type;
> +};

Could you explain the rational behind the prefix
USB_VENDOR_REQUEST_wVALUE_INFO. Why does the struct use a different
prefix. I think this is some remainder from old Windoze code using
hungarian notation!?

> +/* USB_VENDOR_REQUEST_wVALUE_INFO_uC_CHIPID vendor request record type */
> +struct __packed pcan_usb_pro_uc_chipid_t
> +{
> +	u32 ctrl_type;
> +	u32 chip_id;
> +};

Ditto here and in many other places.

> +/* 
> + * USB Command Record types 
> + */
> +
> +#define DATA_TYPE_USB2CAN_STRUCT_CANMSG_RX_8                0x80
> +#define DATA_TYPE_USB2CAN_STRUCT_CANMSG_RX_4                0x81
> +#define DATA_TYPE_USB2CAN_STRUCT_CANMSG_RX_0                0x82
> +#define DATA_TYPE_USB2CAN_STRUCT_CANMSG_RTR_RX              0x83
> +#define DATA_TYPE_USB2CAN_STRUCT_CANMSG_STATUS_ERROR_RX     0x84
> +#define DATA_TYPE_USB2CAN_STRUCT_CALIBRATION_TIMESTAMP_RX   0x85
> +#define DATA_TYPE_USB2CAN_STRUCT_BUSLAST_RX                 0x86
> +#define DATA_TYPE_USB2CAN_STRUCT_CANMSG_TX_8                0x41
> +#define DATA_TYPE_USB2CAN_STRUCT_CANMSG_TX_4                0x42
> +#define DATA_TYPE_USB2CAN_STRUCT_CANMSG_TX_0                0x43
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_GETBAUDRATE            0x01 
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETBAUDRATE            0x02
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_GETCANBUSACTIVATE      0x03
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETCANBUSACTIVATE      0x04
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETSILENTMODE          0x05 
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETDEVICENR            0x06 
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETWARNINGLIMIT        0x07 
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETLOOKUP_EXPLICIT     0x08 
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETLOOKUP_GROUP        0x09 
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETFILTERMODE          0x0a 
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETRESET_MODE          0x0b 
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETERRORFRAME          0x0c 
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_GETCANBUS_ERROR_STATUS 0x0D 
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETREGISTER            0x0e 
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_GETREGISTER            0x0f 
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETGET_CALIBRATION_MSG 0x10 
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETGET_BUSLAST_MSG     0x11 
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_GETDEVICENR            0x12 
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_SETSTRING              0x13 
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_GETSTRING              0x14 
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_STRING                 0x15
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_SAVEEEPROM             0x16
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_USB_IN_PACKET_DELAY    0x17
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_TIMESTAMP_PARAM        0x18
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_ERROR_GEN_ID           0x19
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_ERROR_GEN_NOW          0x1A
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_SET_SOFTFILER          0x1B
> +#define DATA_TYPE_USB2CAN_STRUCT_FKT_SET_CANLED             0x1C

Ditto, why is the prefix "DATA_TYPE_USB2CAN_STRUCT_FKT"? Please use
logical and consistent prefixes. I will make the code more readable.

Wolfgang.
