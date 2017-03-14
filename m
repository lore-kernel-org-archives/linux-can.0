From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: How to get device supported ctrl modes from userspace
Date: Tue, 14 Mar 2017 20:12:27 +0100
Message-ID: <c0f07c21-c59a-6841-7b35-b0ced1994e24@grandegger.com>
References: <CALHGA=t6cpsOBM11Uz4oj9wO-V2ri6cKPGwSRagUXJTfbbQQ0A@mail.gmail.com>
 <4e79021e-0c77-064f-e5d0-98ca089d69f2@grandegger.com>
 <CALHGA=tXJtAH=ygvJZ15xe=Nzs_K-72tP+sF_T4hkBXDSVgLWA@mail.gmail.com>
 <7b7cfdcc-103e-184c-07bf-58d5b5ab74f7@grandegger.com>
 <CALHGA=uGRpakiOu19D-Bj8zmodZRj9-4W4wC-0MJBXzD7jD4ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy02.manitu.net ([217.11.48.66]:47074 "EHLO
        mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbdCNTMb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 14 Mar 2017 15:12:31 -0400
In-Reply-To: <CALHGA=uGRpakiOu19D-Bj8zmodZRj9-4W4wC-0MJBXzD7jD4ag@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Lars Susaas <larssusaas@gmail.com>
Cc: linux-can@vger.kernel.org

Am 14.03.2017 um 17:50 schrieb Lars Susaas:
> On Tue, Mar 14, 2017 at 8:27 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> Am 13.03.2017 um 22:26 schrieb Lars Susaas:
>>>>>
>>>>> I would like find out how to get information about which control modes
>>>>> the device supports from userspace.
>>>>> Ctrlmode as in CAN_CTRLMODE_LISTENONLY
>>>>>
>>>>> In the driver code is looks like it is found in
>>>>> priv->can.ctrlmode_supported, but how do i get it from userspace?
>>>>>
>>>>> I am unable to find any information about this.
>>>>
>>>>
>>>> You could probe the mode. If it's not supported, EOPNOTSUP will be
>>>> returned:
>>>>
>>>>   # ip -d -s link set can0 type can one-shot on
>>>>   RTNETLINK answers: Operation not supported
>>>
>>>
>>> Thanks for the tip, it works!
>>> For the record, trying to turn the modes off instead of on have the
>>> same results and work with can-fd out of the box.
>>
>>
>> Sounds like a bug. Could be a bit more verbose? What does not work?
>
> Using ubuntu 16.10 (Linux 4.8.0-41-generic) and testing with  a
> 'pcan-usb pro fd'
> As far as i can see in the sourcecode it supports triple-sampling,
> listen-only and fd
>
> Just startet the computer and connected the can device
>
> #ip -d -s link set can0 type can fd on
> RTNETLINK answers: Operation not supported
> #ip -d -s link set can0 type can fd off
> (no error)
>
> If I try to turn modes on to test support for fd support i would fail.
> But it looks like i can detect support for fd by trying to turn it off.
>
> I would need the change mtu to be able to turn on fd.
> As i just want to find out if a feature is supported, trying to turn
> it off looks like more universal way of testing
>
> Testing some more to check that it works on other modes to.
> #ip -d -s link set can0 type can loopback on
> RTNETLINK answers: Operation not supported
> #ip -d -s link set can0 type can loopback off
> RTNETLINK answers: Operation not supported
> #ip -d -s link set can0 type can listen-only on
> #ip -d -s link set can0 type can listen-only off
> (no error)
>
> Testing the rest of the modes gives the same result when i try to turn
> it on and off, but fd mode differs.

See:

   http://lxr.free-electrons.com/source/drivers/net/can/dev.c#L847

You need to provide proper bittiming parameters as well. Turning the 
ctrlmode off does nothing if it's not already on.

Wolfgang.
