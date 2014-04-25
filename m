From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: SocketCAN Supported Controllers information updates
Date: Fri, 25 Apr 2014 22:38:08 +0200
Message-ID: <535AC7B0.3020101@hartkopp.net>
References: <CAGm1_ks9yquF-=grW5maVZx3-FS+2xRMYvbwX7RhuYkBErxeRw@mail.gmail.com> <53598c53.02608c0a.aea0.4bbe@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:29595 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbaDYUiN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Apr 2014 16:38:13 -0400
In-Reply-To: <53598c53.02608c0a.aea0.4bbe@mx.google.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kvaser Support <support@kvaser.com>, Yegor Yefremov <yegorslists@googlemail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Olivier Sobrie <olivier@sobrie.be>

Hello Troy,

I just added the USB based drivers for Kvaser and PEAK.

This is a pretty boring and laborious work ... e.g. to retrieve the
information from product websites (URLs) or the Linux version.

Please check if
 
	http://elinux.org/CAN_Bus#SocketCAN_Supported_Controllers

looks ok from the Kvaser side.

When not all of you want to have a wiki account, you may send the wiki code
lines for integration into the wiki on this list, so that Yegor or me can
just copy/paste the line into the wiki.

E.g. for the Kvaser USB this was:

|[http://www.kvaser.com/ Kvaser] || [http://www.kvaser.com/products-services/our-products/ Leaf] || kvaser_usb || (unknown) || CONFIG_CAN_KVASER_USB || 3.8 || supports USB Leaf / Memorator / Blackbird / R (see detailed USB device IDs in kvaser_usb.c)

Best regards,
Oliver


On 25.04.2014 00:12, Kvaser Support wrote:
> Looks great!
> 
> Just missing Kvaser from the list.  Do you need anything from me to add Kvaser to the table?  Web page links?
> 
> Best regards,
> 
> Troy
> 
