From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: How to get device supported ctrl modes from userspace
Date: Tue, 14 Mar 2017 08:27:11 +0100
Message-ID: <7b7cfdcc-103e-184c-07bf-58d5b5ab74f7@grandegger.com>
References: <CALHGA=t6cpsOBM11Uz4oj9wO-V2ri6cKPGwSRagUXJTfbbQQ0A@mail.gmail.com>
 <4e79021e-0c77-064f-e5d0-98ca089d69f2@grandegger.com>
 <CALHGA=tXJtAH=ygvJZ15xe=Nzs_K-72tP+sF_T4hkBXDSVgLWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.66]:50814 "EHLO
        mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbdCNH1P (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 14 Mar 2017 03:27:15 -0400
In-Reply-To: <CALHGA=tXJtAH=ygvJZ15xe=Nzs_K-72tP+sF_T4hkBXDSVgLWA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Lars Susaas <larssusaas@gmail.com>
Cc: linux-can@vger.kernel.org

Am 13.03.2017 um 22:26 schrieb Lars Susaas:
>>> I would like find out how to get information about which control modes
>>> the device supports from userspace.
>>> Ctrlmode as in CAN_CTRLMODE_LISTENONLY
>>>
>>> In the driver code is looks like it is found in
>>> priv->can.ctrlmode_supported, but how do i get it from userspace?
>>>
>>> I am unable to find any information about this.
>>
>> You could probe the mode. If it's not supported, EOPNOTSUP will be returned:
>>
>>   # ip -d -s link set can0 type can one-shot on
>>   RTNETLINK answers: Operation not supported
>
> Thanks for the tip, it works!
> For the record, trying to turn the modes off instead of on have the
> same results and work with can-fd out of the box.

Sounds like a bug. Could be a bit more verbose? What does not work?

>
>> Thinking about it... It would be nice to list the supported modes with:
>>
>>   # ip -d link show can0
>
> Yes, that is what i was dreaming/looking for :)

The supported feature flag is not yet available trough via netlink 
interface.

Wolfgang.
