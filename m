From: =?iso-8859-1?Q?=22Bernd_Krumb=F6ck=22?= <krumboeck@universalnet.at>
Subject: Re: [PATCH v7] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Fri, 14 Dec 2012 19:22:53 +0100
Message-ID: <95c24a1d2b44b779fc4022a4f5ea6961.squirrel@webmail.universalnet.at>
References: <1355424053-608-1-git-send-email-krumboeck@universalnet.at>
    <50CB148F.7030002@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:46267 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756652Ab2LNSXI (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 14 Dec 2012 13:23:08 -0500
In-Reply-To: <50CB148F.7030002@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Bernd Krumboeck <b.krumboeck@gmail.com>, linux-can@vger.kernel.org, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com, Bernd Krumboeck <krumboeck@universalnet.at>

Hello Marc!

> Looks good to me. Minor style issue inline. Please provide a
> documentation for the sysfs entries and place it under:
> Documentation/ABI/testing/sysfs-platform.

Should I change the sysfs path to /sys/devices/platform/usb_8dev? At the
moment the path is /sys/bus/usb/devices/<busnum>:<devnum>.

regards,
Bernd

