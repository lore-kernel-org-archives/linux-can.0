From: Lars Susaas <larssusaas@gmail.com>
Subject: Re: How to get device supported ctrl modes from userspace
Date: Tue, 14 Mar 2017 17:50:29 +0100
Message-ID: <CALHGA=uGRpakiOu19D-Bj8zmodZRj9-4W4wC-0MJBXzD7jD4ag@mail.gmail.com>
References: <CALHGA=t6cpsOBM11Uz4oj9wO-V2ri6cKPGwSRagUXJTfbbQQ0A@mail.gmail.com>
 <4e79021e-0c77-064f-e5d0-98ca089d69f2@grandegger.com> <CALHGA=tXJtAH=ygvJZ15xe=Nzs_K-72tP+sF_T4hkBXDSVgLWA@mail.gmail.com>
 <7b7cfdcc-103e-184c-07bf-58d5b5ab74f7@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35675 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbdCNQub (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 14 Mar 2017 12:50:31 -0400
Received: by mail-pg0-f49.google.com with SMTP id b129so93485532pgc.2
        for <linux-can@vger.kernel.org>; Tue, 14 Mar 2017 09:50:30 -0700 (PDT)
In-Reply-To: <7b7cfdcc-103e-184c-07bf-58d5b5ab74f7@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org

On Tue, Mar 14, 2017 at 8:27 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Am 13.03.2017 um 22:26 schrieb Lars Susaas:
>>>>
>>>> I would like find out how to get information about which control modes
>>>> the device supports from userspace.
>>>> Ctrlmode as in CAN_CTRLMODE_LISTENONLY
>>>>
>>>> In the driver code is looks like it is found in
>>>> priv->can.ctrlmode_supported, but how do i get it from userspace?
>>>>
>>>> I am unable to find any information about this.
>>>
>>>
>>> You could probe the mode. If it's not supported, EOPNOTSUP will be
>>> returned:
>>>
>>>   # ip -d -s link set can0 type can one-shot on
>>>   RTNETLINK answers: Operation not supported
>>
>>
>> Thanks for the tip, it works!
>> For the record, trying to turn the modes off instead of on have the
>> same results and work with can-fd out of the box.
>
>
> Sounds like a bug. Could be a bit more verbose? What does not work?

Using ubuntu 16.10 (Linux 4.8.0-41-generic) and testing with  a
'pcan-usb pro fd'
As far as i can see in the sourcecode it supports triple-sampling,
listen-only and fd

Just startet the computer and connected the can device

#ip -d -s link set can0 type can fd on
RTNETLINK answers: Operation not supported
#ip -d -s link set can0 type can fd off
(no error)

If I try to turn modes on to test support for fd support i would fail.
But it looks like i can detect support for fd by trying to turn it off.

I would need the change mtu to be able to turn on fd.
As i just want to find out if a feature is supported, trying to turn
it off looks like more universal way of testing

Testing some more to check that it works on other modes to.
#ip -d -s link set can0 type can loopback on
RTNETLINK answers: Operation not supported
#ip -d -s link set can0 type can loopback off
RTNETLINK answers: Operation not supported
#ip -d -s link set can0 type can listen-only on
#ip -d -s link set can0 type can listen-only off
(no error)

Testing the rest of the modes gives the same result when i try to turn
it on and off, but fd mode differs.

>>> Thinking about it... It would be nice to list the supported modes with:
>>>
>>>   # ip -d link show can0
>>
>>
>> Yes, that is what i was dreaming/looking for :)
>
>
> The supported feature flag is not yet available trough via netlink
> interface.
I understand and thanks for taking the time to help me out
