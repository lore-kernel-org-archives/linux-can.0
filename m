From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Adding new CAN driver
Date: Sat, 22 Oct 2016 13:57:30 +0200
Message-ID: <ce34a9f7-d310-00aa-6d53-ad08b45cfa3f@hartkopp.net>
References: <CAKT-o-cOb0sqRmvH+BKjX4yvBLp5_GqVd6=ifr2jm5T75-hcZA@mail.gmail.com>
 <c8ba150c-11d2-176c-f3b7-936d89f54de2@hartkopp.net>
 <CAKT-o-cDp0vUY12=Tyv909QC-ZcGpxFKxzSAuf0mrzAojS38Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:40168 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935097AbcJVL5p (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 22 Oct 2016 07:57:45 -0400
In-Reply-To: <CAKT-o-cDp0vUY12=Tyv909QC-ZcGpxFKxzSAuf0mrzAojS38Jw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Hi Remik,

On 10/21/2016 08:47 PM, Kołłątaj, Remigiusz wrote:
>> I was just looking through your code and wondered whether we should support
>> the termination switching feature via 'ip' tool or via sysfs.
>>
>> Just added Marc in CC.
>>
>
> I tried to use 'ip' for setting up termination, but I couldn't find a
> way. If this is possible I will modify the driver as it seems to be
> better idea. Could you give me some hints?

No - not now :-)

That's why I wanted to start the discussion whether we should add this 
kind of feature to 'ip'.

> One more question about the structure of the driver. I have split it
> into source and header files as it was easier to run some tests. I do
> not expect that the header will be useful for other drivers. Shall I
> merge it with source file in final version?

Yes.

Your patch should contain the changes for Kconfig, Makefile and the 
creation of the mcba_usb.c file.

Regards,
Oliver
