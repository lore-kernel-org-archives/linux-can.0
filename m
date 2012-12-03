From: "krumboeck@universalnet.at" <krumboeck@universalnet.at>
Subject: Re: [PATCH] usb2can: Add support for USB2CAN interface from 8 devices
Date: Mon, 03 Dec 2012 01:43:54 +0100
Message-ID: <50BBF5CA.500@universalnet.at>
References: <50BB1E8E.10809@universalnet.at> <50BB592B.4030604@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:56745 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753572Ab2LBXoJ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 2 Dec 2012 18:44:09 -0500
In-Reply-To: <50BB592B.4030604@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

Am 2012-12-02 14:35, schrieb Wolfgang Grandegger:
> Hi Bernd,
>
> nice to see this driver being pushed mainline. As Oliver already pointed
> out, there are a few general naming and coding style issues:
>
> - The preferred multi line comment styles is:
>
>    /*
>     * A Comment
>     */

The Script checkpatch.pl didn't like this comment style. I'll change it again.

>
> - The patch does not yet apply to David Millers "net-next" GIT tree.
>    There are problems with Kconfig and Makefile.

I assume this is the right command and repository url:
git clone "http://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git"

>
> Could you please show the output of "candump -e any,0:0,#FFFFFFFF" when
> the device goes 1) error passive and 2) bus-off. You could provoke
> these states by 1) sending without connection to the bus or 2)
> short-circuiting CAN high and low.

bek@debian:~/software/socketcan/trunk/can-utils$ ./candump -e any,0:0,#FFFFFFFF
   can0  20000088  [8] 00 00 04 00 00 00 00 01   ERRORFRAME
         protocol-violation{{bit-stuffing-error}{}}
         bus-error
         error-counter-tx-rx{{0}{1}}
   can0  2000008C  [8] 00 04 00 00 00 00 00 63   ERRORFRAME
         controller-problem{rx-error-warning}
         protocol-violation{{}{}}
         bus-error
         error-counter-tx-rx{{0}{99}}
   can0  2000008C  [8] 00 10 00 00 00 00 00 7F   ERRORFRAME
         controller-problem{rx-error-passive}
         protocol-violation{{}{}}
         bus-error
         error-counter-tx-rx{{0}{127}}
   can0  500  [4] 00 01 02 03
   can0  500  [4] 00 01 02 03
   can0  500  [4] 00 01 02 03
   can0  500  [4] 00 01 02 03
   can0  500  [4] 00 01 02 03
   can0  500  [4] 00 01 02 03
   can0  500  [4] 00 01 02 03


In my tests I was not able to provoke "bus-off".


One of the tests from Gerd provoked "bus-off":
   can0  12345678  [8] 55 55 55 55 33 33 33 33
   can0  20000088  [8] 00 00 90 00 00 00 10 00   ERRORFRAME
   can0  2000008C  [8] 00 08 00 00 00 00 68 00   ERRORFRAME
   can0  2000008C  [8] 00 20 00 00 00 00 88 00   ERRORFRAME
   can0  20000040  [8] 00 00 00 00 00 00 F8 00   ERRORFRAME



> Another question: is it possible to switch off bus-error reporting?

No. At least I didn't found anything in the firmware.


>> +
>> +/* Send data to device */
>> +static netdev_tx_t usb2can_start_xmit(struct sk_buff *skb,
>> +                      struct net_device *netdev)
>> +{
>> +    struct usb2can *dev = netdev_priv(netdev);
>> +    struct net_device_stats *stats = &netdev->stats;
>> +    struct can_frame *cf = (struct can_frame *)skb->data;
>
> Is the cast needed?

Yes.

>
> The driver does collect similar statistics and therefore I do not see a
> need for these sysfs files... apart from printing the firmware version
> when the device is probed. BTW: what is "show_hardware" good for?
>

I don't exactly know, but I assume it is the hardware revision.


best regards,
Bernd

