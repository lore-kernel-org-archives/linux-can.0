From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: CAN libpcap capture endianess
Date: Wed, 11 Sep 2013 21:22:01 +0200
Message-ID: <5230C2D9.6040502@hartkopp.net>
References: <1378920814-sup-4559@pruts.nl> <5230B4C9.4070904@pengutronix.de> <1378923967-sup-6565@pruts.nl> <5230B897.7020807@pengutronix.de> <1378925552-sup-4997@pruts.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:32625 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754833Ab3IKTWE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Sep 2013 15:22:04 -0400
In-Reply-To: <1378925552-sup-4997@pruts.nl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ico Doornekamp <can@zevv.nl>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>

On 11.09.2013 20:53, Ico Doornekamp wrote:
> * On 2013-09-11 20:38:15 +0200, Marc Kleine-Budde wrote:
>  
>>>> Does the command line tool candump show proper frames?
>>>
>>> I'll have to look into that tomorrow, at this time I only have access to
>>> the capture file I made earlier.
>>
>> What kind of CAN hardware are you using? Maybe it's not compatible with
>> the existing driver.
> 
> I'm using the CANUSB device from can232.com:
> 
> http://www.can232.com/?page_id=16
> 

I do have this hardware at work.

And the slcan driver was originally implemented for this hardware.

I have to look, if i can find a Debian amd64 system for testing.
Usually our Laptops are i386 (32 bit) installations.

Best regards,
Oliver

