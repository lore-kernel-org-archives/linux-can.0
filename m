From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH] can: add tx/rx led trigger support
Date: Thu, 12 Apr 2012 18:02:06 +0200
Message-ID: <4F86FC7E.5030709@hartkopp.net>
References: <1334093965-2692-1-git-send-email-fabio.baltieri@gmail.com>	<4F852161.90706@hartkopp.net>	<CABkP77eNeTTwSxtKyfUmr7OC4H1nXEN4EeFH7pdR6=BcpKuE6w@mail.gmail.com>	<4F85D553.2010303@hartkopp.net> <CABkP77eHcrOSG140HF++D9Gt=79gVgGZm5JX6ZVNuc4pjpujcA@mail.gmail.com> <4F86862C.5020007@grandegger.com> <4F86B75C.2040006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:10703 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932965Ab2DLQCI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Apr 2012 12:02:08 -0400
In-Reply-To: <4F86B75C.2040006@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Martin Gysel <m.gysel@gmail.com>
Cc: linux-can@vger.kernel.org

On 12.04.2012 13:07, Martin Gysel wrote:

> Am 12.04.2012 09:37, schrieb Wolfgang Grandegger:
>> Concerning the LED control (on. off, blinking), could that not be
>> done/configured in the generic LED interface (via sysfs files)? That
>> seems the right place for me. Then the CAN LED software just needs to
>> send the trigger which would significantly simplify the code (without
>> timer).
>>
>> Furthermore, if I understand your patch correctly, the LEDs with the
>> names "canX-rx" and "canX-tx" are directly assigned (hardwired). A more
>> flexible method would be appreciated, if it could be realized with just
>> a little more code.
> 
> maybe something familiar to the led netdev trigger (which is afaik
> 'still' not mainline...)
> 
> https://dev.openwrt.org/ticket/2776


Hm - "still not in mainline" is not really nice.

I think the original approach from Fabio was to follow the LED implementation
from mac80211:

"The implementation is similar to the MAC80211_LEDS one, and takes quite a lot
of inspiration and some code from it."

And IMHO we should follow this implementation as it is proved to be used in
high traffic netdev environments. I wonder if some 'generic gpio LED'
implementation will perform sufficiently.

Regards,
Oliver
