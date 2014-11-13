From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: linux-can ISOTP module
Date: Thu, 13 Nov 2014 18:47:48 +0100
Message-ID: <5464EEC4.1080009@hartkopp.net>
References: <loom.20140604T144601-350@post.gmane.org>	<538F6836.3060508@hartkopp.net>	<CAA7hF3w-W1E0E5M4Gkc=0aYB0NQPrOMJfLp-iSG8K8HJU-sdoA@mail.gmail.com>	<539043EA.6030001@artisandeveloppeur.fr>	<5390B575.7030506@hartkopp.net>	<CAA7hF3xomuS-mDRQWmkC=D9YfbDPt+TwXKc7+ZFtUNwkg5cMdQ@mail.gmail.com>	<53A48699.6030605@hartkopp.net> <CAA7hF3yzM8KZjj+4d8m2rUZaDWPuC2hygYZ6PzFz4jWu1Y8e_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:14114 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933296AbaKMRrw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 13 Nov 2014 12:47:52 -0500
In-Reply-To: <CAA7hF3yzM8KZjj+4d8m2rUZaDWPuC2hygYZ6PzFz4jWu1Y8e_A@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: laurent vaudoit <laurent.vaudoit@gmail.com>
Cc: maxime@artisandeveloppeur.fr, linux-can@vger.kernel.org

Hello Laurent,

On 23.06.2014 20:01, laurent vaudoit wrote:
> On Fri, Jun 20, 2014 at 9:08 PM, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>> On 06.06.2014 08:42, laurent vaudoit wrote:
>>
>>>>>> With this method, how can i have a segmented transfer like this:
>>>>>> 0x6a7  0x55 0x10 0x08 ........
>>>>>> 0x687  0xAA 0x30 0x00 0x00
>>>>>> 0x6a7  0x55 0x21 .....
>>>>>>
>>>>>> The connection i need is between two ECU, using IDs 0x6a7/687 and one has
>>>>>> adress extension 0x55, the other 0xAA (this adressing method is used on some
>>>>>> FIAT ECUs for example), but i don't see how it can work using two socket.
>>>>> I confirm.
>>>>> This is a problem that we also encountered on a BMW ECU with the current
>>>>> implementation of ISOTP.
>>>>> The use-case is real and not currently supported.
>>
>> I added the funtionality of a different rx_ext_addr to a specific branch of
>> can-utils and can-modules:
>>
>> https://gitorious.org/linux-can/can-utils/commits/rx_ext_addr
>> https://gitorious.org/linux-can/can-modules/commits/rx_ext_addr
>>
>> Please check them out for a test. As all the isotp tools (in the branch)
>> support the new feature too, it should be easy to do.
> 
> i did not have time for test but regarding the source code, it should be ok.

Did you find some time to check this change?

I would like to move this patch into the master branch before continuing the
development.

Regards,
Oliver
