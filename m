From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: About adding a new CAN-FD driver...
Date: Thu, 17 Nov 2016 11:22:50 +0100
Message-ID: <a901ee28-7872-f1b6-63c8-c6840be4f454@peak-system.com>
References: <d88756ae-0eb8-705d-e6a5-0e4532a8e28c@peak-system.com>
 <6d435ca7-dda2-5213-4fb1-bff663255746@hartkopp.net>
 <59fb4102-64e1-af16-7b98-8ac8e39f78f7@peak-system.com>
 <685ea82c-3457-35b0-0fff-9bfedf83256b@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:35114 "EHLO
        mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752463AbcKQKW6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Nov 2016 05:22:58 -0500
In-Reply-To: <685ea82c-3457-35b0-0fff-9bfedf83256b@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Oliver,

I'm almost ready for pushing the stuff about CAN-FD over our PCIe boards 
but I'm back to you before, because in one of your previous email, you 
talked about "linux/include/linux/can/dev" directory as the better place 
to put a common header file for all of our CAN-FD interfaces.

AFAIK this directory does not exist so far... Did you actually mean 
"linux/include/linux/can"? Or did you expect me to create the "dev" 
subdir with pushing the corresponding patch?

Regards,

Stéphane


Le 25/10/2016 à 10:44, Oliver Hartkopp a écrit :
> Hello Stephane,
>
> On 10/25/2016 09:01 AM, Stephane Grosjean wrote:
>> So I think that
>>
>>  linux/include/linux/can/platform
>>
>> is the most appropriate location for storing some common header file and
>> definitions.
>
> I'm not sure about this directory.
> In 'platform' hardware specific stuff e.g. for SoCs is stored.
>
> As you want to have a place for a CAN controller IP the 'platform' 
> directory seems to be the wrong location.
>
>> What about the code now? I would suggest to do as you did with the
>> SJA1000 controller, that is, creating a common module that will be
>> loaded each time "peak_usb.ko" and/or the new one in charge of PCAN-PCIe
>> FD will be loaded. Is this ok for you?
>
> Don't know whether this is really helpful for the PCAN USB FD driver - 
> but you will find the best abstraction for yourself :-)
>
>> After meeting, we have decided that the name of this new module would be
>> "peak_canfd" (instead of the internal one "ucan"). So, to summarize,
>> what I propose would be:
>>
>> - to add a new file named "peak_canfd.h" into
>> linux/include/linux/can/platform, mainly a "move" of
>
> Better into linux/include/linux/can/dev/
>
>> drivers/net/can/usb/peak_usb/pcan_ucan.h
>>
>> - to add a new directory under "drivers/net/can" named "peak_canfd" that
>> would contain the code of the common module "peak_canfd.ko" as well as
>> the (new) module "peak_pciefd.ko"
>>
>> Are these ok for you?
>
> Yes.
>
> Regards,
> Oliver
>
>
>> Le 18/10/2016 à 09:15, Oliver Hartkopp a écrit :
>>> Hello Stephane,
>>>
>>> thanks for starting the uCAN support for the non-USB hardware types!
>>>
>>> As a third alternative we cloud think about a common place to host
>>> include files that are needed by all drivers.
>>>
>>> Looking into
>>>
>>>     linux/include/linux/can/
>>>
>>> there's dev.h which is needed by all drivers today.
>>>
>>> In
>>>
>>>     linux/include/linux/can/platform
>>>
>>> there are the platform specific infos for some CAN controllers.
>>>
>>> So we could place e.g. a peak_ucan.h in either
>>>
>>>     linux/include/linux/can/
>>> or
>>>     linux/include/linux/can/dev/
>>>
>>> At least this looks more clearly instead of creating unusual
>>> dependencies inside linux/drivers/net/can/
>>>
>>> Any other opinions out there?
>>>
>>> Regards,
>>> Oliver
>>>
>>>
>>> On 10/17/2016 11:42 AM, Stephane Grosjean wrote:
>>>> Hello,
>>>>
>>>> We're planning to add a new driver under drivers/net/can that adds
>>>> support to our PCAN-PCIe FD boards family.
>>>>
>>>> Before pushing any patches, I would first discuss about how and 
>>>> where to
>>>> do that: all of our CAN-FD products actually embed some FPGA 
>>>> running the
>>>> same µCode, internally called "uCAN core". So I first think to 
>>>> create a
>>>> new sub-dir "drivers/net/can/ucan".
>>>>
>>>> But several months ago (Kernel v4.0), we already have pushed a driver
>>>> for our USB CAN-FD adapters, so the new files have been obviously 
>>>> added
>>>> under "driver/net/can/usb/peak_usb". Among these new files,
>>>> "pcan_ucan.h" describes messages exchanged between host and uCAN core,
>>>> whatever the PC interface is (USB, PCie...). So, I can imagine that 
>>>> the
>>>> new driver for PCIe should include this file too, as well as some 
>>>> pieces
>>>> of code present in "peak_usb_fd.c"...
>>>>
>>>> ASFAI, #include "../usb/peak_usb/pcan_ucan.h" is not the proper way to
>>>> do this, isn't it?
>>>>
>>>> So, first of all, I would propose to push some patch(es) in order to
>>>> make things cleaner:
>>>>
>>>> 1/ move file "pcan_ucan.h" from "drivers/net/can/usb/peak_usb" to the
>>>> (newly created) "drivers/net/can/ucan"
>>>>
>>>> 2/ add the corresponding CFLAGS def into
>>>> "drivers/net/can/usb/peak_usb/makefile":
>>>>
>>>> +CFLAGS_pcan_usb_fd.o        += -Idrivers/net/can/ucan
>>>>
>>>> is this the best approach, please?
>>>>
>>>> Thanks for your help.
>>>>
>>>> Stéphane
>>>>
>>>>
>>>> -- 
>>>> PEAK-System Technik GmbH
>>>> Sitz der Gesellschaft Darmstadt - HRB 9183 Geschaeftsfuehrung: A.Gach,
>>>> U.Wilhelm
>>>> -- 
>>>> -- 
>>>> To unsubscribe from this list: send the line "unsubscribe 
>>>> linux-can" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>> -- 
>> PEAK-System Technik GmbH
>> Sitz der Gesellschaft Darmstadt - HRB 9183 Geschaeftsfuehrung: A.Gach,
>> U.Wilhelm
>> -- 
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183 
Geschaeftsfuehrung: A.Gach, U.Wilhelm
--
