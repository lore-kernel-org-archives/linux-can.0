From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v9] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Fri, 18 Jan 2013 20:55:45 +0100
Message-ID: <50F9A8C1.9020907@hartkopp.net>
References: <1355641315-15739-1-git-send-email-krumboeck@universalnet.at>    <50F471AC.50902@hartkopp.net> <9efedd49790bb8df2952bf599424f9f9.squirrel@webmail.universalnet.at> <50F86A1E.8010606@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:31689 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915Ab3ARTzr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 18 Jan 2013 14:55:47 -0500
In-Reply-To: <50F86A1E.8010606@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Bernd_Krumb=F6ck?= <krumboeck@universalnet.at>
Cc: linux-can@vger.kernel.org, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

On 17.01.2013 22:16, Oliver Hartkopp wrote:

> 
> I forgot to check the other USB CAN adapters for comparison.
> Will do tomorrow.
> 


Here are the results when un-plugging PEAK USB at CAN load:

(..)

[  862.607999] peak_usb 2-1.2:1.0 can2: Rx urb aborted (-32)
[  862.828276] usb 2-1.2: USB disconnect, device number 8
[  862.866386] peak_usb 2-1.2:1.0: can2 removed

So it's pretty much the same that the URB fail messages appear.

Regards,
Oliver
