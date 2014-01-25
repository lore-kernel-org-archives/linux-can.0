From: Bernd Krumboeck <krumboeck@universalnet.at>
Subject: Re: usb_8dev: firmware and windows library
Date: Sat, 25 Jan 2014 08:04:40 +0100
Message-ID: <52E36208.3020100@universalnet.at>
References: <f5902be125a3dd5ead00d75e01a45fa5.squirrel@webmail.universalnet.at> <52DE5EEF.6080100@hartkopp.net> <52DE60C7.3050906@8devices.com> <52DFC08C.2040400@universalnet.at> <52DFD9B7.40300@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp.xy24.at ([85.126.109.136]:55447 "EHLO renate.xy24.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750889AbaAYHFR (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sat, 25 Jan 2014 02:05:17 -0500
In-Reply-To: <52DFD9B7.40300@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Gediminas Simanskis <gediminas@8devices.com>, linux-can@vger.kernel.org

Hi!


Source code from firmware v1.5: https://github.com/krumboeck/usb2can_firmware


After some experiments I was able to flash the firmware with dfu-util under linux:
https://github.com/krumboeck/usb2can_firmware#flash-the-device-linux-experimental


Sadly I don't know the way how to build the firmware with a free tools chain.


regards,
Bernd


Am 2014-01-22 15:46, schrieb Marc Kleine-Budde:
> On 01/22/2014 01:58 PM, Bernd Krumboeck wrote:
>> May I kindly ask you to send me a diff/patch about the changes, so I can
>> update the firmware sources on github.
>
> A complete new set of sources will do, too. Git will create the diff for
> you. :)
>
> Marc
>

