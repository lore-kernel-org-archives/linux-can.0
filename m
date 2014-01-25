From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: usb_8dev: firmware and windows library
Date: Sat, 25 Jan 2014 12:45:04 +0100
Message-ID: <52E3A3C0.40602@hartkopp.net>
References: <f5902be125a3dd5ead00d75e01a45fa5.squirrel@webmail.universalnet.at> <52DE5EEF.6080100@hartkopp.net> <52DE60C7.3050906@8devices.com> <52DFC08C.2040400@universalnet.at> <52DFD9B7.40300@pengutronix.de> <52E36208.3020100@universalnet.at> <52E39A49.10205@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:53984 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbaAYLpH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 25 Jan 2014 06:45:07 -0500
In-Reply-To: <52E39A49.10205@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Bernd Krumboeck <krumboeck@universalnet.at>
Cc: linux-can@vger.kernel.org

Using a stock debian kernel 3.12-1-686-pae it just worked fine.
Maybe it had something to do with my system upgrade I did at the same time.

So no issue here - sorry for the noise.

Tnx,
Oliver

On 25.01.2014 12:04, Oliver Hartkopp wrote:

> Btw. I was not able to update my adapter because it fails at different
> percentages of the download - see below. I'll try with another usblib or
> another Linux box.

(..)

> parsing element 1, address = 0x20006000, size = 24576
> Download	[=========                ]  37%         9216 bytesdfu-util: dfuse_download: libusb_control_transfer returned -9
> # _

