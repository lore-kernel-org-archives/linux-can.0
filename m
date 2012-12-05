From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: [PATCH v4] usb_8dev: Add support for USB2CAN interface from 8
 devices
Date: Wed, 05 Dec 2012 16:49:25 +0100
Message-ID: <50BF6D05.4070609@volkswagen.de>
References: <50BE7C7E.8080406@universalnet.at> <50BF1E58.4090603@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr1.volkswagen.de ([194.114.62.75]:53918 "EHLO
	mr1.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab2LEPtf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Dec 2012 10:49:35 -0500
In-Reply-To: <50BF1E58.4090603@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Bernd Krumboeck <krumboeck@universalnet.at>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, linux-usb@vger.kernel.org, info@gerhard-bertelsmann.de, gediminas@8devices.com

On 05.12.2012 11:13, Wolfgang Grandegger wrote:

>> +    outmsg.command = USB_8DEV_OPEN;
>> +    outmsg.opt1 = USB_8DEV_BAUD_MANUAL;
>> +    outmsg.data[0] = (bt->prop_seg + bt->phase_seg1);
>
> Minor issue. Brackets not needed.
>
>> +    outmsg.data[1] = bt->phase_seg2;
>> +    outmsg.data[2] = bt->sjw;
>> +

That's correct from a compilers point of view.
But in this case i would preserve the [0] as it is better to read in 
conjunction with the two lines below ( ..[1] ..[2] )

The semantic has to be understood by humans ;-)

Regards,
Oliver

