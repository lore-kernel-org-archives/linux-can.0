From: Bernd Krumboeck <krumboeck@universalnet.at>
Subject: Re: usb_8dev: USB Protocoll available?
Date: Sat, 15 Dec 2012 07:31:13 +0100
Message-ID: <50CC1931.9080608@universalnet.at>
References: <20683.22879.172661.430971@elektron.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:45951 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750783Ab2LOGcw (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sat, 15 Dec 2012 01:32:52 -0500
In-Reply-To: <20683.22879.172661.430971@elektron.ikp.physik.tu-darmstadt.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Cc: linux-can@vger.kernel.org

Error handling:

Error occured when frame type = 3 and ERR_FLAG = 0x04.

   Error message:
     byte 0: Status
     byte 1: bit   7: Receive Passive
     byte 1: bit 0-6: Receive Error Counter
     byte 2: Transmit Error Counter
     byte 3: Always 0 (maybe reserved for future use)

     (byte 1-2 seems to be the value from CAN->ERR register in the microcontroller)

   driver source:
     u8 state = msg->data[0];
     u8 rxerr = msg->data[1] & 0x7F;
     u8 txerr = msg->data[2];

   Status:
     OK           0x00  /* Normal condition. */
     OVERRUN      0x01  /* Overrun occured when sending */
     BUSLIGHT     0x02  /* Error counter has reached 96 */
     BUSHEAVY     0x03  /* Error count. has reached 128 */
     BUSOFF       0x04  /* Device is in BUSOFF */
     STUFF        0x20  /* Stuff Error */
     FORM         0x21  /* Form Error */
     ACK          0x23  /* Ack Error */
     BIT0         0x24  /* Bit1 Error */
     BIT1         0x25  /* Bit0 Error */
     CRC          0x26  /* CRC Error */



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

