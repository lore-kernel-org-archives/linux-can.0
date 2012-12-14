From: Bernd Krumboeck <krumboeck@universalnet.at>
Subject: Re: usb_8dev: USB Protocoll available?
Date: Fri, 14 Dec 2012 20:25:55 +0100
Message-ID: <50CB7D43.8020703@universalnet.at>
References: <20683.22879.172661.430971@elektron.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:44118 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932133Ab2LNT1f (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 14 Dec 2012 14:27:35 -0500
In-Reply-To: <20683.22879.172661.430971@elektron.ikp.physik.tu-darmstadt.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Cc: linux-can@vger.kernel.org

Hi!


Sorry, there is no document at the moment. The mentioned github projects are not related.


But I'll try to explain the protocol:

The controller use big endian for all values.

/* urb endpoints */
enum usb_8dev_endpoint {
         USB_8DEV_ENDP_DATA_RX = 1,
         USB_8DEV_ENDP_DATA_TX,
         USB_8DEV_ENDP_CMD_RX,
         USB_8DEV_ENDP_CMD_TX
};

-------------------------------------------------------------------------

The command frame for endpoint 3 and 4:
struct __packed usb_8dev_cmd_msg {
         u8 begin;       /* always 0x11 */
         u8 channel;     /* unkown - always 0 */
         u8 command;     /* command to execute */
         u8 opt1;        /* optional parameter / return value */
         u8 opt2;        /* optional parameter 2 */
         u8 data[10];    /* optional parameter and data */
         u8 end;         /* always 0x22 */
};


After executing a command the return value (opt1) will be set to 0 (= success) or 255 (= error).


/* available commands */
enum usb_8dev_cmd {
         USB_8DEV_RESET = 1,
         USB_8DEV_OPEN,
         USB_8DEV_CLOSE,
         USB_8DEV_SET_SPEED,
         USB_8DEV_SET_MASK_FILTER,
         USB_8DEV_GET_STATUS,
         USB_8DEV_GET_STATISTICS,
         USB_8DEV_GET_SERIAL,
         USB_8DEV_GET_SOFTW_VER,
         USB_8DEV_GET_HARDW_VER,
         USB_8DEV_RESET_TIMESTAMP,
         USB_8DEV_GET_SOFTW_HARDW_VER
};


Command RESET:
   Reset the microcontroller on the board.
   Not used by the driver.

Command OPEN:
   Open can bus

   outmsg.command = USB_8DEV_OPEN
   outmsg.opt1 = USB_8DEV_BAUD_MANUAL
   outmsg.data[0] = prop_seg + phase_seg1
   outmsg.data[1] = phase_seg2
   outmsg.data[2] = sjw
   outmsg.data[3-4] = brp
   outmsg.data[5-8] = flags

   opt1:
     1000 kb/s  - 0x00
     800 kb/s   - 0x01
     500 kb/s   - 0x02
     250 kb/s   - 0x03
     125 kb/s   - 0x04
     100 kb/s   - 0x05
     50 kb/s    - 0x06
     20 kb/s    - 0x07
     10 kb/s    - 0x08
     manual     - 0x09

   flags:
     SILENT                        0x01
     LOOPBACK                      0x02
     DISABLE_AUTO_RESTRANSMISSION  0x04
     STATUS_FRAME                  0x08

Command CLOSE:
   Close can bus

Command SET_SPEED:
   Set can bus speed.
   Same parameters like open command, but without flags.
   Not fully implemented by the firmware.
   Is not used by the driver.

Command SET_MASK_FILTER:
   Not fully implemented by the firmware.
   Is not used by the driver.

Command GET_STATUS:

   Return value in data[0-3]:
   STATUS_NONE      0x00000000
   STATUS_BUS_OFF   0x80000000
   STATUS_PASSIVE   0x40000000
   STATUS_BUS_WARN  0x20000000
   STATUS_ACTIVE    0x10000000
   STATUS_PHY_FAULT 0x08000000
   STATUS_PHY_H     0x04000000
   STATUS_PHY_L     0x02000000
   STATUS_SLEEPING  0x01000000
   STATUS_STOPPED   0x00800000

   Is not used by the driver.

Command GET_STATISTICS:

   Value in opt1 selects statistic:
   RX_FRAMES  0
   RX_BYTES   1
   TX_FRAMES  2
   TX_BYTES   3
   OVERRUNS   4
   WARNINGS   5
   BUS_OFF    6
   RESET_STAT 7  /* will set all stats to 0 */

   Return value in data[0-3]

   Is not used by the driver.

Command GET_SERIAL:
   Return value in data[0-7]
   Same value as in iSerial (lsusb -v)

   Is not used by the driver.

Command GET_SOFTW_VER:
   Firmware version:
   Return value in data[0-1]

   Is not used by the driver.

Command GET_HARDW_VER:
   Hardware version:
   Return value in data[0-1]

   Is not used by the driver.

Command RESET_TIMESTAMP:
   Resets the timestamp for rx can frame

   Is not used by the driver.

Command GET_SOFTW_HARDW_VER:
   Firmware version:
     Return value in data[0-1]

   Hardware version:
     Return value in data[2-3]


-------------------------------------------------------------------------

Sending can frames (endpoint 2):

struct __packed usb_8dev_tx_msg {
         u8 begin;       /* alway 0x55 */
         u8 flags;       /* RTR and EXT_ID flag */
         __be32 id;      /* upper 3 bits not used */
         u8 dlc;         /* data length code 0-8 bytes */
         u8 data[8];     /* 64-bit data */
         u8 end;         /* alway 0xAA */
};

Flags:
   EXTID           0x01
   RTR             0x02


-------------------------------------------------------------------------

Receiving can frames (endpoint 1):

struct __packed usb_8dev_rx_msg {
         u8 begin;               /* alway 0x55 */
         u8 type;                /* frame type */
         u8 flags;               /* RTR and EXT_ID flag */
         __be32 id;              /* upper 3 bits not used */
         u8 dlc;                 /* data length code 0-8 bytes */
         u8 data[8];             /* 64-bit data */
         __be32 timestamp;       /* 32-bit timestamp */
         u8 end;                 /* alway 0xAA */
};


frame type:
   CAN_FRAME         0
   STATUS_FRAME      3 (always set ERR_FLAG)

flags:
   EXTID           0x01
   RTR             0x02
   ERR_FLAG        0x04

timestamp:
   I don't know which format is used, but I assume its simple a register value from the microcontroller

   Is not used by the driver (but may change later).



regards,
Bernd



Am 2012-12-14 17:52, schrieb Uwe Bonnes:
>
> Hello,
>
> is there some document describing the protocoll used for the usb_8dev? I
> have STM32 hardware with USB and CAN connected and think about writing some
> firmware compatible with some existing adapter.
>
> Otherwise, are the github projects
>
> saeugetier / usb2can
>
> shackspace / usb2can
>
> for usb to can hardware related to this driver??
>
> Thanks
>

