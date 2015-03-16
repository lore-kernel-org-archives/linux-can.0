From: Matthias Fuchs <matthias.fuchs@esd.eu>
Subject: Re: esd_usb2: endianess warning
Date: Mon, 16 Mar 2015 08:14:44 +0100
Message-ID: <550682E4.8090901@esd.eu>
References: <550446A5.80702@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mxu02.htp-tel.de ([81.14.242.9]:50518 "EHLO mxuout02.htp-tel.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950AbbCPHhh (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 16 Mar 2015 03:37:37 -0400
In-Reply-To: <550446A5.80702@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, =?UTF-8?B?VGhvbWFzIEvDtnJwZXI=?= <thomas.koerper@esd.eu>

Marc,

Thomas will care about maintainership of this driver from now on.
He will post a patch soon.

Matthias

On 14.03.2015 15:33, Marc Kleine-Budde wrote:
> Hello,
>
> when compiling with sparse (make C=2), the esd driver throws the
> following warning, can someone, preferred the driver author :), take
> care of fixing them?
>
>> drivers/net/can/usb/esd_usb2.c:369:53: warning: restricted __le32 degrades to integer
>> drivers/net/can/usb/esd_usb2.c:791:25: warning: incorrect type in assignment (different base types)
>> drivers/net/can/usb/esd_usb2.c:791:25:    expected restricted __le32 [usertype] hnd
>> drivers/net/can/usb/esd_usb2.c:791:25:    got unsigned int
>
> regards,
> Marc
>
