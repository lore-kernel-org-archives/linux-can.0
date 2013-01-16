From: =?iso-8859-1?Q?=22Bernd_Krumb=F6ck=22?= <krumboeck@universalnet.at>
Subject: Re: [PATCH v9] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Wed, 16 Jan 2013 09:07:05 +0100
Message-ID: <9efedd49790bb8df2952bf599424f9f9.squirrel@webmail.universalnet.at>
References: <1355641315-15739-1-git-send-email-krumboeck@universalnet.at>
    <50F471AC.50902@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:54260 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754153Ab3APIHI (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 16 Jan 2013 03:07:08 -0500
In-Reply-To: <50F471AC.50902@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

Hi Oliver!

> When detaching the device from the CAN bus when sending/receiving CAN
> traffic
> i got these dmesg infos:
>
> [  960.047130] usb_8dev 2-1.4:1.0 can2: Unknown status/error message (0)
> [  976.544343] usb_8dev 2-1.4:1.0 can2: Unknown status/error message (0)
>

Sorry, I can't do this sort of tests myself, because my second can device
is an expensive device, without developer/test mode. ;-)

Gerd helped me with the can tests so far. (Thank you!)

The messages you see mean "Normal condition" and shouldn't be displayed.
I'll fix them in the next version.

regards,
Bernd

