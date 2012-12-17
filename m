From: Bernd Krumboeck <krumboeck@universalnet.at>
Subject: Re: USB CAN Scripts - was Re: usb_8dev: USB Protocoll available?
Date: Mon, 17 Dec 2012 09:06:10 +0100
Message-ID: <50CED272.2050902@universalnet.at>
References: <20683.22879.172661.430971@elektron.ikp.physik.tu-darmstadt.de> <50CC2226.10107@universalnet.at> <50CDFCA8.6000409@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:50108 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750813Ab2LQHGp (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 17 Dec 2012 02:06:45 -0500
In-Reply-To: <50CDFCA8.6000409@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Kurt Van Dijck <kurt.van.dijck@eia.be>, Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org

Hello Oliver!

Am 2012-12-16 17:54, schrieb Oliver Hartkopp:
>
> ... there's a serial number "ED000202" available.
>
> Maybe we should discuss about having that kind of unique identifier available
> in the sysfs (as we do not have a MAC address like USB ethernet adapters) for
> udev scripts as discussed above.

Simply a great idea. :-)

Some questions:
* How should it look like? ("<vendorId><productId><serial><...>")
* What should we do if the device does not have any useful number? (A PCI device can simply use the slot-id. USB???)
* How a driver should set the address? (priv->can.addr?)


regards,
Bernd
