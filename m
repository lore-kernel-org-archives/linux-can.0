From: "krumboeck@universalnet.at" <krumboeck@universalnet.at>
Subject: Re: [PATCH] usb2can: Add support for USB2CAN interface from 8 devices
Date: Mon, 03 Dec 2012 21:41:28 +0100
Message-ID: <50BD0E78.7030204@universalnet.at>
References: <50BB1E8E.10809@universalnet.at> <50BB592B.4030604@grandegger.com> <50BBF5CA.500@universalnet.at> <50BC540C.4040800@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:53014 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751880Ab2LCTln (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 3 Dec 2012 14:41:43 -0500
In-Reply-To: <50BC540C.4040800@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-usb@vger.kernel.org, linux-can@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

Hi Wolfgang!


>> The Script checkpatch.pl didn't like this comment style. I'll change it
>> again.
>
> I'm confused. Could you please show the comment and the checkpatch.pl
> message. I hope it does not argue against:
>
> http://lxr.linux.no/#linux+v3.6.8/Documentation/CodingStyle#L446

...
/*
  * Send command to device and receive result.
  * Command was successful when opt1 = 0.
  */
static int usb_8dev_send_cmd(struct usb_8dev *dev, struct usb_8dev_cmd_msg *out,
                             struct usb_8dev_cmd_msg *in)
{
...

WARNING: networking block comments don't use an empty /* line, use /* Comment...
#248: FILE: drivers/net/can/usb/usb_8dev.c:204:
+
+/*

...
/*
  * Set network device mode
  *
  * Maybe we should leave this function empty, because the device
  * set mode variable with open command.
  */
static int usb_8dev_set_mode(struct net_device *netdev, enum can_mode mode)
{
         struct usb_8dev *dev = netdev_priv(netdev);
...

WARNING: networking block comments don't use an empty /* line, use /* Comment...
#413: FILE: drivers/net/can/usb/usb_8dev.c:369:
+
+/*


regards,
Bernd
