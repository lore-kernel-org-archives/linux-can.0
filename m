From: "Kvaser Support" <support@kvaser.com>
Subject: Re: (Case 14383) SocketCAN Supported Controllers information updates
Date: Mon, 28 Apr 2014 02:25:02 +0200
Message-ID: <535d9fde.0943e00a.55bb.ffffbdbd@mx.google.com>
References: <535AC7B0.3020101@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:49072 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbaD1AZF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 27 Apr 2014 20:25:05 -0400
Received: by mail-qg0-f48.google.com with SMTP id q108so6157532qgd.21
        for <linux-can@vger.kernel.org>; Sun, 27 Apr 2014 17:25:03 -0700 (PDT)
In-Reply-To: <535AC7B0.3020101@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Yegor Yefremov <yegorslists@googlemail.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Olivier Sobrie <olivier@sobrie.be>

Looks good.  Thanks for updating this information.  I will let you know when we have our FAQ page up so you can comment.

Best regards,

Troy
-- 
Kvaser Support
support@kvaser.com
---------------------------------------------------------------------------



-----Original Message-----
From: "Oliver Hartkopp" <socketcan@hartkopp.net>
Reply-To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Date: Fri, 25 Apr 2014 22:38:08 +0200
To: "Kvaser Support" <support@kvaser.com>
Cc: "Yegor Yefremov" <yegorslists@googlemail.com>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "Olivier Sobrie" <olivier@sobrie.be>
Subject: SocketCAN Supported Controllers information updates

>Hello Troy,
>
>I just added the USB based drivers for Kvaser and PEAK.
>
>This is a pretty boring and laborious work ... e.g. to retrieve the
>information from product websites (URLs) or the Linux version.
>
>Please check if
>
>http://elinux.org/CAN_Bus#SocketCAN_Supported_Controllers
>
>looks ok from the Kvaser side.
>
>When not all of you want to have a wiki account, you may send the wiki code
>lines for integration into the wiki on this list, so that Yegor or me can
>just copy/paste the line into the wiki.
>
>E.g. for the Kvaser USB this was:
>
>|[http://www.kvaser.com/ Kvaser] || [http://www.kvaser.com/products-services/our-products/ Leaf] || kvaser_usb || (unknown) || CONFIG_CAN_KVASER_USB || 3.8 || supports USB Leaf / Memorator / Blackbird / R (see detailed USB device IDs in kvaser_usb.c)
>
>Best regards,
>Oliver
>
>On 25.04.2014 00:12, Kvaser Support wrote:
>> Looks great!
>> 
>> Just missing Kvaser from the list.  Do you need anything from me to add Kvaser to the table?  Web page links?
>> 
>> Best regards,
>> 
>> Troy
>>
